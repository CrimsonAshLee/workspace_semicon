`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/13/2025 11:50:01 AM
// Design Name: 
// Module Name: ALU
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


module ALU(
    input signed [31:0] A, B,   // 음수까지 읽기위해 signed
    output [31:0] ALU_o,
    input [3:0] ALUSel
    );
    
    wire signed [31:0] ADD, SUB, SLL, SLT, SLTU, XOR, SRL, SRA, OR, AND;
    
    assign ADD = A + B;
    assign SUB = A - B;
    assign SLL = A << B;
    assign SLT = A < B;
    assign SLTU = A < B;
    assign XOR = A ^ B;
    assign SRL = A >> B;
    assign SRA = A >>> B;
    assign OR = A | B;
    assign AND = A & B;
    
    assign ALU_o = (ALUSel == 4'b0000) ? ADD :
                   (ALUSel == 4'b1000) ? SUB :
                   (ALUSel == 4'b0001) ? SLL :
                   (ALUSel == 4'b0010) ? SLT :
                   (ALUSel == 4'b0011) ? SLTU :
                   (ALUSel == 4'b0100) ? XOR :
                   (ALUSel == 4'b0101) ? SRL : 
                   (ALUSel == 4'b1101) ? SRA :
                   (ALUSel == 4'b0110) ? OR :
                   (ALUSel == 4'b0111) ? ADD : 0;
            
    
endmodule
