`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/20/2025 08:22:37 PM
// Design Name: 
// Module Name: tb_cora_loadable_down_counter_dec_60
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


module tb_loadable_down_counter_dec_60();
reg clk, reset_p;
reg clk_time, load_enable;
reg [3:0] set_value1, set_value10;
wire [3:0]dec1, dec10;
wire dec_clk;

integer i = 0;

loadable_down_counter_dec_60 DUT(clk, reset_p, clk_time, load_enable, set_value1, set_value10, dec1, dec10, dec_clk);
    
initial begin
    clk = 0; reset_p = 1; clk_time = 0; load_enable = 1; set_value1 = 5; set_value10 = 3;    
end

always #5 clk = ~clk;

initial begin
    #10; reset_p = 0; #10; 
    load_enable = 0; #10;
    #980;
    
    for(i = 0; i < 40; i = i+1)begin
        clk_time = 1; #10;
        clk_time = 0; #990;
        $display("%d, %d", dec10, dec1);
    end
    $stop;
end
endmodule