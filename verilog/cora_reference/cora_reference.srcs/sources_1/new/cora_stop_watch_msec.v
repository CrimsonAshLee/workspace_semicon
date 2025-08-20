`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/20/2025 08:12:35 PM
// Design Name: 
// Module Name: cora_stop_watch_msec
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


module stop_watch_msec(
    input clk,
    input reset_p,
    input [1:0] btn,
    output [15:0] value,
    output lap
    );
       
    reg [16:0] clk_div;
    wire btn_start;
    wire btn_lap, start_stop;

    button_cntr bcntr_start(.clk(clk), .reset_p(reset_p), .btn(btn[0]), .btn_pe(btn_start));
    button_cntr bcntr_lap(.clk(clk), .reset_p(reset_p), .btn(btn[1]), .btn_pe(btn_lap));
    T_flip_flop_p T_up1(.clk(clk), .t(btn_start), .reset_p(reset_p), .q(start_stop));
    T_flip_flop_p T_up2(.clk(clk), .t(btn_lap), .reset_p(reset_p), .q(lap));
        
    wire clk_usec, clk_msec, clk_sec;
    wire clk_start;
    assign clk_start = start_stop ? clk_usec : 0;
    clock_usec usec_clk(.clk(clk), .reset_p(reset_p), .clk_usec(clk_usec));
    clock_div_1000 msec_clk(.clk(clk), .clk_source(clk_start), .reset_p(reset_p), .clk_div_1000(clk_msec));
    clock_div_1000 sec_clk(.clk(clk), .clk_source(clk_msec), .reset_p(reset_p), .clk_div_1000(clk_sec));
     
    wire [3:0] msec100, msec10, msec1;
    counter_dec_1000 dec_msec_100(.clk(clk), .reset_p(reset_p), .clk_time(clk_msec), .msec1(msec1), .msec10(msec10), .msec100(msec100));
    
    wire [3:0] sec10, sec1;
    counter_dec_60 dec_sec_60(.clk(clk), .reset_p(reset_p), .clk_time(clk_sec), .dec1(sec1), .dec10(sec10));   
       
    reg [15:0] lap_value;
    always @(posedge clk or posedge reset_p) begin
        if(reset_p) lap_value = 0; 
        else if(btn_lap) lap_value = {sec10, sec1, msec100, msec10};
    end
    
    assign value = lap ? lap_value : {sec10, sec1, msec100, msec10};    
     
endmodule
