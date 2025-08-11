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
    output [3:0] com
);

    // wire [2:0] debounce_btn;
    wire btn_mode, inc_sec, inc_min;    // 벡터보단 구별이 편함

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

    reg [26:0] cnt_sysclk;
    reg [7:0] sec, min;
    always @(posedge clk, posedge reset_p) begin
        if(reset_p)begin
            cnt_sysclk = 0;
            sec = 0;
            min = 0;
        end
        else begin
            if(cnt_sysclk >= 27'd100_000_000)begin
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

    wire [15:0] sec_bcd, min_bcd;

    bin_to_dec bcd_sec(.bin(sec), .bcd(sec_bcd));
    bin_to_dec bcd_min(.bin(min), .bcd(min_bcd));

    fnd_cntr fnd(.clk(clk), .reset_p(reset_p),
    .fnd_value({min_bcd[7:0], sec_bcd[7:0]}), .hex_bcd(1),
    .seg_7(seg_7), .com(com));

endmodule