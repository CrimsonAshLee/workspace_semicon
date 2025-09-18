`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/18/2025 04:44:36 PM
// Design Name: 
// Module Name: cntr
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


module seven_segment_decoder(
    input [3:0] number,
    output reg [7:0] seg
    );

    always @(*) begin
        case(number)
            4'h0: seg = 8'b0111111; // 0
            4'h1: seg = 8'b0000110; // 1
            4'h2: seg = 8'b1011011; // 2
            4'h3: seg = 8'b1001111; // 3
            4'h4: seg = 8'b1100110; // 4
            4'h5: seg = 8'b1101101; // 5
            4'h6: seg = 8'b1111101; // 6
            4'h7: seg = 8'b0000111; // 7
            4'h8: seg = 8'b1111111; // 8
            4'h9: seg = 8'b1101111; // 9
            default: seg = 8'b0000000; // 빈칸
        endcase
    end
endmodule