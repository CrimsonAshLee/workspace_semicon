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
        .bcd(sec_bcd)
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
    seg_decoder dec(.digit_in(digit_value), .seg_out(seg_7)
    );

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