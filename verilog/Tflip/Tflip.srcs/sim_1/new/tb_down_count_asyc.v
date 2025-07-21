`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/21/2025 11:45:58 AM
// Design Name: 
// Module Name: tb_down_count_asyc
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


module tb_down_count_asyc;

    reg clk;
    reg reset_p;
    wire [3:0] count;


    down_counter_asyc uut(
        .clk(clk),
        .reset_p(reset_p),
        .count(count)
    );

    always #5 clk = ~clk;
        
    initial begin
        clk = 0;
        reset_p = 1;

        #20;
        reset_p = 0;

        #300;

        $finish;
    end
    
endmodule


module tb_down_counter_p;
    
    reg clk;
    reg reset_p;
    reg enable;

    wire [3:0] down_count;

    down_counter_p uut(
        .clk(clk),
        .reset_p(reset_p),
        .enable(enable),
        .count(down_count)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        reset_p = 1;
        enable = 0;

        #10 reset_p = 0;
        #10 enable = 1;     // 카운트 시작

        #200;

        enable = 0;
        #20;

        reset_p = 1;
        #10 reset_p = 0;
        #20;

        $finish;
    end
endmodule