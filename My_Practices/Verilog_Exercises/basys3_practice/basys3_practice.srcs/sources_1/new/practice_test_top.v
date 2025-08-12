`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/12/2025 06:47:38 PM
// Design Name: 
// Module Name: practice_test_top
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


module ring_counter_led_edge_detector_p_top(
    input clk, reset_p,
    output reg [15:0] led
    );

    reg [20:0] clk_div;
    always @(posedge clk) begin
        clk_div = clk_div + 1;
    end

    wire clk_div_18;
    edge_detector_p clk_div_edge(
        .clk(clk),
        .reset_p(reset_p),
        .cp(clk_div[18]),
        .p_edge(clk_div_18)
    );

    always @(posedge clk or posedge reset_p) begin
        if (reset_p) begin
            led = 16'b0000_0000_0000_0001;
        end
        else if (clk_div_18) begin
            led = {led[14:0], led[15]};
        end
    end
endmodule


module watch_top (
    input clk, reset_p,
    input [2:0] btn,

    output [7:0] seg_7,
    output [3:0] com,
    output [15:0] led
);
    
    wire btn_mode, inc_sec, inc_min;

    debounce btn_0(
        .clk(clk),
        .btn_in(btn[0]),
        .btn_out(btn_mode)
    );

    debounce btn_1(
        .clk(clk),
        .btn_in(btn[1]),
        .btn_out(inc_sec)
    );

    debounce btn_2(
        .clk(clk),
        .btn_in(btn[2]),
        .btn_out(inc_min)
    );
    wire mode_btn_pedge;
    edge_detector_p mode_ed(
        .clk(clk),
        .reset_p(reset_p),
        .cp(btn_mode),
        .p_edge(mode_btn_pedge)
    );

    reg set_watch;
    assign led[0] = set_watch;
    always @(posedge clk, posedge reset_p) begin
        if (reset_p) begin
            set_watch = 0;
        end
        else if (mode_btn_pedge) begin
            set_watch = ~set_watch;
        end
    end

    reg [26:0] cnt_sysclk;
    reg [7:0] sec, min;
    always @(posedge clk, posedge reset_p) begin
        if (reset_p) begin
            cnt_sysclk = 0;
            sec = 0;
            min = 0;
        end
        else begin
            if (cnt_sysclk >= 27'd100_000_000) begin
                cnt_sysclk = 0;
                if (sec >= 59) begin
                    sec = 0;
                    if (min >= 59) begin
                        min = 0;
                    end
                    else begin
                        min = min + 1;
                    end
                end
                else begin
                    sec = sec + 1;
                end
            end
            else begin
                cnt_sysclk = cnt_sysclk + 1;
            end
        end
    end
    wire [15:0] sec_bcd, min_bcd;
    bin_to_dec bcd_sec(
        .bin(sec),
        .bcd(sec_bcd)
    );
    bin_to_dec bcd_min(
        .bin(min),
        .bcd(min_bcd)
    );
    fnd_cntr fnd(
        .clk(clk),
        .reset_p(reset_p),
        .fnd_value({min_bcd[7:0], sec[7:0]}),
        .hex_bcd(1),
        .seg_7(seg_7),
        .com(com)
    );

endmodule

module cook_timer (
    input clk, reset_p,                 // 클럭 입력, 리셋 입력
    input [3:0] btn,                    // 4개의 버튼 입력 (4비트 벡터)
    output [7:0] seg_7,                 // 7세그먼트 디스플레이 출력
    output [3:0] com,                   // 7세그먼트 공통 단자 출력 (선택자)
    output reg alarm,                   // 알람 상태 출력
    output [14:0] led                   // 디버깅용 led 출력
);
    reg [7:0] set_sec, set_min;         // 타이머 시작 시점의 초, 분을 저장하는 레지스터
    reg start_set;                      // 타이머 동작 상태를 저장하는 레지스터 (1: 동작 중, 0: 정지)
    reg [26:0] cnt_sysclk = 0;          // 1초를 만들기 위한 클럭 카운터
    reg [7:0] sec, min;                 // 현재 초, 분을 저장하는 레지스터
    reg set_flag;                       // 알람이 꺼졌을 때, 시간을 재설정하기 위한 플래그

    wire btn_mode, inc_sec, inc_min, alarm_off; // 버튼 입력들을 감지할 와이어
    wire [15:0] cur_time = {min, sec};      // 현재 초와 분을 합친 16비트 값
    wire [7:0] sec_bcd, min_bcd;        // BCD 변환된 초, 분 값

    // 4개의 버튼에 대해 각각 btn_cntr 모듈을 인스턴스화하여 버튼 눌림 순간을 감지
    btn_cntr mode_btn(                  // btn[0]: 모드 변경 (설정 -> 타이머 시작/정지)
    .clk(clk), 
    .reset_p(reset_p),
    .btn(btn[0]),
    .btn_pedge(btn_mode)
    );

    btn_cntr inc_sec_btn(               // btn[1]: 초 증가
    .clk(clk), 
    .reset_p(reset_p),
    .btn(btn[1]),
    .btn_pedge(inc_sec)
    );

    btn_cntr inc_min_btn(               // btn[2]: 분 증가
        .clk(clk), 
        .reset_p(reset_p),
        .btn(btn[2]),
        .btn_pedge(inc_min)
    );

    btn_cntr alarm_off_btn(             // btn[3]: 알람 끄기
        .clk(clk),
        .reset_p(reset_p),
        .btn(btn[3]),
        .btn_pedge(alarm_off)
    );
    
    assign led[0] = start_set;          // 타이머 동작 상태를 LED로 표시
    always @(posedge clk, posedge reset_p) begin
        if(reset_p) begin                   // 리셋 시
            start_set = 0;                  // 타이머 정지
            alarm = 0;                      // 알람 끄기
        end
        // 모드 버튼이 눌리고, 시간이 0이 아니며, 타이머가 정지 상태일 때
        else if(btn_mode && cur_time != 0 && start_set == 0)begin
            start_set = 1;                  // 타이머 시작
            set_sec = sec;                  // 현재 초를 set_sec에 저장
            set_min = min;                  // 현재 분을 set_min에 저장
        end
        else if (start_set && btn_mode) begin // 타이머 동작 중 모드 버튼이 눌리면
            start_set = 0;                  // 타이머 정지
        end
        // 타이머 동작 중 시간이 0이 되면
        else if (start_set && min == 0 && sec == 0) begin
            start_set = 0;                  // 타이머 정지
            alarm = 1;                      // 알람 시작
        end
        // 알람이 울리는 상태에서, 아무 버튼이나 눌리면 (btn_mode 포함)
        else if (alarm && (alarm_off || inc_sec || inc_min || btn_mode)) begin
            alarm = 0;                      // 알람 끄기
            set_flag = 1;                   // 시간을 재설정해야 한다는 플래그 설정
        end
        // 현재 시간이 0이 아니면
        else if (cur_time != 0) begin
            set_flag = 0;                   // set_flag 초기화
        end
    end 
    
    always @(posedge clk, posedge reset_p) begin
        if(reset_p)begin
            cnt_sysclk = 0;
            sec = 0;
            min = 0;
        end
        else begin
            if (start_set) begin             // 타이머 동작 중일 때
                if (cnt_sysclk >= 99_999_999) begin // Q) -1 하는 이유? (1초 카운트)
                    cnt_sysclk = 0;         // 카운터 리셋
                    if (sec == 0) begin     // 초가 0이면
                        if (min) begin      // 분이 0이 아니면
                            sec = 59;       // 초를 59로
                            min = min - 1;  // 분을 1 감소
                        end
                    end
                    else sec = sec - 1;     // 초를 1 감소
                end
                else cnt_sysclk = cnt_sysclk + 1; // 1초가 안 지났으면 카운터 증가
            end
            else begin                      // 타이머가 멈춰 있을 때
                if (inc_sec) begin          // 초 증가 버튼이 눌리면
                    if (sec >= 59) begin
                        sec = 0;
                    end
                    else begin
                        sec = sec + 1;
                    end
                end
                else if (inc_min) begin     // 분 증가 버튼이 눌리면
                    if (min >= 99) begin
                        min = 0;
                    end
                    else begin
                        min = min + 1;
                    end
                end
                if (set_flag) begin         // set_flag가 설정되었으면
                        sec = set_sec;      // 저장된 시간으로 초를 재설정
                        min = set_min;      // 저장된 시간으로 분을 재설정
                end
            end
        end
    end

    bin_to_dec bcd_sec(.bin(sec), .bcd(sec_bcd)); // 2진수 sec를 BCD로 변환
    bin_to_dec bcd_min(.bin(min), .bcd(min_bcd)); // 2진수 min을 BCD로 변환

    fnd_cntr fnd(.clk(clk), .reset_p(reset_p),
    .fnd_value({min_bcd[7:0], sec_bcd[7:0]}), .hex_bcd(1),
    .seg_7(seg_7), .com(com));  // FND 모듈을 통해 BCD 값을 화면에 표시


endmodule


