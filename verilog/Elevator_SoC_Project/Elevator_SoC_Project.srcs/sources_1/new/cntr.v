`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/18/2025 04:44:36 PM
// Design Name: 
// Module Name: cntr
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

module edge_detector_n(
    input clk,
    input reset_p,
    input cp,
    
    output p_edge,
    output n_edge

    );

    reg ff_cur, ff_old;

    always @(negedge clk or posedge reset_p) begin
        if(reset_p) begin
            ff_cur <= 0;
            ff_old <= 0;
        end else begin

            ff_old <= ff_cur;   //  <= 이것의 의미는 논블러킹, = 은 블러킹
            ff_cur <= cp;       // 블러킹, 논블러킹은 혼합해서 쓰지말고 하나만 쓰도록한다.
                                // 블러킹을 써야하는 상황, 논블러킹을 써야되는 상황이 있어서 따져봐야함

            // ff_old = ff_cur; // 블러킹을 쓰더라도 순서를 잘잡아주면 상관이 없긴하다.
            // ff_cur = cp;
        end
    end

    assign p_edge = ({ff_cur, ff_old} == 2'b10) ? 1 : 0;
    assign n_edge = ({ff_cur, ff_old} == 2'b01) ? 1 : 0;
endmodule

    // cur = 1, old = 0 => p = 1
    // cur = 1, old = 1 => p = 0
    // cur = 0, old = 1 => n = 1


module edge_detector_p(
    input clk,
    input reset_p,
    input cp,
    
    output p_edge,
    output n_edge

    );

    reg ff_cur, ff_old;

    always @(posedge clk or posedge reset_p) begin
        if(reset_p) begin
            ff_cur <= 0;
            ff_old <= 0;
        end else begin
            ff_old <= ff_cur;
            ff_cur <= cp;
        end
    end

    assign p_edge = ({ff_cur, ff_old} == 2'b10) ? 1'b1 : 1'b0;
    assign n_edge = ({ff_cur, ff_old} == 2'b01) ? 1'b1 : 1'b0;
endmodule

module sn74hc595_cntr(
    input clk, reset_p,
    input [7:0] data_in,    // 모듈에 직접 8비트 데이터 입력 받아서 그걸 595의 SER(시리얼 입력)핀에 보내줄거임
    output reg srclk,       // 데이터 송,수신 동기화를 위해 클럭 생성
    output reg rclk,        // 데이터 송신 끝을 알리는 래치 핀 
    output reg ser          // 이걸로 모듈에서 입력받은 데이터 보내줄거 
    );
    
    // 시스템 클락 분주                            
    integer delay_time;                            
    always @(posedge clk, posedge reset_p) begin
        if(reset_p) begin
            delay_time <= 0;
            srclk <= 0;
        end else begin
            if(delay_time >= 9) begin         // 5Mhz로 분주, 595 데이터시트에 Vcc에 2V 들어오면 최대 5Mhz에서 작동한다고 써있음
                srclk <= ~srclk;
                delay_time <= 0;
            end else begin
                delay_time <= delay_time + 1;
            end
        end
    end
    
    // 엣지디텍터로 5Mhz까지 분주한 클락 엣지 잡음 
    wire clk_5Mhz_pe;
    wire clk_5Mhz_ne;     
    edge_detector_p divclk_ed(
        .clk(clk),
        .reset_p(reset_p),
        .cp(srclk),
        .p_edge(clk_5Mhz_pe),
        .n_edge(clk_5Mhz_ne)
    );
    
    
    // 실제 데이터 보내는 구문
    integer cnt_data; 
    always @(posedge clk, posedge reset_p) begin
        if(reset_p) begin
            rclk <= 0;
            ser <= 0; 
            cnt_data <= 0; 
        end else begin
            if(clk_5Mhz_pe) begin               // 위에서 분주한 5Mhz 클럭 라이징엣지 뜰 때 맞춰서 데이터 보낼거임
                if(cnt_data >= 8) begin         // 데이터 카운트 다 끝나면(8비트 다 보내면)
                    cnt_data <= 0;              // 카운트 0으로 초기화
                    rclk <= 1;                  // rclk(래치) high로 띄워서 레지스터에 넣은 값 출력
                end else begin
                    cnt_data <= cnt_data + 1;   // 8개 다 안보냈으면 보내면서 카운팅
                    rclk <= 0;                  // 아직 다 안보냈으니까 래치핀 low로 유지
                    
                    case(cnt_data)
                        0 : ser <= data_in[7];  // 카운트 0이면 모듈 입력 데이터의 0번 비트부터 595 시리얼 입력핀으로 보냄(LSB부터 보냄)
                        1 : ser <= data_in[6];  // 카운트 1이면 입력 데이터의 1번 비트 보냄
                        2 : ser <= data_in[5];
                        3 : ser <= data_in[4];
                        4 : ser <= data_in[3];  // ....
                        5 : ser <= data_in[2];
                        6 : ser <= data_in[1];
                        7 : ser <= data_in[0];  // 카운트 7이면 입력 데이터의 7번 비트(MSB) 시리얼 입력핀으로 보냄               
                    endcase
                end
            end
        end
    end
    
endmodule

module seg_cntr_v1(
    input clk,
    input reset_p,
    input [3:0] control, // 4개의 스위치 입력
    output srclk,
    output rclk,
    output ser
);

    reg [7:0] data_out;
    always @(posedge clk, posedge reset_p) begin
        
        if (reset_p) begin
            data_out <= 8'b0000_0000;
        end
        else begin
            case(control)
                4'b0001: data_out = 8'b0000_0110; // '1' (dp, g, f, e, d, c, b, a)
                4'b0010: data_out = 8'b0101_1011; // '2'
                4'b0011: data_out = 8'b0100_1111; // '3'
                4'b0100: data_out = 8'b0110_0110; // '4'
                4'b0101: data_out = 8'b0110_1101; // '5'
                4'b0110: data_out = 8'b0111_1101; // '6'
                4'b0111: data_out = 8'b0000_0111; // '7'
                4'b1000: data_out = 8'b0111_1111; // '8'
                4'b1001: data_out = 8'b0110_0111; // '9'
                4'b0000: data_out = 8'b0011_1111; // '0'
                4'b1010: data_out = 8'b1000_0000; // 'dp'
                default: data_out = 8'b0000_0000; // 모든 스위치 OFF일 때
            endcase
        end
    
    end

    sn74hc595_cntr sn595_inst (
        .clk(clk),
        .reset_p(reset_p),
        .data_in(data_out),
        .srclk(srclk),
        .rclk(rclk),
        .ser(ser)
    );

endmodule

module seg_cntr(
    input clk,
    input reset_p,
    input common_mode,       // 하드웨어 애노드 캐소드 공통 바꿀 필요 없이 다 쓸수있게 할거
    input [3:0] control,
    output srclk,
    output rclk,
    output ser
);

    reg [7:0] data_out;
    always @(posedge clk, posedge reset_p) begin
    
        if(reset_p) begin
            data_out <= 8'b0000_0000;
        end else begin
            if(common_mode) begin                     // 캐소드 공통일때(1줘야 켜지는 애들)
                case(control)
                    4'b0001: data_out = 8'b0000_0110; // '1' (dp, g, f, e, d, c, b, a)
                    4'b0010: data_out = 8'b0101_1011; // '2'
                    4'b0011: data_out = 8'b0100_1111; // '3'
                    4'b0100: data_out = 8'b0110_0110; // '4'
                    4'b0101: data_out = 8'b0110_1101; // '5'
                    4'b0110: data_out = 8'b0111_1101; // '6'
                    4'b0111: data_out = 8'b0000_0111; // '7'
                    4'b1000: data_out = 8'b0111_1111; // '8'
                    4'b1001: data_out = 8'b0110_0111; // '9'
                    4'b0000: data_out = 8'b0011_1111; // '0'
                    4'b1010: data_out = 8'b1000_0000; // 'dp'
                    default: data_out = 8'b0000_0000; // 모든 스위치 OFF일 때
                endcase
            end else begin                            // 애노드 공통일때(0줘야 켜지는 애들)
                case(control)
                    4'b0001: data_out = ~(8'b0000_0110); // '1' (dp, g, f, e, d, c, b, a)
                    4'b0010: data_out = ~(8'b0101_1011); // '2'
                    4'b0011: data_out = ~(8'b0100_1111); // '3'
                    4'b0100: data_out = ~(8'b0110_0110); // '4'
                    4'b0101: data_out = ~(8'b0110_1101); // '5'
                    4'b0110: data_out = ~(8'b0111_1101); // '6'
                    4'b0111: data_out = ~(8'b0000_0111); // '7'
                    4'b1000: data_out = ~(8'b0111_1111); // '8'
                    4'b1001: data_out = ~(8'b0110_0111); // '9'
                    4'b0000: data_out = ~(8'b0011_1111); // '0'
                    4'b1010: data_out = ~(8'b1000_0000); // 'dp'
                    default: data_out = ~(8'b0000_0000); // 모든 스위치 OFF일 때
                endcase            
            end   
        end
    end

    sn74hc595_cntr sr_seg (
        .clk(clk),
        .reset_p(reset_p),
        .data_in(data_out),
        .srclk(srclk),
        .rclk(rclk),
        .ser(ser)
    );

endmodule

module stepper_cntr(
    input clk, reset_p,
    input [2:0] cntr_sig,             // 나중에 IP로 만들면 C 코딩할때 여기 레지스터로 값 받아서 제어  
    output reg IN1, IN2, IN3, IN4     // 이거 그대로 XDC에 뽑아서 스텝모터랑 연결
    );
    
    
    // FSM 사용할 상태 선언
    localparam IDLE     = 5'b00001;   
    localparam S_0001   = 5'b00010;
    localparam S_0010   = 5'b00100;
    localparam S_0100   = 5'b01000;
    localparam S_1000   = 5'b10000;
    
    
    
    // 시스템 클락 분주
    reg delay_clk;                                  // C 코딩할때 딜레이 안넣으려고 모듈에서 미리 분주해줌
    integer delay_time;                             // C 코딩할때 최대한 논블로킹 방식으로 하기 위함
    always @(posedge clk, posedge reset_p) begin
        if(reset_p) begin
            delay_time <= 0;
            delay_clk <= 0;
        end else begin
            if(delay_time >= 499_999) begin         // 5ms로 분주
                delay_clk <= ~delay_clk;
                delay_time <= 0;
            end else begin
                delay_time <= delay_time + 1;
            end
        end
    end
    
    
    // 엣지디텍터로 5ms로 분주한 클락 폴링엣지 잡아줌 
    wire delay_clk_ne;     
    edge_detector_p divclk_ed(
        .clk(clk),
        .reset_p(reset_p),
        .cp(delay_clk),
        .n_edge(delay_clk_ne)
    );
    
    
    // 분주된 클락 폴링엣지일때 상태 바꿔줄거임(분주한 주기만큼 딜레이 줄거임)
    reg [4:0] state, next_state;
    always @(negedge clk, posedge reset_p) begin
        if(reset_p) begin
            state <= IDLE;
        end else begin
            if(delay_clk_ne) begin
                state <= next_state;
            end
        end
    end
    
    
    // 상태천이 부분
    always @(posedge clk, posedge reset_p) begin
        if(reset_p) begin
            IN1 <= 0;
            IN2 <= 0;
            IN3 <= 0;
            IN4 <= 1;
            next_state <= IDLE;
        end else begin
            case(state)
                IDLE : begin                        // 입력 안들어올 때
                    IN1 <= 0;
                    IN2 <= 0;
                    IN3 <= 0;
                    IN4 <= 1;                               // 멈춰있을 때 0000 아니고 아무데나 1 줘야 가만히 있을때도 토크가 유지됨
                    if(cntr_sig == 3'b001) begin            // 정지 신호(001) 들어오면 계속 상태 IDLE 유지
                        next_state <= IDLE;
                    end else if(cntr_sig == 3'b010) begin   // 시계방향 신호(010) 들어오면 다음 상태로 ㄱㄱ
                        next_state <= S_0001;
                    end else if(cntr_sig == 3'b100) begin   // 반시계방향 신호(100) 들어오면 다음 상태로 ㄱㄱ
                        next_state <= S_0001;
                    end
                end
                
                S_0001 : begin
                    IN1 <= 0;       // 0001 상태에 맞게 출력 0001로 줌
                    IN2 <= 0;
                    IN3 <= 0;
                    IN4 <= 1;
                    if(cntr_sig == 3'b001) begin
                        next_state <= IDLE;
                    end else if(cntr_sig == 3'b010) begin   // 시계방향 신호면 출력 0001 상태에서 0010 상태로 ㄱㄱ
                        next_state <= S_0010;
                    end else if(cntr_sig == 3'b100) begin   // 반시계방향 신호면 1000 상태로 ㄱㄱ
                        next_state <= S_1000;
                    end
                end
                
                S_0010 : begin
                    IN1 <= 0;   // 0010 상태에 맞게 출력 0010으로 줌
                    IN2 <= 0;
                    IN3 <= 1;
                    IN4 <= 0;
                    if(cntr_sig == 3'b001) begin
                        next_state <= IDLE;
                    end else if(cntr_sig == 3'b010) begin   // 시계방향 신호면 0100 상태로 ㄱㄱ
                        next_state <= S_0100;
                    end else if(cntr_sig == 3'b100) begin   // 반시계방향 신호면 0001 상태로 ㄱㄱ
                        next_state <= S_0001;
                    end
                end
                
                S_0100 : begin
                    IN1 <= 0;   // 0100 상태에 맞게 출력 0100으로 줌
                    IN2 <= 1;
                    IN3 <= 0;
                    IN4 <= 0;
                    if(cntr_sig == 3'b001) begin
                        next_state <= IDLE;
                    end else if(cntr_sig == 3'b010) begin   // 시계방향 신호면 1000 상태로 ㄱㄱ 
                        next_state <= S_1000;
                    end else if(cntr_sig == 3'b100) begin   // 반시계방향 신호면 0010 상태로 ㄱㄱ
                        next_state <= S_0010;
                    end
                end
                
                S_1000 : begin
                    IN1 <= 1;   // 1000 상태에 맞게 출력 1000으로 줌
                    IN2 <= 0;
                    IN3 <= 0;
                    IN4 <= 0;
                    if(cntr_sig == 3'b001) begin
                        next_state <= IDLE;
                    end else if(cntr_sig == 3'b010) begin   // 시계방향 신호면 0001 상태로 ㄱㄱ
                        next_state <= S_0001;
                    end else if(cntr_sig == 3'b100) begin   // 반시계방향 신호면 0100 상태로 ㄱㄱ
                        next_state <= S_0100;
                    end
                end
            endcase
        end
    end
    
endmodule

module button_cntr_v1(
    input clk, reset_p,
    input [4:0] btn,
    output [4:0] btn_trig_pe,
    output [4:0] btn_trig_ne
    // 모듈 테스트용 led 
//    output reg [1:0] led
    );
    
    wire [4:0] debounced_btn;
    
    // 원래 쓰던 버튼컨트롤러랑 똑같은 원리 및 구조임
    debounce db_btn_0( clk, btn[0], debounced_btn[0] );
    debounce db_btn_1( clk, btn[1], debounced_btn[1] );
    debounce db_btn_2( clk, btn[2], debounced_btn[2] );
    debounce db_btn_3( clk, btn[3], debounced_btn[3] );
    debounce db_btn_4( clk, btn[4], debounced_btn[4] );
    
    edge_detector_p ed_btn_0( clk, reset_p, debounced_btn[0], btn_trig_pe[0], btn_trig_ne[0] );
    edge_detector_p ed_btn_1( clk, reset_p, debounced_btn[1], btn_trig_pe[1], btn_trig_ne[1] ); 
    edge_detector_p ed_btn_2( clk, reset_p, debounced_btn[2], btn_trig_pe[2], btn_trig_ne[2] ); 
    edge_detector_p ed_btn_3( clk, reset_p, debounced_btn[3], btn_trig_pe[3], btn_trig_ne[3] ); 
    edge_detector_p ed_btn_4( clk, reset_p, debounced_btn[4], btn_trig_pe[4], btn_trig_ne[4] );
    
    // 모듈 테스트용    
//    always @(posedge clk, posedge reset_p) begin
//        if(reset_p) begin
//            led[0] <= 0;
//            led[1] <= 0;
//        end else begin
//            if(btn_trig_ne[0] | btn_trig_ne[1] | btn_trig_ne[2] | btn_trig_ne[3] | btn_trig_ne[4]) begin
//                led[0] <= ~led[0];
//            end else if(btn_trig_pe[0] | btn_trig_pe[1] | btn_trig_pe[2] | btn_trig_pe[3] | btn_trig_pe[4]) begin
//                led[1] <= ~led[1];
//            end
//        end
//    end  
    
endmodule

module button_cntr(
    input clk, reset_p,
    input [4:0] btn,
    input active_mode,          // 하드웨어 액티브 모드 수정해서 쓸 필요 없게 할거
    output reg [4:0] btn_out
    );
    

    wire [4:0] debounced_btn;
    debounce db_btn_0( clk, btn[0], debounced_btn[0] );
    debounce db_btn_1( clk, btn[1], debounced_btn[1] );
    debounce db_btn_2( clk, btn[2], debounced_btn[2] );
    debounce db_btn_3( clk, btn[3], debounced_btn[3] );
    debounce db_btn_4( clk, btn[4], debounced_btn[4] );
    
    always @(posedge clk, posedge reset_p) begin
        if(reset_p) begin
            btn_out <= 0;
        end else begin
            if(active_mode) begin                   // 액티브 하이로 설정해 두면
                if(debounced_btn[0]) begin          // 하드웨어에서 high 신호 들어올 때 레지스터에 1 저장할거
                    btn_out[0] <= 1;
                end else begin
                    btn_out[0] <= 0;
                end
                
                if(debounced_btn[1]) begin
                    btn_out[1] <= 1;
                end else begin
                    btn_out[1] <= 0;
                end
                
                if(debounced_btn[2]) begin
                    btn_out[2] <= 1;
                end else begin
                    btn_out[2] <= 0;
                end
                
                if(debounced_btn[3]) begin
                    btn_out[3] <= 1;
                end else begin
                    btn_out[3] <= 0;
                end
                
                if(debounced_btn[4]) begin
                    btn_out[4] <= 1;
                end else begin
                    btn_out[4] <= 0;
                end
                
            end else begin
            
                if(~debounced_btn[0]) begin         // 액티브 로우로 설정해 두면                
                    btn_out[0] <= 1;                // 반대로 하드웨어에서 low 신호 들어올 때 1 저장할거
                end else begin
                    btn_out[0] <= 0;
                end
                
                if(~debounced_btn[1]) begin
                    btn_out[1] <= 1;
                end else begin
                    btn_out[1] <= 0;
                end
                
                if(~debounced_btn[2]) begin
                    btn_out[2] <= 1;
                end else begin
                    btn_out[2] <= 0;
                end
                
                if(~debounced_btn[3]) begin
                    btn_out[3] <= 1;
                end else begin
                    btn_out[3] <= 0;
                end
                
                if(~debounced_btn[4]) begin
                    btn_out[4] <= 1;
                end else begin
                    btn_out[4] <= 0;
                end
            end        
        end

    end
    
endmodule

module photo_INT_cntr_v1(
    input clk, reset_p,
    input [2:0] photo_INT,
    output [2:0] INT_trig_pe,INT_trig_ne
    // 모듈 테스트용 led
//    output reg [0:0] led
    );
    
    edge_detector_p ed_INT_0( clk, reset_p, photo_INT[0], INT_trig_pe[0], INT_trig_ne[0] );
    edge_detector_p ed_INT_1( clk, reset_p, photo_INT[1], INT_trig_pe[1], INT_trig_ne[1] );
    edge_detector_p ed_INT_2( clk, reset_p, photo_INT[2], INT_trig_pe[2], INT_trig_ne[2] );
    
    // 모듈 테스트용 
//    always @(posedge clk, posedge reset_p) begin
//        if(reset_p) begin
//            led[0] <= 0;
//        end else begin
//            if(INT_trig_pe[0] | INT_trig_pe[1] | INT_trig_pe[2] ) begin
//                led[0] <= 0;
//            end else if (INT_trig_ne[0] | INT_trig_ne[1] | INT_trig_ne[2] ) begin
//                led[0] <= 1;
//            end
//        end
//    end
    
endmodule

module photo_INT_cntr(
    input clk, reset_p,
    input [2:0] photo_INT,
    input active_mode,              // 하드웨어 액티브 모드 수정해서 쓸 필요 없게 할거
    output reg [2:0] signal_out
    );
    
    always @(posedge clk, posedge reset_p) begin
        if(reset_p) begin
            signal_out <= 0;
        end else begin
            if(active_mode) begin           // 액티브 하이로 설정해 두면
                if(photo_INT[0]) begin      // 하드웨어에서 high 신호 들어올 때 레지스터에 1 저장할거
                    signal_out[0] <= 1;
                end else begin
                    signal_out[0] <= 0;
                end
                
                if(photo_INT[1]) begin
                    signal_out[1] <= 1;
                end else begin
                    signal_out[1] <= 0;
                end
                if(photo_INT[2]) begin
                    signal_out[2] <= 1;
                end else begin
                    signal_out[2] <= 0;
                end
            end else begin                 // 액티브 로우로 설정해 두면
                if(~photo_INT[0]) begin    // 반대로 하드웨어에서 low 신호 들어올 때 1 저장할거
                    signal_out[0] <= 1;
                end else begin
                    signal_out[0] <= 0;
                end
                
                if(~photo_INT[1]) begin
                    signal_out[1] <= 1;
                end else begin
                    signal_out[1] <= 0;
                end
                
                if(~photo_INT[2]) begin
                    signal_out[2] <= 1;
                end else begin
                    signal_out[2] <= 0;
                end
            end
        end
    end
    
endmodule

module led_cntr(
    input clk, reset_p,
    input [1:0] control,
    output srclk, rclk, ser
    );
    
    
    // SFM 상태 선언부
    localparam OFF           = 10'b00000_00001;
    localparam S_0000_0001   = 10'b00000_00010;
    localparam S_0000_0010   = 10'b00000_00100;
    localparam S_0000_0100   = 10'b00000_01000;
    localparam S_0000_1000   = 10'b00000_10000;
    localparam S_0001_0000   = 10'b00001_00000;
    localparam S_0010_0000   = 10'b00010_00000;
    localparam S_0100_0000   = 10'b00100_00000;
    localparam S_1000_0000   = 10'b01000_00000;
    localparam ON            = 10'b10000_00000;
    
   
   
    reg [7:0] serial_data;  // 2비트짜리 control 레지스터 받아서 mux처럼 시리얼 출력으로 연결할거임
    sn74hc595_cntr sr_led(
        .clk(clk),
        .reset_p(reset_p),
        .data_in(serial_data),
        .srclk(srclk),
        .rclk(rclk),
        .ser(ser)
    );
    
    
    
    wire rclk_ne;     
    edge_detector_p divclk_ed(
        .clk(clk),
        .reset_p(reset_p),
        .cp(rclk),              // 8비트 시리얼 입력으로 다 받으면 래치 올라가는데 그거 잡을거
        .n_edge(rclk_ne)        // 폴링엣지 잡아줌
    );
    
    
    // 상태 천이하는 부분
    reg [15:0] cnt_delay;       // LED 시프트 눈에 보이게 하려고 딜레이 줄거임
    reg [9:0] state, next_state;
    always @(negedge clk, posedge reset_p) begin
        if(reset_p) begin
            state <= OFF;
            cnt_delay <= 0;
        end else begin
            if(rclk_ne) begin
                if(cnt_delay > 49_999) begin    // 595 시프트레지스터가 입력 8비트 다 받으면 래치핀이 올라오는데 그게 1.8us 걸림
                    cnt_delay <= 0;             // 1.8us씩 50,000번 분주하면 대략 90ms정도 됨
                    state <= next_state;        // 90ms만큼 딜레이 주면서 LED 시프트 되도록(상태가 바뀌도록) 설계
                end else begin
                    cnt_delay <= cnt_delay + 1;
                end            
            end
        end
    end
    
    
    // 상태 바뀌는 부분
    always @(posedge clk, posedge reset_p) begin
        if(reset_p) begin
            next_state <= OFF;                      // 초기화시 LED 끔
            serial_data <= 8'b0000_0000;
        end else begin
            case(state)
                OFF : begin
                    serial_data <= 8'b0000_0000;        // OFF 상태로 들어오면  LED 다 끔

                    if(control == 0) begin              // control 레지스터에 0 입력받으면 LED 다 끄는거 유지할거임
                        next_state <= OFF;          
                    end else if(control == 1) begin     // 1 입력받으면 좌로 흐르게(좌시프트) 할거임
                        next_state <= S_0000_0001;
                    end else if (control == 2) begin    // 2 입력받으면 우로 흐르게(우시프트) 할거임
                        next_state <= S_1000_0000;
                    end else if (control == 3) begin    // 3 입력받으면 LED 다 킬거임
                        next_state <= ON;
                    end
                end
                
                S_0000_0001 : begin
                    serial_data <= 8'b0000_0001;        // 여기로 들어오면 LED 맨 우측만 켤거임
                                                        // 여기서부터는 순서대로 똑같음
                    if(control == 0) begin
                        next_state <= OFF;
                    end else if(control == 1) begin
                        next_state <= S_0000_0010;
                    end else if (control == 2) begin
                        next_state <= S_1000_0000;
                    end else if (control == 3) begin
                        next_state <= ON;
                    end
                end
                
                S_0000_0010 : begin
                    serial_data <= 8'b0000_0010;
                    
                    if(control == 0) begin
                        next_state <= OFF;
                    end else if(control == 1) begin
                        next_state <= S_0000_0100;
                    end else if (control == 2) begin
                        next_state <= S_0000_0001;
                    end else if (control == 3) begin
                        next_state <= ON;
                    end
                end
                
                S_0000_0100 : begin
                    serial_data <= 8'b0000_0100;
                    
                    if(control == 0) begin
                        next_state <= OFF;
                    end else if(control == 1) begin
                        next_state <= S_0000_1000;
                    end else if (control == 2) begin
                        next_state <= S_0000_0010;
                    end else if (control == 3) begin
                        next_state <= ON;
                    end
                end
                
                S_0000_1000 : begin
                    serial_data <= 8'b0000_1000;
                    
                    if(control == 0) begin
                        next_state <= OFF;
                    end else if(control == 1) begin
                        next_state <= S_0001_0000;
                    end else if (control == 2) begin
                        next_state <= S_0000_0100;
                    end else if (control == 3) begin
                        next_state <= ON;
                    end
                end
                
                S_0001_0000 : begin
                    serial_data <= 8'b0001_0000;
                    
                    if(control == 0) begin
                        next_state <= OFF;
                    end else if(control == 1) begin
                        next_state <= S_0010_0000;
                    end else if (control == 2) begin
                        next_state <= S_0000_1000;
                    end else if (control == 3) begin
                        next_state <= ON;
                    end
                end
                
                S_0010_0000 : begin
                    serial_data <= 8'b0010_0000;
                    
                    if(control == 0) begin
                        next_state <= OFF;
                    end else if(control == 1) begin
                        next_state <= S_0100_0000;
                    end else if (control == 2) begin
                        next_state <= S_0001_0000;
                    end else if (control == 3) begin
                        next_state <= ON;
                    end
                end
                
                S_0100_0000 : begin
                    serial_data <= 8'b0100_0000;
                    
                    if(control == 0) begin
                        next_state <= OFF;
                    end else if(control == 1) begin
                        next_state <= S_1000_0000;
                    end else if (control == 2) begin
                        next_state <= S_0010_0000;
                    end else if (control == 3) begin
                        next_state <= ON;
                    end
                end
                
                S_1000_0000 : begin
                    serial_data <= 8'b1000_0000;            // 여기로 들어오면 맨 왼쪽만 켤거임
                    
                    if(control == 0) begin
                        next_state <= OFF;
                    end else if(control == 1) begin
                        next_state <= S_0000_0001;
                    end else if (control == 2) begin
                        next_state <= S_0100_0000;
                    end else if (control == 3) begin
                        next_state <= ON;
                    end
                end
                
                ON : begin
                    serial_data <= 8'b1111_1111;            // ON 상태로 들어오면 LED 다 켤거임
                    
                    if(control == 0) begin                  // control 레지스터에 0 입력받으면 LED 다 끌거임
                        next_state <= OFF;
                    end else if(control == 1) begin         // 1 입력받으면 좌시프트 할거임
                        next_state <= S_0000_0001;
                    end else if (control == 2) begin        // 2 입력받으면 우시프트 할거임
                        next_state <= S_1000_0000;
                    end else if (control == 3) begin        // 3 입력받으면 켜는거 유지할거임
                        next_state <= ON;
                    end
                end                
            endcase
        end
    end
    
endmodule