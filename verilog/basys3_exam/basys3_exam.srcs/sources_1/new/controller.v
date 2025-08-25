`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/11/2025 02:29:56 PM
// Design Name: 
// Module Name: controller
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module fnd_cntr(
    input clk, reset_p,
    input [15:0] fnd_value,
    input hex_bcd,

    output [7:0] seg_7,
    output [3:0] com
    );

    wire [15:0] bcd_value;
    bin_to_dec bcd(
        .bin(fnd_value[11:0]),
        .bcd(bcd_value)
        );

    reg [16:0] clk_div;
    always @(posedge clk)clk_div = clk_div + 1;

    anode_selector ring_com(
        .scan_count(clk_div[16:15]), .an_out(com));
    reg [3:0] digit_value;
    wire [15:0] out_value;
    assign out_value = hex_bcd ? fnd_value : bcd_value;
    always @(posedge clk or posedge reset_p) begin
        if(reset_p)begin
            digit_value = 0;
        end
        else begin
            case (com)
                4'b1110 : digit_value = out_value[3:0];
                4'b1101 : digit_value = out_value[7:4];
                4'b1011 : digit_value = out_value[11:8];
                4'b0111 : digit_value = out_value[15:12];
                
            endcase
        end
    end
    // seg_decoder dec(.digit_in(digit_value), .seg_out(seg_7));    // original
    calcuator_seg_decoder dec(.digit_in(digit_value), .seg_out(seg_7)); // calculator
endmodule


module debounce (
    input clk,
    input btn_in,
    output reg btn_out
);

    reg [15:0] count;
    reg btn_sync_0, btn_sync_1;
    wire stable = (count == 16'hFFFF);

    always @(posedge clk) begin
        btn_sync_0 <= btn_in;
        btn_sync_1 <= btn_sync_0;
    end

    always @(posedge clk) begin
        if(btn_sync_1 == btn_out) begin
            count <= 0;
        end else begin
            count <= count + 1;
            if(stable)
                btn_out <= btn_sync_1;
        end
    end

endmodule

module btn_cntr (
    input clk, reset_p,
    input btn,
    output btn_pedge, btn_nedge
);
    wire debounce_btn;

    debounce btn_0(
        .clk(clk), 
        .btn_in(btn), 
        .btn_out(debounce_btn)
        );

    edge_detector_p btn_ed(
        .clk(clk), 
        .reset_p(reset_p), 
        .cp(debounce_btn),
        .p_edge(btn_pedge), 
        .n_edge(btn_nedge)
    );

endmodule

module dht11_cntr (
    input clk, reset_p,
    inout dht11_data,   // 주의점 : 나도 output하는 얘도 output이면 충돌남.
                        // 0,1 출력할때만 0, 1 써주고 그외에는 다 임피던스
                        // input은 reg 선언이 안되고 output으로 쓰려면 reg가 필요함.
                        // 그래서 어떻게 해야되나? 따로 reg를 선언해야함
    output reg [7:0] humidity, temperature,
    output [15:0] led
    );
    
    // 이 코드의 핵심 : FSM을 어떻게 쓰는지. 디스코드 캡쳐샷 참고(상태천이도). 링카운터(단순히 돌기만함)와 비교
    localparam S_IDLE      = 6'b00_0001;    // 덧셈기를 만들면 더 낭비된다.
    localparam S_LOW_18MS  = 6'b00_0010;    // 6비트로 하는게 자원소모가 덜 된다.
    localparam S_HIGH_20US = 6'b00_0100;
    localparam S_LOW_80US  = 6'b00_1000;
    localparam S_HIGH_80US = 6'b01_0000;    // ASM : 이상태를 일일이 다 만들어주는것
    localparam S_READ_DATA = 6'b10_0000;    // LOW, HIGH를 40번 반복하는것을 하나로 만들어놨다
                                            // FSM : 좀더 소프트웨어 스럽게 하는것
    localparam S_WAIT_PEDGE = 2'b01;        // 데이터시트의 Figure 4 Data "0" Indication
    localparam S_WAIT_NEDGE = 2'b10;

    wire clk_usec_nedge;
    clock_div_100 us_clk(
        .clk(clk), 
        .reset_p(reset_p),
        .nedge_div_100(clk_usec_nedge)
        );

    reg [21:0] count_usec;
    reg count_usec_e;
    always @(negedge clk, posedge reset_p) begin
        if (reset_p) begin
            count_usec = 0;
        end
        else if (clk_usec_nedge && count_usec_e) begin
            count_usec = count_usec + 1; // enable이 1일때만?
        end
        else if (!count_usec_e) begin
            count_usec = 0; // clear
        end
        
    end

    wire dht_nedge, dht_pedge;
    edge_detector_p dht_ed(
        .clk(clk), 
        .reset_p(reset_p), 
        .cp(dht11_data),
        .p_edge(dht_pedge),
        .n_edge(dht_nedge)
    );

    reg dht11_buffer;       // inout일때 따로 reg선언
    reg dht11_data_out_e;
    assign dht11_data = dht11_data_out_e ? dht11_buffer : 'bz;
    // 출력으로 내보낼때만 0 or 1, 임피던스로 내보낸다 = 출력을 끊는다.

    reg [5:0] state, next_state;
    assign led[5:0] = state;
    reg [1:0] read_state;
    always @(negedge clk, posedge reset_p) begin
        if (reset_p) begin
            state = S_IDLE;
        end
        else begin
            state = next_state;
        end
    end

    reg [39:0] temp_data;
    reg [5:0] data_count;   // 40개 받으면 끝내야되니까 필요함
    assign led[11:6] = data_count;
    always @(posedge clk, posedge reset_p) begin
        if (reset_p) begin
            next_state = S_IDLE;
            temp_data = 0;
            data_count = 0;
            dht11_data_out_e = 0;
            read_state = S_WAIT_PEDGE;
        end
        else begin
            case (state)    
            // case문은 데이터 시트의 Figure 3 MCU Sends out Start Signal & DHT Responses 보고작성
                S_IDLE: begin
                    if (count_usec < 22'd3_000_000) begin  // 3_000_000 3초에 한번씩 측정하겠다
                        count_usec_e = 1;
                        dht11_data_out_e = 0; // clk에 의해 하이가 유지되게
                    end
                    else begin // else라는것은 3초가 됐단소리
                        count_usec_e = 0;
                        next_state = S_LOW_18MS; // clk posedge에서 바뀜
                    end
                end
                S_LOW_18MS: begin
                    if (count_usec < 22'd18_000) begin // 18_000 18ms 동안 0이 출력
                        count_usec_e = 1;
                        dht11_data_out_e = 1;
                        dht11_buffer = 0;
                    end
                    else begin // 18ms 가 지나고
                        count_usec_e = 0;
                        next_state = S_HIGH_20US;
                        dht11_data_out_e = 0; // 임피던스 출력
                    end
                end
                S_HIGH_20US: begin
                    // if (count_usec < 22'd20) begin // 20us
                    //     count_usec_e = 1;
                    // end
                    // else begin
                    count_usec_e = 1;
                    if (count_usec > 22'd100_00) begin
                        count_usec_e = 0;
                        next_state = S_IDLE;
                    end
                    if (dht_nedge) begin
                        next_state = S_LOW_80US;
                        count_usec_e = 0;
                    end
                    //end
                end
                S_LOW_80US: begin
                    count_usec_e = 1;
                    if (count_usec > 22'd100_00) begin
                        count_usec_e = 0;
                        next_state = S_IDLE;
                    end
                    if (dht_pedge) begin
                        next_state = S_HIGH_80US;
                        count_usec_e = 0;
                    end
                end
                S_HIGH_80US: begin
                    count_usec_e = 1;
                    if (count_usec > 22'd100_00) begin
                        count_usec_e = 0;
                        next_state = S_IDLE;
                    end
                    if (dht_nedge) begin
                        next_state = S_READ_DATA;
                        count_usec_e = 0;
                    end
                end
                S_READ_DATA: begin // 데이터시트의 Figure 4 Data "0" Indication
                    case (read_state) // 40번 반복해야함
                        S_WAIT_PEDGE: begin
                            if (dht_pedge) begin
                                read_state = S_WAIT_NEDGE;
                                count_usec_e = 0;
                            end
                        end
                        S_WAIT_NEDGE: begin
                            if (dht_nedge) begin
                                read_state = S_WAIT_PEDGE;
                                data_count = data_count + 1;    // 40번 했나 세기
                                if (count_usec < 50) begin // 5. Communication Process: Serial Interface (Single-Wire Two-Way)
                                    temp_data = {temp_data[38:0], 1'b0};                   // higher data bit first. 이지만 하위 비트로 해서 올려줌(?)
                                end
                                else begin
                                    temp_data = {temp_data[38:0], 1'b1};
                                end
                            end
                            else begin
                                count_usec_e = 1;
                                if (count_usec > 22'd100_000) begin
                                    count_usec_e = 0;
                                    next_state = S_IDLE;
                                    data_count = 0;
                                    read_state = S_WAIT_PEDGE;
                                end
                            end
                        end
                    endcase
                    if (data_count >= 40) begin
                        next_state = S_IDLE;
                        data_count = 0;
                        if (temp_data[39:32] + temp_data[31:24] + temp_data[23:16] + temp_data[15:8] == temp_data[7:0]) begin // 추가된 코드 (근데 뭐지?)
                            humidity = temp_data[39:32];
                            temperature = temp_data[23:16];
                        end
                    end
                end
                default: next_state = S_IDLE; // 없어도됨
            endcase
        end
    end
endmodule

module HC_SR04_fixed(
    input clk, reset_p,
    input echo,
    output reg trigger,
    output reg [15:0] distance
    );
    
    // FSM 상태 정의
    localparam H_IDLE = 3'b000;
    localparam H_TRIG_10US = 3'b001;
    localparam H_WAIT_ECHO = 3'b010;
    localparam H_CAL_DISTANCE = 3'b011;

    // FSM 상태 변수 (순차 논리)
    reg [2:0] state;

    // 카운터 및 기타 변수 (순차 논리)
    reg [15:0] count_usec;
    reg [15:0] count_echo_pulse;
    reg trigger_internal; // 내부용 트리거 신호
    
    //-----------------------------------------------------
    // 상태 업데이트 (순차 논리, 하나의 always 블록)
    //-----------------------------------------------------
    always @(posedge clk or posedge reset_p) begin
        if (reset_p) begin
            state <= H_IDLE;
            count_usec <= 0;
            count_echo_pulse <= 0;
            trigger <= 0;
            distance <= 0;
        end
        else begin
            // 상태 전이 로직
            case(state)
                H_IDLE: begin
                    if (count_usec >= 60000) begin // 60ms 대기 (datasheet 권장)
                        state <= H_TRIG_10US;
                        count_usec <= 0;
                    end
                    else begin
                        count_usec <= count_usec + 1;
                    end
                end
                
                H_TRIG_10US: begin
                    trigger <= 1; // 10us 동안 trigger ON
                    if (count_usec >= 10) begin
                        state <= H_WAIT_ECHO;
                        count_usec <= 0;
                        trigger <= 0;
                    end
                    else begin
                        count_usec <= count_usec + 1;
                    end
                end
                
                H_WAIT_ECHO: begin
                    // 이 부분에 echo 신호에 따른 카운트 및 다음 상태 전이 로직
                    // echo의 상승/하강 엣지를 감지하여 count_echo_pulse를 시작/중단
                    // 예: if(echo) count_echo_pulse <= count_echo_pulse + 1;
                    //     else if (count_echo_pulse > 0) state <= H_CAL_DISTANCE;
                end
                
                H_CAL_DISTANCE: begin
                    // 거리 계산 및 초기화
                    // distance <= count_echo_pulse / 58; 나누기를 안하려면? 아래문장?
                    distance <= count_echo_pulse[21:1] / 29;
                    state <= H_IDLE;
                end
            endcase
        end
    end

    //-----------------------------------------------------
    // 보조적인 동기식 논리 (필요한 경우)
    //-----------------------------------------------------
    // echo 펄스 길이를 측정하는 로직
    always @(posedge clk) begin
        if (state == H_WAIT_ECHO && echo) begin
            count_echo_pulse <= count_echo_pulse + 1;
        end
        else if (state != H_WAIT_ECHO) begin
            count_echo_pulse <= 0;
        end
    end
    
endmodule

module keypad_cntr (
    input clk, reset_p,
    input [3:0] row,

    output reg [3:0] column,
    output reg [3:0] key_value,
    output reg key_valid,
    output reg [15:0] led
);

    localparam [4:0] SCAN_0       = 5'b00001;
    localparam [4:0] SCAN_1       = 5'b00010;
    localparam [4:0] SCAN_2       = 5'b00100;
    localparam [4:0] SCAN_3       = 5'b01000;
    localparam [4:0] KEY_PROCESS  = 5'b10000;

    reg [19:0] clk_10ms;    // 15번 비트를 쓰면 더 빠르게 스캔
    always @(posedge clk) begin
        clk_10ms = clk_10ms + 1;
    end

    wire clk_10ms_nedge, clk_10ms_pedge;
    edge_detector_p ms_10_ed(
        .clk(clk), 
        .reset_p(reset_p), 
        .cp(clk_10ms[19]),
        .p_edge(clk_10ms_pedge),
        .n_edge(clk_10ms_nedge)
    );

    reg [4:0] state, next_state;
    always @(posedge clk, posedge reset_p) begin    // 플립플롭
        if (reset_p) begin
            state = SCAN_0;
        end
        else if (clk_10ms_pedge)begin
            state = next_state;
        end
    end

    always @(*) begin       // * : 항상실행. 엣지를 안씀 : 조합회로
        case (state)
            SCAN_0      : begin
                if (row == 0) begin
                    next_state = SCAN_1;
                end
                else begin
                    next_state = KEY_PROCESS;
                end
            end 
            SCAN_1      : begin
                if (row == 0) begin
                    next_state = SCAN_2;
                end
                else begin
                    next_state = KEY_PROCESS;
                end
            end 
            SCAN_2      : begin
                if (row == 0) begin
                    next_state = SCAN_3;
                end
                else begin
                    next_state = KEY_PROCESS;
                end
            end 
            SCAN_3      : begin
                if (row == 0) begin
                    next_state = SCAN_0;
                end
                else begin
                    next_state = KEY_PROCESS;
                end
            end 
            KEY_PROCESS  : begin    
                if (row == 0) begin
                    next_state = SCAN_0;
                end
                else begin
                    next_state = KEY_PROCESS;
                end
            end
            default: next_state = KEY_PROCESS; 
        endcase
    end

    always @(posedge clk, posedge reset_p) begin
        if (reset_p) begin
            column = 4'b0001;
            key_value = 0;
            key_valid = 0;
        end
        else if (clk_10ms_nedge)begin
            case (state)
                SCAN_0      : begin
                    column = 4'b0001;
                    key_valid = 0;
                end

                SCAN_1      : begin
                    column = 4'b0010;
                    key_valid = 0;
                end

                SCAN_2      : begin
                    column = 4'b0100;
                    key_valid = 0;
                end

                SCAN_3      : begin
                    column = 4'b1000;
                    key_valid = 0;
                end

                // KEY_PROCESS : begin  // original
                //     key_valid = 1;
                //     case ({column, row})
                //         8'b0001_0001: key_value = 4'h0;
                //         8'b0001_0010: key_value = 4'h1;
                //         8'b0001_0100: key_value = 4'h2;
                //         8'b0001_1000: key_value = 4'h3; 
                //         8'b0010_0001: key_value = 4'h4;
                //         8'b0010_0010: key_value = 4'h5;
                //         8'b0010_0100: key_value = 4'h6;
                //         8'b0010_1000: key_value = 4'h7;
                //         8'b0100_0001: key_value = 4'h8;
                //         8'b0100_0010: key_value = 4'h9;
                //         8'b0100_0100: key_value = 4'hA;
                //         8'b0100_1000: key_value = 4'hb;
                //         8'b1000_0001: key_value = 4'hC;
                //         8'b1000_0010: key_value = 4'hd;
                //         8'b1000_0100: key_value = 4'hE;
                //         8'b1000_1000: key_value = 4'hF;
                //     endcase
                // end
                KEY_PROCESS : begin // calculator
                    key_valid = 1;
                    case ({column, row})
                        8'b0001_0001: key_value = 4'h7;
                        8'b0001_0010: key_value = 4'h8;
                        8'b0001_0100: key_value = 4'h9;
                        8'b0001_1000: key_value = 4'hA; // +
                        8'b0010_0001: key_value = 4'h4;
                        8'b0010_0010: key_value = 4'h5;
                        8'b0010_0100: key_value = 4'h6;
                        8'b0010_1000: key_value = 4'hb; // -
                        8'b0100_0001: key_value = 4'h1;
                        8'b0100_0010: key_value = 4'h2;
                        8'b0100_0100: key_value = 4'h3;
                        8'b0100_1000: key_value = 4'hE; // *
                        8'b1000_0001: key_value = 4'hC;
                        8'b1000_0010: key_value = 4'h0;
                        8'b1000_0100: key_value = 4'hF; // =
                        8'b1000_1000: key_value = 4'hd; // /
                    endcase
                end
                
            endcase
        end
    end

endmodule

module I2C_master (    // IIC가 정식명칭
// 이 모듈은 100khz 로 i2c 통신
    input clk, reset_p,
    input [6:0] addr,   // 데이터 보낼 주소
    input [7:0] data,
    input rd_wr, comm_start,

    output reg scl, sda,    // 클럭과 데이터. sda는 사실 inout을 써야하지만 데이터를 보내기만할거라 아웃풋으로함
    output [15:0] led   // debugging
);
    
    localparam IDLE         = 7'b000_0001;
    localparam COMM_START   = 7'b000_0010;
    localparam SEND_ADDR    = 7'b000_0100;
    localparam RD_ACK       = 7'b000_1000;
    localparam SEND_DATA    = 7'b001_0000;
    localparam SCL_STOP     = 7'b010_0000;
    localparam COMM_STOP    = 7'b100_0000;

    wire clk_usec_nedge;
    clock_div_100 us_clk(
        .clk(clk), 
        .reset_p(reset_p),
        .nedge_div_100(clk_usec_nedge)
        );

    wire comm_start, comm_start_pedge;
    edge_detector_p comm_start_ed(
        .clk(clk), 
        .reset_p(reset_p), 
        .cp(comm_start),
        .p_edge(comm_start_pedge)
    );

    wire scl_nedge, scl_pedge;
    edge_detector_p scl_ed(
        .clk(clk), 
        .reset_p(reset_p), 
        .cp(scl),
        .p_edge(scl_pedge),
        .n_edge(scl_nedge)
    );

    // 5us 마다 토글
    reg [2:0] count_usec5;
    reg scl_e;
    always @(posedge clk, posedge reset_p) begin
        if (reset_p) begin
            count_usec5 = 0;
            scl = 0;
        end
        else if(scl_e)begin
            if (clk_usec_nedge) begin
                if (count_usec5 >= 4) begin
                    count_usec5 = 0;
                    scl = ~scl;
                end
                else begin
                    count_usec5 = count_usec5 + 1;
                end 
            end
        end
        else if (!scl_e) begin
            count_usec5 = 0;
            scl = 1;
        end
    end

    reg [6:0] state, next_state;
    always @(negedge clk, posedge reset_p) begin
        if (reset_p) begin
            state = IDLE;
        end
        else begin
            state = next_state;
        end
    end

    wire [7:0] addr_rd_wr;
    assign addr_rd_wr = {addr, rd_wr};
    reg [2:0] cnt_bit;
    reg stop_flag;

    always @(posedge clk, posedge reset_p) begin
        if (reset_p) begin
            next_state = IDLE;
            scl_e = 0;
            sda = 1;
            cnt_bit = 7;
            stop_flag = 0;
        end
        else begin
            case (state)
                IDLE        : begin
                    scl_e = 0;
                    sda = 1;
                    if (comm_start_pedge) begin //통신시작
                        next_state = COMM_START;
                    end
                end
                COMM_START  : begin
                    sda = 0;
                    scl_e = 1;  // scl이 움직이기 시작
                    next_state = SEND_ADDR;
                end
                SEND_ADDR   : begin // 최상위 비트부터 보냄
                    if (scl_nedge) begin // low상태
                        sda = addr_rd_wr[cnt_bit];
                    end
                    if (scl_pedge) begin
                        if (cnt_bit == 0) begin
                            cnt_bit = 7;
                            next_state = RD_ACK;
                        end
                        else begin
                            cnt_bit = cnt_bit - 1;
                        end 
                    end
                end
                RD_ACK      : begin
                    if (scl_nedge) begin
                        sda = 'bz; // 출력연결을 끊겠다. 임피던스
                    end
                    else if (scl_pedge) begin
                        next_state = SEND_DATA;
                        if (stop_flag) begin
                            stop_flag = 0;
                            next_state = SCL_STOP;
                        end
                        else begin
                            stop_flag = 1;
                            next_state = SEND_DATA;
                        end
                    end    
                end
                SEND_DATA   : begin
                    if (scl_nedge) begin
                        sda = data[cnt_bit];
                    end
                    if (scl_pedge) begin
                        if (cnt_bit == 0) begin
                            cnt_bit = 7;
                            next_state = RD_ACK;
                        end
                        else begin
                            cnt_bit = cnt_bit - 1;
                        end
                    end
                end
                SCL_STOP    : begin
                    if (scl_nedge) begin
                        sda = 0;
                    end
                    if (scl_pedge) begin
                        next_state = COMM_STOP;
                    end
                end
                COMM_STOP   : begin
                    // 0 에서 1 바로 주면 상승엣지를 바로 못받음
                    // 따라서 조금 기다려야함
                    if (count_usec5 >= 3) begin
                        scl_e = 0;
                        sda = 1;
                        next_state = IDLE;
                    end
                end
            endcase
        end
    end

endmodule

module i2c_lcd_send_byte (
    input clk, reset_p,
    input [6:0] addr,
    input [7:0] send_buffer,
    input send, rs,

    output scl, sda,
    output reg busy,
    output [15:0] led
);
    
    localparam IDLE                     = 6'b00_0001;
    localparam SEND_HIGH_NIBBLE_DISABLE = 6'b00_0010;
    localparam SEND_HIGH_NIBBLE_ENABLE  = 6'b00_0100; // 하위 4비트, ENABLE 1주기
    localparam SEND_LOW_NIBBLE_DISABLE  = 6'b00_1000;
    localparam SEND_LOW_NIBBLE_ENABLE   = 6'b01_0000;
    localparam SEND_DISABLE             = 6'b10_0000;

    // 딜레이를 위한 클락
    wire clk_usec_nedge;
    clock_div_100 us_clk(
        .clk(clk), 
        .reset_p(reset_p),
        .nedge_div_100(clk_usec_nedge)
        );
    
    reg [7:0] data;
    reg comm_start;

    wire send_pedge;
    edge_detector_p send_ed(
        .clk(clk), 
        .reset_p(reset_p), 
        .cp(send),
        .p_edge(send_pedge)
    );

    reg [21:0] count_usec;
    reg count_usec_e;
    always @(negedge clk, posedge reset_p) begin
        if (reset_p) begin
            count_usec = 0;
        end
        else if (clk_usec_nedge && count_usec_e) begin
            count_usec = count_usec + 1; // enable이 1일때만?
        end
        else if (!count_usec_e) begin
            count_usec = 0; // clear
        end
    end

    I2C_master master(    
        clk, 
        reset_p,
        addr,   
        data, 1'b0,              // 1'b0 이유는?
        comm_start,
        scl, sda,   
    );

    reg [5:0] state, next_state;
    always @(negedge clk, posedge reset_p) begin
        if (reset_p) begin
            state = IDLE;
        end
        else begin
            state = next_state;
        end
    end

    always @(posedge clk, posedge reset_p) begin
        if (reset_p) begin
            next_state = IDLE;
            comm_start = 0;
            count_usec_e = 0;
            data = 0;
            busy = 0;
        end
        else begin
            case (state)
                IDLE                    : begin // send입력
                    if (send_pedge) begin
                        next_state = SEND_HIGH_NIBBLE_DISABLE;
                        busy = 1;   // 통신넘어가는 순간 busy = 1
                    end
                end
                SEND_HIGH_NIBBLE_DISABLE: begin
                    if (count_usec <= 22'd200) begin    // 통신이 다 될때까지 여유있게 200us 기다리기
                        // d7 d6 d5 d4      BL en rw rs
                        data = {send_buffer[7:4], 3'b100, rs};
                        comm_start = 1;
                        count_usec_e = 1;
                    end
                    else begin
                        next_state = SEND_HIGH_NIBBLE_ENABLE;
                        count_usec_e = 0;
                        comm_start = 0;
                    end        
                end
                SEND_HIGH_NIBBLE_ENABLE : begin
                     if (count_usec <= 22'd200) begin    // 통신이 다 될때까지 여유있게 200us 기다리기
                        // d7 d6 d5 d4      BL en rw rs
                        data = {send_buffer[7:4], 3'b110, rs};
                        comm_start = 1;
                        count_usec_e = 1;
                    end
                    else begin
                        next_state = SEND_LOW_NIBBLE_DISABLE;
                        count_usec_e = 0;
                        comm_start = 0;
                    end 
                end
                SEND_LOW_NIBBLE_DISABLE : begin
                     if (count_usec <= 22'd200) begin    // 통신이 다 될때까지 여유있게 200us 기다리기
                        // d7 d6 d5 d4      BL en rw rs
                        data = {send_buffer[3:0], 3'b100, rs};
                        comm_start = 1;
                        count_usec_e = 1;
                    end
                    else begin
                        next_state = SEND_LOW_NIBBLE_ENABLE;
                        count_usec_e = 0;
                        comm_start = 0;
                    end 
                    
                end
                SEND_LOW_NIBBLE_ENABLE  : begin
                    if (count_usec <= 22'd200) begin    // 통신이 다 될때까지 여유있게 200us 기다리기
                        // d7 d6 d5 d4      BL en rw rs
                        data = {send_buffer[3:0], 3'b110, rs};
                        comm_start = 1;
                        count_usec_e = 1;
                    end
                    else begin
                        next_state = SEND_DISABLE;
                        count_usec_e = 0;
                        comm_start = 0;
                    end 
                    
                end
                SEND_DISABLE            : begin
                    if (count_usec <= 22'd200) begin    // 통신이 다 될때까지 여유있게 200us 기다리기
                        // d7 d6 d5 d4      BL en rw rs
                        data = {send_buffer[7:4], 3'b100, rs};
                        comm_start = 1;
                        count_usec_e = 1;
                    end
                    else begin
                        next_state = IDLE;
                        count_usec_e = 0;
                        comm_start = 0;
                        busy = 0;   // 통신이 끝나서 busy = 0
                    end 
                end
                
            endcase
        end
    end

endmodule

module pwm_Nfreq_Nstep (
    input clk, reset_p,
    input [31:0] duty,   // 0 ~ 127 밝기 조절

    output reg pwm
);
    
    parameter sys_clk_freq = 100_000_000;   
    parameter pwm_freq = 10_000;    // 1만 정도가 적당함, 모터면 알맞게 조정하기
    parameter duty_step_N = 200;    // default값
    parameter temp = sys_clk_freq / pwm_freq / duty_step_N / 2;

    integer cnt;
    reg pwm_freqXn;
    always @(posedge clk, posedge reset_p) begin
        if (reset_p) begin
            cnt = 0;
            pwm_freqXn = 0;
        end
        else begin
            if (cnt >= temp - 1) begin
                cnt = 0;
                pwm_freqXn = ~pwm_freqXn;
            end
            else begin
                cnt = cnt + 1;
            end
        end
    end

    wire pwm_freqXn_nedge;
    edge_detector_p pwm_freqXn_ed(
        .clk(clk), 
        .reset_p(reset_p), 
        .cp(pwm_freqXn),
        .n_edge(pwm_freqXn_nedge)
    );

    // reg [6:0] cnt_duty; // 128 일때
    integer cnt_duty;   // 200 일때.
    always @(posedge clk, posedge reset_p) begin
        if (reset_p) begin
            cnt_duty = 0;
            pwm = 0;
        end
        else if (pwm_freqXn_nedge) begin
            if (cnt_duty >= duty_step_N) begin
                cnt_duty = 0;
            end
            else begin
                cnt_duty = cnt_duty + 1;
            end
            if (cnt_duty < duty) begin // duty(0~127)로 펄스폭 제어,(ex : 5를 주면 5/128)
                pwm = 1;
            end
            else begin
                pwm = 0;
            end
        end
    end

endmodule