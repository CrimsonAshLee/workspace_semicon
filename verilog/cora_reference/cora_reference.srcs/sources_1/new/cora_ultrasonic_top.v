`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/20/2025 08:14:58 PM
// Design Name: 
// Module Name: cora_ultrasonic_top
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


module ultrasonic_top(
    input clk, reset_p,
    input echo,
    output trig,
    output [7:0] led_bar,
    output [3:0] com,
    output [7:0] seg_7
    );
    
    wire [15:0] distance_cm;
    ultrasonic sr04(clk, reset_p, echo, trig, distance_cm, led_bar);
    
    wire [15:0] value;
    bin_to_dec b2d(.bin(distance_cm[11:0]), .bcd(value));
    
    FND_4digit_cntr fnd_cntr(.clk(clk), .reset_p(reset_p), .value(value), .com(com), .seg_7(seg_7));
               
endmodule
