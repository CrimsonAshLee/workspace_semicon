`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/15/2025 03:15:24 PM
// Design Name: 
// Module Name: data_mem
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


module data_mem(
    output [31:0] ReadData,
    input [31:0] ADDR, WriteData,
    input clk, MemWrite     // 메모리는 리셋을 안해서 reset_p 안만듬
    );
    
    reg [7:0] MEM_Data [0:65535*4];  // 실직적인 8비트 데이터 메모리
    
    assign ReadData = {MEM_Data[ADDR+3], MEM_Data[ADDR+2], MEM_Data[ADDR+1], MEM_Data[ADDR]};
    
    always @(posedge clk)begin
        if(MemWrite)begin
            MEM_Data[ADDR+3]   = WriteData[31:24];
            MEM_Data[ADDR+2] = WriteData[23:16];
            MEM_Data[ADDR+1] = WriteData[15:8];
            MEM_Data[ADDR] = WriteData[7:0];
        end
    end
    
endmodule
