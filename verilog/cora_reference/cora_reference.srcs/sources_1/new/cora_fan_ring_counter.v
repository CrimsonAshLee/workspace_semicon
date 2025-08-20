`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/20/2025 08:00:50 PM
// Design Name: 
// Module Name: cora_fan_ring_counter
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


module fan_ring_counter(
        input clk, reset_p,
        input btn,
        output reg [3:0] ring
    );
    
    always @(posedge clk or posedge reset_p)begin
        if(reset_p) ring = 4'b0001;
        else if(btn) begin
            if(ring == 4'b0001) ring = 4'b0010;
            else if(ring == 4'b0010) ring = 4'b0100;
            else if(ring == 4'b0100) ring = 4'b1000;
            else if(ring == 4'b1000) ring = 4'b0001;
            else ring = 4'b0001;                 // µðÆúÆ® °ª
        end 
    end
endmodule
