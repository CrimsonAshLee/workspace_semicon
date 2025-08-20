`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/20/2025 07:52:49 PM
// Design Name: 
// Module Name: cora_counter_fnd_top
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


module counter_fnd_top(
    input clk, reset_p, btn1,
    output [7:0] seg_7,
    output [3:0] com
);
    wire [11:0] count;
    
    reg [25:0] clk_div;
    
    always @(posedge clk) clk_div = clk_div + 1;
        
    wire up_down;
    D_flip_flop_p D_up(.d(btn1), .clk(clk_div[16]), .reset_p(reset_p), .q(up_down));
    
    wire up_down_p;
    edge_detector_n detec_n(.clk(clk), .cp_in(up_down), .reset_p(reset_p), .p_edge(up_down_p));
    
    wire up;
    T_flip_flop_p T_up(.clk(clk), .t(up_down_p), .reset_p(reset_p), .q(up));
        
    up_down_counter_Nbit_p #(.N(12)) counter_fnd(.clk(clk_div[25]), .reset_p(reset_p), .up_down(~up), .count(count)); 
        
    wire [15:0] dec_value;
    bin_to_dec bin2dec (.bin(count), .bcd(dec_value));// bin-dec converter 
        
    FND_4digit_cntr fnd_cntr(.clk(clk), .reset_p(reset_p),.value(dec_value), .com(com), .seg_7(seg_7));
        

endmodule