`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/20/2025 08:25:11 PM
// Design Name: 
// Module Name: tb_cora_shift_register_PISO
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


module tb_shift_register_PISO();
    
    reg [3:0] d;
    reg clk, reset_p, shift_load;
    wire q;                     //output
    
    shift_register_PISO DUT(d, clk, reset_p, shift_load, q);
    
    initial begin
        d = 4'b1010;
        clk = 0;
        reset_p = 1;
        shift_load = 0;         //initial input
    end
    
    always #4 clk = ~clk;       //8ns clk
    
    initial begin
        #8;
        reset_p = 0; #8;        
        shift_load = 1'b1; #32; //4 clk
        d = 4'b1100; #8;
        shift_load = 0; #8;
        shift_load = 1; #32;
        $stop;        
    end
     
endmodule


