`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/20/2025 08:05:41 PM
// Design Name: 
// Module Name: cora_FND_4digit_cntr
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


module FND_4digit_cntr(
    input clk, reset_p,
    input [15:0] value,
    output [3:0] com,
    output [7:0] seg_7
);
    
    wire [7:0] seg_7_font;

    reg [16:0] clk_1ms;
    always @(posedge clk) clk_1ms = clk_1ms + 1;
    
    ring_counter_fnd (.clk(clk_1ms[16]), .com(com));
        
    reg [3:0] hex_value;
    
    decoder_7seg (.hex_value(hex_value), .seg_7(seg_7_font));
    
    assign seg_7 = ~seg_7_font;

    always @(negedge clk) begin
        case(com)
            4'b1110 : hex_value = value[15:12];
            4'b1101 : hex_value = value[11:8];
            4'b1011 : hex_value = value[7:4];
            4'b0111 : hex_value = value[3:0];
        endcase    
    end
    
endmodule


