`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/13/2025 03:30:15 PM
// Design Name: 
// Module Name: ImmGen
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


module ImmGen(
    input [2:0] ImmSel,
    input [24:0] inst_Imm,  // opcode 7bit를 빼고 나머지 25bit
    output [31:0] Imm
    );
    
    wire [31:0] I, B, U, J, S;
    
    assign I = {{20{inst_Imm[24]}}, inst_Imm[24 -: 12]};  // 24번 비트부터 12비트
    assign B = {{19{inst_Imm[24]}}, inst_Imm[24], inst_Imm[0], inst_Imm[23 -: 6], inst_Imm[4:1], 1'b0}; // 23번부터 6개
    assign U = {inst_Imm[24 -: 20], 12'b0};
    
endmodule
