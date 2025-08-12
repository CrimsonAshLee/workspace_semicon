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