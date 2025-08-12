`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/12/2025 06:35:35 PM
// Design Name: 
// Module Name: prof_test_top
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
    input clk, reset_p,
    output reg [15:0] led);
    
    reg [20:0] clk_div;
    always @(posedge clk)clk_div = clk_div + 1;
    wire clk_div_18;
    edge_detector_p clk_div_edge(
        .clk(clk), .reset_p(reset_p), .cp(clk_div[18]),
        .p_edge(clk_div_18));
    
    always @(posedge clk or posedge reset_p)begin
        if(reset_p)led = 16'b0000_0000_0000_0001;
        else if(clk_div_18)led = {led[14:0], led[15]};
    end
    
endmodule

module watch_top(
    input clk, reset_p,
    input [2:0] btn,
    output [7:0] seg_7,
    output [3:0] com,
    output [15:0] led);
    
    wire btn_mode, inc_sec, inc_min;
    
    debounce btn_0(.clk(clk), .btn_in(btn[0]), .btn_out(btn_mode));
    debounce btn_1(.clk(clk), .btn_in(btn[1]), .btn_out(inc_sec));
    debounce btn_2(.clk(clk), .btn_in(btn[2]), .btn_out(inc_min));
    wire mode_btn_pedge;
    edge_detector_p mode_ed(
        .clk(clk), .reset_p(reset_p), .cp(btn_mode),
        .p_edge(mode_btn_pedge));
    
    reg set_watch;
    assign led[0] = set_watch;
    always @(posedge clk, posedge reset_p)begin
        if(reset_p)begin
            set_watch = 0;
        end
        else if(mode_btn_pedge)begin
            set_watch = ~set_watch;
        end
    end

    reg [26:0] cnt_sysclk;
    reg [7:0] sec, min;
    always @(posedge clk, posedge reset_p)begin
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

