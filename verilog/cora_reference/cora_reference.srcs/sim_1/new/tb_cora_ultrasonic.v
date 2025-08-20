`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/20/2025 08:26:02 PM
// Design Name: 
// Module Name: tb_cora_ultrasonic
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


module tb_ultrasonic();
    reg clk, reset_p;
    reg echo;
    wire trig;
    wire [15:0] distance_cm;
    wire [7:0] led_bar;

    ultrasonic DUT(clk, reset_p, echo, trig, distance_cm, led_bar);

    parameter data1 = 58 * 10 * 1000;
    parameter data2 = 58 * 23 * 1000;
    
    initial begin
        clk = 0;
        reset_p = 1;
        echo = 0;
    end
    
    always #4 clk = ~clk;
    
    integer i;
    
    initial begin
        #8; reset_p = 0; #8;
        for(i=0;i<16;i=i+1)begin
            wait(trig);
            wait(!trig);
            #28000;
            echo = 1; #data1;
            echo = 0; 
        end
        for(i=0;i<16;i=i+1)begin
            wait(trig);
            wait(!trig);
            #28000;
            echo = 1; #data2;
            echo = 0; 
        end  
        #28000; $stop;
    end

endmodule
