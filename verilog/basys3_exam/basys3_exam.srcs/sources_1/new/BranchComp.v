`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/16/2025 03:31:04 PM
// Design Name: 
// Module Name: BranchComp
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


module BranchComp(
    output BrEq, BrLT,      // Eq = 1이면 같은거고 LT가 1이면 작은거이다. 둘다 1일순 없으나 0은 될 수있음.(크다)
    input [31:0] RD1, RD2,
    input BrUn
    );
    
    wire s_BrLT;
    assign s_BrLT = (RD1[31] > RD2[31]) ? 1 : ((RD1[30:0] > RD2[30:0]) ? 1 : 0);
    assign BrEq = (RD1 == RD2);
    assign BrLT = BrUn ? (RD1 < RD2) : s_BrLT;
    
endmodule
