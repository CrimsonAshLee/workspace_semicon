`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/11/2025 11:23:59 AM
// Design Name: 
// Module Name: test_top
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


module ring_counter_led_top(
    input clk, reset_p,     // FPGA 보드에서 제공되는 주 클럭 신호
                            // 회로를 초기화 하는 리셋 신호
    output reg [15:0] led   // 16개의 LED를 제어하는 16비트 출력
    );
    
    reg [20:0] clk_div;     // 21비트 너비의 레지스터 선언. 클락을 하는 카운터 역할
    always @(posedge clk)clk_div = clk_div + 1; // clk의 상승 엣지마다 아래 코드 실행
                                                // clk의 상승 엣지마다 clk_div 값을 1씩 증가(클럭 분주기)
    always @(posedge clk_div[20] or posedge reset_p)begin
        // always블록은 reset_p의 상승 엣지 또는 clk_div[20]의
        // 상승 엣지에서만 동작함. 즉 매우느린 clk_div[20]에 맞게 바뀜

        if(reset_p)led = 16'b0000_0000_0000_0001;
        // reset_p가 활성화되면 모든 led를 끄고 첫번째led(가장 오른쪽 비트)만 켬

        else led = {led[14:0], led[15]};
        // 리셋이 아닌경우 led값을 순환 쉬프트함.

    end
    
endmodule

module ring_counter_led_edge_detector_p(
    input clk,
    input reset_p,
    
    output reg [15:0] led
    
    );

    reg [20:0] clk_div;
    always @(posedge clk)clk_div = clk_div + 1;
    wire clk_div_18;    
    edge_detector_p clk_div_edge(
        .clk(clk), .reset_p(reset_p), .cp(clk_div[18]),
        .p_edge(clk_div_18)
    );

    always @(posedge clk or posedge reset_p) begin
        if(reset_p)led = 16'b0000_0000_0000_0001;
        // reset_p가 활성화되면 모든 led를 끄고 첫번째led(가장 오른쪽 비트)만 켬

        else led = {led[14:0], led[15]};
    end
endmodule

module watch_top (
    input clk, reset_p,
    input [2:0] btn,
    output [7:0] seg_7,
    output [3:0] com,
    output [15:0] led
);

    // wire [2:0] debounce_btn;
    wire btn_mode, inc_sec, inc_min;    // 벡터보단 구별이 편함

//     debounce btn_0(
//     .clk(clk),
//     .btn_in(btn[0]),
//     .btn_out(btn_mode)
// );

//     debounce btn_1(
//     .clk(clk),
//     .btn_in(btn[1]),
//     .btn_out(inc_sec)
// );

//     debounce btn_2(
//     .clk(clk),
//     .btn_in(btn[2]),
//     .btn_out(inc_min)
// );

    btn_cntr mode_btn(
    .clk(clk), 
    .reset_p(reset_p),
    .btn(btn[0]),
    .btn_pedge(btn_mode)
);
    btn_cntr inc_sec_btn(
    .clk(clk), 
    .reset_p(reset_p),
    .btn(btn[1]),
    .btn_pedge(inc_sec)
);
    btn_cntr inc_min_btn(
    .clk(clk), 
    .reset_p(reset_p),
    .btn(btn[2]),
    .btn_pedge(inc_min)
);

    // wire mode_btn_pedge;
    // edge_detector_p mode_ed(
    //     .clk(clk), 
    //     .reset_p(reset_p),
    //     .cp(btn_mode), 
    //     .p_edge(mode_btn_pedge)
    // );
    // edge_detector_p inc_sec_ed(
    //     .clk(clk), 
    //     .reset_p(reset_p),
    //     .cp(inc_sec), 
    //     .p_edge(inc_sec_pedge)
    // );
    // edge_detector_p inc_min_ed(
    //     .clk(clk), 
    //     .reset_p(reset_p),
    //     .cp(inc_min), 
    //     .p_edge(inc_min_edge)
    // );

    reg set_watch;
    assign led[0] = set_watch;
    always @(posedge clk, posedge reset_p) begin
        if (reset_p) begin
            set_watch = 0;
        end
        else if(btn_mode)begin
            set_watch = ~set_watch;
        end
    end

    reg [26:0] cnt_sysclk;
    reg [7:0] sec, min;
    always @(posedge clk, posedge reset_p) begin
        if(reset_p)begin
            cnt_sysclk = 0;
            sec = 0;
            min = 0;
        end
        else begin
            if (set_watch) begin
                if(inc_sec) begin
                    if (sec >= 59)sec = 0;
                    else sec = sec + 1;
            end
            if (inc_min) begin
                if(inc_min >= 59)min = 0;
                else min = min + 1;
            end    
        end 
        else begin
            if(cnt_sysclk >= 27'd99_999_999)begin
                cnt_sysclk = 0;
                if(sec >= 59)begin
                    sec = 0;
                    if(min >= 59)min = 0;
                    else min = min + 1;
                end
                else sec = sec + 1;
            end
            else cnt_sysclk = cnt_sysclk + 1;
            end    
        end
    end

    wire [15:0] sec_bcd, min_bcd;

    bin_to_dec bcd_sec(.bin(sec), .bcd(sec_bcd));
    bin_to_dec bcd_min(.bin(min), .bcd(min_bcd));

    fnd_cntr fnd(.clk(clk), .reset_p(reset_p),
    .fnd_value({min_bcd[7:0], sec_bcd[7:0]}), .hex_bcd(1),
    .seg_7(seg_7), .com(com));

endmodule

module cook_timer (
    input clk, reset_p,
    input [3:0] btn,
    output [7:0] seg_7,
    output [3:0] com,
    output reg alarm,
    output [14:0] led   // 디버깅용 led
);
    reg [7:0] set_sec, set_min;
    reg start_set;
    reg [26:0] cnt_sysclk = 0;
    reg [7:0] sec, min;
    reg set_flag;

    wire btn_mode, inc_sec, inc_min, alarm_off;
    wire [15:0] cur_time = {min, sec};
    wire [7:0] sec_bcd, min_bcd;

    btn_cntr mode_btn(
        .clk(clk), 
        .reset_p(reset_p),
        .btn(btn[0]),
        .btn_pedge(btn_mode)
    );

    btn_cntr inc_sec_btn(
        .clk(clk), 
        .reset_p(reset_p),
        .btn(btn[1]),
        .btn_pedge(inc_sec)
    );

    btn_cntr inc_min_btn(
        .clk(clk), 
        .reset_p(reset_p),
        .btn(btn[2]),
        .btn_pedge(inc_min)
    );

    btn_cntr alarm_off_btn(
        .clk(clk),
        .reset_p(reset_p),
        .btn(btn[3]),
        .btn_pedge(alarm_off)
    );
    
    assign led[0] = start_set;
    always @(posedge clk, posedge reset_p) begin
        if(reset_p) begin
            start_set = 0;
            alarm = 0;
        end
        else if(btn_mode && cur_time != 0 && start_set == 0)begin
            start_set = 1;
            set_sec = sec;
            set_min = min;
        end
        else if (start_set && btn_mode) begin
            start_set = 0;
        end
        else if (start_set && min == 0 && sec == 0) begin
            start_set = 0;
            alarm = 1;
        end
        else if (alarm && (alarm_off || inc_sec || inc_min || btn_mode)) begin
            alarm = 0;
            set_flag = 1;
        end
        else if (cur_time != 0) begin
            set_flag = 0;
        end
    end 
    
    // assign cur_time = {min, sec}; // 영상설명 다시보기
    always @(posedge clk, posedge reset_p) begin
        if(reset_p)begin
            cnt_sysclk = 0;
            sec = 0;
            min = 0;
        end
        else begin
            if (start_set) begin
                if (cnt_sysclk >= 99_999_999) begin // Q) -1 하는 이유?
                    cnt_sysclk = 0;
                    if (sec == 0) begin
                        if (min) begin
                            sec = 59;
                            min = min - 1;
                        end
                    end
                    else sec = sec - 1;
                end
                else cnt_sysclk = cnt_sysclk + 1;
            end
            else begin
                if (inc_sec) begin
                    if (sec >= 59) begin
                        sec = 0;
                    end
                    else begin
                        sec = sec + 1;
                    end
                end
                else if (inc_min) begin
                    if (min >= 99) begin
                        min = 0;
                    end
                    else begin
                        min = min + 1;
                    end
                end
                if (set_flag) begin
                        sec = set_sec;
                        min = set_min;
                end
            end
        end
    end

    bin_to_dec bcd_sec(.bin(sec), .bcd(sec_bcd));
    bin_to_dec bcd_min(.bin(min), .bcd(min_bcd));

    fnd_cntr fnd(.clk(clk), .reset_p(reset_p),
    .fnd_value({min_bcd[7:0], sec_bcd[7:0]}), .hex_bcd(1),
    .seg_7(seg_7), .com(com));


endmodule


module stop_watch (
    input clk, 
    input reset_p,
    input [2:0] btn,

    output [7:0] seg_7,
    output [3:0] com,
    output [15:0] led
);

    wire btn_start, btn_lap, btn_clear;
    reg [7:0]  sec, csec;
    wire [7:0] sec_bcd, csec_bcd;

    btn_cntr start_btn(
        .clk(clk), 
        .reset_p(reset_p),
        .btn(btn[0]),
        .btn_pedge(btn_start)
    );

    btn_cntr lap_btn(
        .clk(clk), 
        .reset_p(reset_p),
        .btn(btn[1]),
        .btn_pedge(btn_lap)
    );

    btn_cntr clear_btn(
        .clk(clk), 
        .reset_p(reset_p),
        .btn(btn[2]),
        .btn_pedge(btn_clear)
    );

    reg start_stop;
    assign led[0] = start_stop; // 디버깅용
    always @(posedge clk, posedge reset_p) begin
        if (reset_p) begin
            start_stop = 0;
        end
        else if (btn_start) begin // 플립플롭?
            start_stop = ~start_stop;
        end
    end

    reg lap;
    assign led[1] = lap; // 디버깅용
    reg [7:0] lap_sec, lap_csec;
    always @(posedge clk, posedge reset_p) begin
        if (reset_p) begin
            lap = 0;
            lap_sec = 0;
            lap_csec = 0;
        end
        else if (btn_lap) begin // 플립플롭?
            lap = ~lap;
            lap_sec = sec;
            lap_csec = csec;
        end
        else if (btn_clear) begin
            lap = 0;
            lap_sec = 0;
            lap_csec = 0;
        end
    end

    reg [26:0] cnt_sysclk; // = 0; // reg타입일때 =0은 시뮬레이션 할때 0 준것
    always @(posedge clk, posedge reset_p) begin
        if (reset_p) begin
            sec = 0;
            csec = 0;
            cnt_sysclk = 0;
        end
        else begin
            if (start_stop) begin
                if (cnt_sysclk >= 999_999) begin // 이숫자가 왜 100분의 1초이고 왜 이숫자씀?
                    cnt_sysclk = 0;
                    if (csec >= 99) begin
                        csec = 0;
                        if (sec >= 99) begin // 스탑워치니까 99까지만한다
                            sec = 0;
                        end
                        else begin
                            sec = sec + 1;
                        end
                    end
                    else begin
                        csec = csec + 1;
                    end
                end
                else begin
                    cnt_sysclk = cnt_sysclk + 1;
                end
            end
            if (btn_clear) begin
                sec = 0;
                csec = 0;
                cnt_sysclk = 0;
            end
        end
    end

    wire [7:0] fnd_sec, fnd_csec;               // 이거 wire, assign문 3줄 왜 쓴거지?
    assign fnd_sec = lap ? lap_sec :sec;
    assign fnd_csec = lap ? lap_csec : csec;

    bin_to_dec bcd_sec(.bin(fnd_sec), .bcd(sec_bcd));
    bin_to_dec bcd_csec(.bin(fnd_csec), .bcd(csec_bcd));

    fnd_cntr fnd(.clk(clk), .reset_p(reset_p),
    .fnd_value({sec_bcd, csec_bcd}), .hex_bcd(1),  // 이러게해도되는 이유? 상위 비트가 0이라서?
    .seg_7(seg_7), .com(com));
    
endmodule

// module duo_watch_top (
//     input clk,
//     input reset_p,
//     input [2:0] btn,

//     output [7:0] seg_7, // 7:0 이유? seg의 a,b,c,d..에 해당 dp제외인듯?
//     output [3:0] com,   // com이 뭘까?
//     output [15:0] led
// );

//     reg [1:0] mode_state;   // 모드 레지스터?
//     wire [15:0] fnd_value;  // fnd랑 seg 구분하는법?
//     wire btn_mode_pedge, btn_start_stop_pedge, btn_clear_pedge;           
    
//     btn_cntr mode_btn(
//         .clk(clk), 
//         .reset_p(reset_p),
//         .btn(btn[0]),
//         .btn_pedge(btn_mode_pedge)
//     );

//     btn_cntr start_stop_btn(
//         .clk(clk), 
//         .reset_p(reset_p),
//         .btn(btn[1]),
//         .btn_pedge(btn_start_stop_pedge)
//     );

//     btn_cntr clear_btn(
//         .clk(clk), 
//         .reset_p(reset_p),
//         .btn(btn[2]),
//         .btn_pedge(btn_clear_pedge)
//     );

//     localparam WATCH_MODE = 2'b00;
//     localparam STOP_WATCH_MODE = 2'b01;
//     // localparam이라는 상수를 정의하는 verilog 문법
//     // 관례상 reg, wire와 구분짓기 위해 대문자를 사용함
//     // 마치 전화번호부에 이름을 등록하는것과 비슷함

//     always @(posedge clk or posedge reset_p) begin
//         if (reset_p) begin
//             mode_state <= WATCH_MODE; // 리셋시 시계모드
//         end
//         else if (btn_mode_pedge) begin
//             if (mode_state == WATCH_MODE) begin
//                 mode_state <= STOP_WATCH_MODE
//             end
//             else begin
//                 mode_state <= WATCH_MODE;
//             end
//         end
//     end

//     reg start_stop;
//     assign led[0] = start_stop; // 디버깅용

//     always @(posedge clk or posedge reset_p) begin
//         if (reset_p) begin
//             start_stop <= 1'b0;
//         end
//         else if (mode_state == STOP_WATCH_MODE && btn_start_stop_pedge) begin
//             start_stop <= ~start_stop;
//         end
//     end

//     reg [26:0] cnt_sysclk; 
//     reg [7:0] watch_sec, watch_min;
//     reg [7:0] sw_sec, sw_csec;

//     always @(posedge clk or posedge reset_p) begin
//         if (reset_p) begin
//             watch_sec <= 0;
//             watch_min <= 0;
//             sw_sec <= 0
//             sw_csec <= 0;
//             cnt_sysclk <= 0;
//         end
//         else begin
//             case (mode_state)
//                 WATCH_MODE : begin
//                     if (cnt_sysclk >= 99_999_999) begin
//                         cnt_sysclk <= 0;
//                         if (watch_sec >= 59) begin
//                             watch_sec <= 0;
//                             if (watch_min >= 59) begin
//                                 watch_min <= 0;
//                             end
//                             else begin
//                                 watch_min <= watch_min + 1;
//                             end
//                         end
//                         else begin
//                             watch_sec <= watch_sec + 1;
//                         end
//                     end
//                     else begin
//                         cnt_sysclk <= cnt_sysclk + 1;
//                     end
//                 end
//                 STOP_WATCH_MODE: begin
//                     if (start_stop) begin
//                         if (cnt_sysclk >= 999_999) begin
//                             cnt_sysclk <= 0;
//                             if (sw_csec >= 99) begin
//                                 sw_csec <= 0;
//                                 if (sw_sec >= 99) begin
//                                     sw_sec <= 0
//                                 end
//                                 else begin
//                                     sw_sec <= sw_sec + 1;
//                                 end
//                             end
//                             else begin
//                                 sw_csec <= sw_csec + 1;
//                             end
//                         end
//                         else begin
//                             cnt_sysclk <= cnt_sysclk + 1;
//                         end
//                     end
//                     if (btn_clear_pedge) begin
//                         sw_sec <= 0;
//                         sw_csec <= 0;
//                         cnt_sysclk <= 0;
//                         start_stop <= 0;
//                     end
//                 end 
//             endcase
//         end
//     end

// endmodule


// duo_watch_top 모듈 (두 기능을 합친 최상위 모듈)

module duo_watch_top (
    input clk, reset_p,
    input [2:0] btn,

    output [7:0] seg_7,
    output [3:0] com,
    output [15:0] led
);
    // 상태 정의
    localparam WATCH_MODE = 2'b00;
    localparam STOP_WATCH_MODE = 2'b01;
    
    // 모드 제어 레지스터
    reg [1:0] mode_state;
    reg start_stop;

    // 각 버튼의 엣지를 감지할 와이어
    wire btn_mode_pedge, btn_start_stop_pedge, btn_clear_pedge;

    // FND에 최종적으로 표시될 값을 저장할 레지스터와 BCD 변환을 위한 와이어
    reg [15:0] fnd_value_reg;
    wire [7:0] watch_sec_bcd, watch_min_bcd;
    wire [7:0] sw_sec_bcd, sw_csec_bcd;

    // 시계와 스톱워치 상태를 위한 레지스터
    reg [26:0] cnt_sysclk;
    reg [7:0] watch_sec, watch_min;
    reg [7:0] sw_sec, sw_csec;

    // ----------------------------------------------------------------------
    // 버튼 처리 모듈 인스턴스화
    // ----------------------------------------------------------------------
    btn_cntr mode_btn (
        .clk(clk), .reset_p(reset_p), .btn(btn[0]), .btn_pedge(btn_mode_pedge)
    );

    btn_cntr start_stop_btn (
        .clk(clk), .reset_p(reset_p), .btn(btn[1]), .btn_pedge(btn_start_stop_pedge)
    );

    btn_cntr clear_btn (
        .clk(clk), .reset_p(reset_p), .btn(btn[2]), .btn_pedge(btn_clear_pedge)
    );
    
    // ----------------------------------------------------------------------
    // 모드 전환 FSM (Finite State Machine)
    // ----------------------------------------------------------------------
    always @(posedge clk or posedge reset_p) begin
        if (reset_p) begin
            mode_state <= WATCH_MODE;
        end
        else if (btn_mode_pedge) begin
            if (mode_state == WATCH_MODE) begin
                mode_state <= STOP_WATCH_MODE;
            end
            else begin
                mode_state <= WATCH_MODE;
            end
        end
    end
    
    // ----------------------------------------------------------------------
    // 스톱워치 시작/정지 제어
    // ----------------------------------------------------------------------
    always @(posedge clk or posedge reset_p) begin
        if (reset_p) begin
            start_stop <= 1'b0;
        end
        else if (mode_state == STOP_WATCH_MODE && btn_start_stop_pedge) begin
            start_stop <= ~start_stop;
        end
        else if (mode_state == WATCH_MODE) begin // 모드 전환 시 스톱워치 정지
            start_stop <= 1'b0;
        end
    end
    
    // ----------------------------------------------------------------------
    // 시간 카운트 로직 (시계 & 스톱워치)
    // ----------------------------------------------------------------------
    always @(posedge clk or posedge reset_p) begin
        if (reset_p) begin
            watch_sec <= 0;
            watch_min <= 0;
            sw_sec <= 0;
            sw_csec <= 0;
            cnt_sysclk <= 0;
        end
        else begin
            case (mode_state)
                WATCH_MODE: begin
                    if (cnt_sysclk >= 99_999_999) begin // 1초 카운터
                        cnt_sysclk <= 0;
                        if (watch_sec >= 59) begin
                            watch_sec <= 0;
                            if (watch_min >= 59) begin
                                watch_min <= 0;
                            end
                            else begin
                                watch_min <= watch_min + 1;
                            end
                        end
                        else begin
                            watch_sec <= watch_sec + 1;
                        end
                    end
                    else begin
                        cnt_sysclk <= cnt_sysclk + 1;
                    end
                end
                STOP_WATCH_MODE: begin
                    if (start_stop) begin
                        if (cnt_sysclk >= 999_999) begin // 1/100초 카운터
                            cnt_sysclk <= 0;
                            if (sw_csec >= 99) begin
                                sw_csec <= 0;
                                if (sw_sec >= 99) begin
                                    sw_sec <= 0;
                                end
                                else begin
                                    sw_sec <= sw_sec + 1;
                                end
                            end
                            else begin
                                sw_csec <= sw_csec + 1;
                            end
                        end
                        else begin
                            cnt_sysclk <= cnt_sysclk + 1;
                        end
                    end
                    if (btn_clear_pedge) begin
                        sw_sec <= 0;
                        sw_csec <= 0;
                        cnt_sysclk <= 0;
                        start_stop <= 0;
                    end
                end
                default: begin
                    // 예상치 못한 모드일 경우 아무것도 하지 않음
                end
            endcase
        end
    end
    
    // ----------------------------------------------------------------------
    // FND에 표시될 값 결정 (멀티플렉서)
    // ----------------------------------------------------------------------
    // bin_to_dec 모듈 인스턴스화
    bin_to_dec bcd_watch_sec(.bin(watch_sec), .bcd(watch_sec_bcd));
    bin_to_dec bcd_watch_min(.bin(watch_min), .bcd(watch_min_bcd));
    bin_to_dec bcd_sw_sec(.bin(sw_sec), .bcd(sw_sec_bcd));
    bin_to_dec bcd_sw_csec(.bin(sw_csec), .bcd(sw_csec_bcd));

    // mode_state에 따라 FND에 출력될 값 선택
    always @(*) begin
        if (mode_state == WATCH_MODE) begin
            fnd_value_reg = {watch_min_bcd, watch_sec_bcd};
        end
        else begin // STOP_WATCH_MODE
            fnd_value_reg = {sw_sec_bcd, sw_csec_bcd};
        end
    end

    // ----------------------------------------------------------------------
    // FND 모듈 인스턴스화
    // ----------------------------------------------------------------------
    fnd_cntr fnd_inst (
        .clk(clk), .reset_p(reset_p),
        .fnd_value(fnd_value_reg), .hex_bcd(1),
        .seg_7(seg_7), .com(com)
    );

endmodule

module triple_clock (
    input clk,            // 100MHz 시스템 클럭
    input reset_p,        // 리셋 버튼 (액티브 하이)
    input btn_mode,       // 모드 변경 버튼
    input btn_func,       // 기능 제어 버튼 (시작, 정지 등)
    output [7:0] seg_7,   // 7-세그먼트 세그먼트 출력
    output [3:0] com,     // 7-세그먼트 공통 단자 (자리 선택)
    output buzzer         // 부저 출력
);

    //========================================================
    // 1. 내부 신호 선언
    //========================================================
    reg [1:0] mode_reg;   // 현재 모드를 저장하는 2비트 레지스터 (00: Watch, 01: Cook Timer, 10: Stopwatch)
    wire btn_mode_pedge;  // 모드 버튼의 상승 엣지 감지 신호
    wire btn_func_pedge;  // 기능 버튼의 상승 엣지 감지 신호

    // 각 모드의 카운터 및 상태 레지스터
    reg [5:0] sec_reg, min_reg, hour_reg;   // Watch 모드용 시간
    reg [5:0] sw_sec_reg, sw_min_reg;       // Stopwatch 모드용 시간
    reg [1:0] sw_state_reg;                 // Stopwatch 상태 (00: 정지, 01: 동작)
    reg [15:0] cook_counter_reg;            // Cook Timer 카운터
    reg [1:0] cook_state_reg;               // Cook Timer 상태 (00: 정지, 01: 동작, 10: 알람)
    reg buzzer_reg;                         // 부저 제어 레지스터

    // 각 모드의 FND 표시값을 담을 레지스터
    reg [15:0] fnd_value_watch;
    reg [15:0] fnd_value_cook_timer;
    reg [15:0] fnd_value_stop_watch;
    wire [15:0] fnd_value_final;
    
    //========================================================
    // 2. 클럭 분주기 및 엣지 감지
    //========================================================
    // 100MHz 클럭을 1Hz (1초)로 분주하는 카운터
    reg [26:0] counter_1s;
    always @(posedge clk or posedge reset_p) begin
        if (reset_p) begin
            counter_1s <= 27'd0;
        end else if (counter_1s == 27'd50000000 - 1) begin // 0.5초마다
            counter_1s <= 27'd0;
        end else begin
            counter_1s <= counter_1s + 1'b1;
        end
    end
    wire clk_1s = (counter_1s == 27'd50000000 - 1) ? 1'b1 : 1'b0;
    
    // 버튼 엣지 감지 모듈
    edge_detector_p btn_mode_edge (.clk(clk), .reset_p(reset_p), .cp(btn_mode), .p_edge(btn_mode_pedge), .n_edge());
    edge_detector_p btn_func_edge (.clk(clk), .reset_p(reset_p), .cp(btn_func), .p_edge(btn_func_pedge), .n_edge());

    //========================================================
    // 3. 메인 로직 (모드, 타이머, FND 로직 통합)
    //========================================================
    always @(posedge clk or posedge reset_p) begin
        if (reset_p) begin
            // 초기화
            mode_reg <= 2'b00;
            sec_reg <= 6'd0;
            min_reg <= 6'd0;
            hour_reg <= 6'd0;
            sw_sec_reg <= 6'd0;
            sw_min_reg <= 6'd0;
            sw_state_reg <= 2'b00;
            cook_counter_reg <= 16'd0;
            cook_state_reg <= 2'b00;
            buzzer_reg <= 1'b0;
        end else begin
            // 모드 전환
            if (btn_mode_pedge) begin
                case(mode_reg)
                    2'b00: mode_reg <= 2'b01; // Watch -> Cook Timer
                    2'b01: mode_reg <= 2'b10; // Cook Timer -> Stopwatch
                    2'b10: mode_reg <= 2'b00; // Stopwatch -> Watch
                endcase
            end

            // Mux/Demux 기능
            // `case` 문을 사용해 현재 모드에 해당하는 로직만 실행되도록 분리
            case (mode_reg)
                //--- Watch Mode Logic ---
                2'b00: begin
                    if (clk_1s) begin
                        sec_reg <= sec_reg + 1'b1;
                        if (sec_reg == 6'd59) begin
                            sec_reg <= 6'd0;
                            min_reg <= min_reg + 1'b1;
                            if (min_reg == 6'd59) begin
                                min_reg <= 6'd0;
                                hour_reg <= hour_reg + 1'b1;
                                if (hour_reg == 6'd23) begin
                                    hour_reg <= 6'd0;
                                end
                            end
                        end
                    end
                    // FND 값 할당
                    fnd_value_watch <= {hour_reg, min_reg, sec_reg};
                    // 다른 모드 출력 초기화
                    fnd_value_cook_timer <= 16'd0;
                    fnd_value_stop_watch <= 16'd0;
                end
                
                //--- Cook Timer Logic ---
                2'b01: begin
                    case(cook_state_reg)
                        2'b00: begin // 정지 상태
                            if (btn_func_pedge) begin
                                cook_state_reg <= 2'b01; // 버튼 누르면 시작
                            end
                            // FND 값 할당
                            fnd_value_cook_timer <= cook_counter_reg;
                        end
                        2'b01: begin // 동작 상태
                            if (btn_func_pedge) begin
                                cook_state_reg <= 2'b00; // 버튼 누르면 정지
                            end
                            if (clk_1s) begin
                                if (cook_counter_reg > 16'd0) begin
                                    cook_counter_reg <= cook_counter_reg - 1'b1;
                                end else begin
                                    cook_state_reg <= 2'b10; // 0이 되면 알람 상태로 전환
                                end
                            end
                            // FND 값 할당
                            fnd_value_cook_timer <= cook_counter_reg;
                        end
                        2'b10: begin // 알람 상태
                            if (btn_func_pedge) begin
                                cook_state_reg <= 2'b00; // 버튼 누르면 정지
                            end
                            // FND 값 할당
                            fnd_value_cook_timer <= cook_counter_reg;
                            buzzer_reg <= 1'b1; // 부저 울림
                        end
                        default: begin
                            cook_state_reg <= 2'b00;
                            buzzer_reg <= 1'b0;
                        end
                    endcase
                end
                
                //--- Stopwatch Logic ---
                2'b10: begin
                    case(sw_state_reg)
                        2'b00: begin // 정지 상태
                            if (btn_func_pedge) begin
                                sw_state_reg <= 2'b01; // 버튼 누르면 시작
                            end
                            // FND 값 할당
                            fnd_value_stop_watch <= {sw_min_reg, sw_sec_reg};
                        end
                        2'b01: begin // 동작 상태
                            if (btn_func_pedge) begin
                                sw_state_reg <= 2'b00; // 버튼 누르면 정지
                            end
                            if (clk_1s) begin
                                sw_sec_reg <= sw_sec_reg + 1'b1;
                                if (sw_sec_reg == 6'd59) begin
                                    sw_sec_reg <= 6'd0;
                                    sw_min_reg <= sw_min_reg + 1'b1;
                                end
                            end
                            // FND 값 할당
                            fnd_value_stop_watch <= {sw_min_reg, sw_sec_reg};
                        end
                        default: begin
                            sw_state_reg <= 2'b00;
                            sw_sec_reg <= 6'd0;
                            sw_min_reg <= 6'd0;
                        end
                    endcase
                end
            endcase
        end
    end

    //========================================================
    // 4. Mux 기능 (최종 FND 출력값 선택)
    //========================================================
    // `mode_reg`에 따라 어떤 FND 값을 최종 출력으로 보낼지 결정
    assign fnd_value_final = (mode_reg == 2'b00) ? fnd_value_watch :
                             (mode_reg == 2'b01) ? fnd_value_cook_timer :
                             (mode_reg == 2'b10) ? fnd_value_stop_watch : 16'hFFFF;

    //========================================================
    // 5. FND 컨트롤러 및 부저 출력 연결
    //========================================================
    fnd_cntr fnd_inst(
        .clk(clk), .reset_p(reset_p), .fnd_value(fnd_value_final), .hex_bcd(1'b0), .seg_7(seg_7), .com(com)
    );
    
    assign buzzer = buzzer_reg;
    
endmodule


module trinity_clock_top(
    input clk, reset_p,
    input [3:0] btn,
    
    output reg [7:0] seg_7,
    output reg [3:0] com,
    output reg [15:0] led,
    output reg alarm
);

    
    wire btn_mode;
    btn_cntr mode_btn(
        .clk(clk), 
        .reset_p(reset_p),
        .btn(btn[3]), 
        .btn_pedge(btn_mode)
    );

    reg [1:0] mode = 2'b00;
    always @(posedge clk, posedge reset_p) begin
        if(reset_p) begin
    
        end
        else if(btn_mode) begin
            case(mode)
                2'b00: mode = 2'b01;    // watch -> cook_timer
                2'b01: mode = 2'b10;    // cook_timer -> stop_watch
                2'b10: mode = 2'b00;    // stop_watch -> watch
                default: mode = 2'b00; 
            endcase
        end
    end
    
    wire [7:0] watch_seg_7;
    wire [3:0] watch_com;
    wire [15:0] watch_led;
    
    watch_top watch_top_mode(
        .clk(clk),
        .reset_p(reset_p),
        .btn(btn[2:0]),  
        .seg_7(watch_seg_7),
        .com(watch_com),
        .led(watch_led)
    );
    
    wire [7:0] cook_timer_seg_7;
    wire [3:0] cook_timer_com;
    wire [15:0] cook_timer_led;
    wire cook_timer_alarm;
    
    cook_timer cook_timer_mode(
        .clk(clk),
        .reset_p(reset_p),
        .btn(btn[3:0]),  
        .seg_7(cook_timer_seg_7),
        .com(cook_timer_com),
        .alarm(cook_timer_alarm),
        .led(cook_timer_led)
    );
    
    wire [7:0] stop_watch_seg_7;
    wire [3:0] stop_watch_com;
    wire [15:0] stop_watch_led;
    
    stop_watch stop_watch_mode(
        .clk(clk),
        .reset_p(reset_p),
        .btn(btn[2:0]),  
        .seg_7(stop_watch_seg_7),
        .com(stop_watch_com),
        .led(stop_watch_led)
    );

    always @(*) begin
        case(mode)
            2'b00: begin  // watch
                seg_7 = watch_seg_7;
                com = watch_com;
                led = watch_led;
                alarm = 0;
            end
            2'b01: begin  // cook_timer
                seg_7 = cook_timer_seg_7;
                com = cook_timer_com;
                led = cook_timer_led;
                alarm = cook_timer_alarm;
            end
            2'b10: begin  // stop_watch
                seg_7 = stop_watch_seg_7;
                com = stop_watch_com;
                led = stop_watch_led;
                alarm = 0;
            end
            default: begin
                seg_7 = 0;
                com = 0;
                led = 0;    
                alarm = 0;  
            end
        endcase
    end
endmodule


module homework_watch_top (
    input clk,            // 100MHz 시스템 클럭
    input reset_p,        // 리셋 버튼 (액티브 하이)
    input btn_mode,       // 모드 변경 버튼
    input btn_func,       // 기능 제어 버튼 (시작, 정지 등)
    output [7:0] seg_7,   // 7-세그먼트 세그먼트 출력
    output [3:0] com,     // 7-세그먼트 공통 단자 (자리 선택)
    output buzzer         // 부저 출력
);
    //========================================================
    // 1. 내부 신호 선언
    //========================================================
    reg [1:0] mode_reg;   // 현재 모드를 저장하는 2비트 레지스터 (00: Watch, 01: Cook Timer, 10: Stopwatch)
    wire btn_mode_pedge;  // 모드 버튼의 상승 엣지 감지 신호
    wire btn_func_pedge;  // 기능 버튼의 상승 엣지 감지 신호

    // 각 모듈의 버튼 입력 신호 (Demux)
    wire btn_watch;
    wire btn_cook_timer;
    wire btn_stop_watch;
    
    // 각 모듈의 출력 신호
    wire [15:0] fnd_value_watch;
    wire [15:0] fnd_value_cook_timer;
    wire [15:0] fnd_value_stop_watch;
    wire buzzer_cook_timer;
    
    // FND 컨트롤러 입력
    wire [15:0] fnd_value_final;
    
    //========================================================
    // 2. 클럭 분주기 및 엣지 감지
    //========================================================
    // 버튼 엣지 감지 모듈
    edge_detector_p btn_mode_edge (.clk(clk), .reset_p(reset_p), .cp(btn_mode), .p_edge(btn_mode_pedge), .n_edge());
    edge_detector_p btn_func_edge (.clk(clk), .reset_p(reset_p), .cp(btn_func), .p_edge(btn_func_pedge), .n_edge());

    //========================================================
    // 3. 모드 전환 및 버튼 분배 (Demux) 로직
    //========================================================
    // 모드 전환
    always @(posedge clk or posedge reset_p) begin
        if (reset_p) begin
            mode_reg <= 2'b00;
        end else if (btn_mode_pedge) begin
            case(mode_reg)
                2'b00: mode_reg <= 2'b01; // Watch -> Cook Timer
                2'b01: mode_reg <= 2'b10; // Cook Timer -> Stopwatch
                2'b10: mode_reg <= 2'b00; // Stopwatch -> Watch
            endcase
        end
    end
    
    // 버튼 분배 (Demux)
    assign btn_watch      = (mode_reg == 2'b00) ? btn_func_pedge : 1'b0;
    assign btn_cook_timer = (mode_reg == 2'b01) ? btn_func_pedge : 1'b0;
    assign btn_stop_watch = (mode_reg == 2'b10) ? btn_func_pedge : 1'b0;
    
    //========================================================
    // 4. 모듈 인스턴스화
    //========================================================
    // watch 모듈 인스턴스
    watch_top watch_inst (
        .clk(clk),
        .reset_p(reset_p),
        .btn_func(btn_watch),
        .fnd_value(fnd_value_watch)
    );
    
    // cook_timer 모듈 인스턴스
    cook_timer cook_timer_inst (
        .clk(clk),
        .reset_p(reset_p),
        .btn_func(btn_cook_timer),
        .fnd_value(fnd_value_cook_timer),
        .buzzer(buzzer_cook_timer)
    );

    // stop_watch 모듈 인스턴스
    stop_watch stop_watch_inst (
        .clk(clk),
        .reset_p(reset_p),
        .btn_func(btn_stop_watch),
        .fnd_value(fnd_value_stop_watch)
    );
    
    //========================================================
    // 5. FND 및 부저 출력 Mux 로직
    //========================================================
    // `mode_reg`에 따라 어떤 FND 값을 최종 출력으로 보낼지 결정
    assign fnd_value_final = (mode_reg == 2'b00) ? fnd_value_watch :
                             (mode_reg == 2'b01) ? fnd_value_cook_timer :
                             (mode_reg == 2'b10) ? fnd_value_stop_watch : 16'hFFFF;
    
    // 부저 출력 선택
    assign buzzer = (mode_reg == 2'b01) ? buzzer_cook_timer : 1'b0;

    //========================================================
    // 6. FND 컨트롤러 연결
    //========================================================
    fnd_cntr fnd_inst(
        .clk(clk), .reset_p(reset_p), .fnd_value(fnd_value_final), .hex_bcd(1'b0), .seg_7(seg_7), .com(com)
    );
    
endmodule