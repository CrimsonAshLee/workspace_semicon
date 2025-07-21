`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/21/2025 10:52:46 AM
// Design Name: 
// Module Name: tb_T_flip_flop
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


module tb_T_flip_flop_n;

    reg clk, reset_p, t;
    wire q;

    T_flip_flop_n uut (
        .clk(clk),
        .reset_p(reset_p),
        .t(t),
        .q(q)
    );

    initial begin
        clk = 0;
        forever begin
             #5 clk = ~clk;
        end
    end

    initial begin
        reset_p = 1;
        t = 0;
        #10 reset_p = 0;

        t = 1; #10;
        #10;
        #10;
        t = 0; #20;
        t = 1; #10;
        #10;

        reset_p = 1; #10;
        reset_p = 0; 

        t = 1; #20;

        $finish;
    end

endmodule