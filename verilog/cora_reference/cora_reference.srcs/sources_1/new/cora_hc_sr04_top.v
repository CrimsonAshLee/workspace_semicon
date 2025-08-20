`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/20/2025 08:06:25 PM
// Design Name: 
// Module Name: cora_hc_sr04_top
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


module hc_sr04_top(
    input clk, reset_p,
    input echo,
    output trigger,
    output [3:0] com,
    output [7:0] seg_7,
    output [7:0] led_bar
);
    wire [15:0] distance;
    wire [15:0] distance_dec;
    HC_SR04 ults(.clk(clk), .reset_p(reset_p), .echo(echo), .trigger(trigger), .distance(distance), .led_bar(led_bar));
    bin_to_dec b2d(.bin(distance), .bcd(distance_dec));
    
    FND_4digit_cntr fnd_cntr(.clk(clk), .reset_p(reset_p), .value(distance_dec), .com(com), .seg_7(seg_7));

endmodule

