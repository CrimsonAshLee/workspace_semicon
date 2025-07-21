`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/21/2025 03:11:58 PM
// Design Name: 
// Module Name: tb_edge_detect
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


module tb_edge_detector_n;

    reg clk;
    reg reset_p;
    reg cp;

    wire p_edge;
    wire n_edge;

    edge_dectector_n dut(
        .clk(clk),
        .reset_p(reset_p),
        .cp(cp),
        .p_edge(p_edge),
        .n_edge(n_edge)
    );

    always #5 clk = ~clk;

    initial begin
    
        clk = 0;
        reset_p = 1;
        cp = 0;

        #12;
        reset_p = 0;

        #10 cp = 1;     // 라이징 기대
        #10 cp = 0;     // 폴링 기대
        #10 cp = 1;
        #10 cp = 0;
        #10 cp = 1;
        #10 cp = 1;     // 변화없음
        #10 cp = 0;

        #20;
        $stop;

    end
endmodule
