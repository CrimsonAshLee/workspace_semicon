`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/20/2025 08:20:30 PM
// Design Name: 
// Module Name: tb_cora_hc_sr04
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


module tb_hc_sr04();
    reg clk, reset_p;
    reg echo;
    wire trigger;
    wire[15:0] distance;
    
    HC_SR04 DUT(clk, reset_p, echo, trigger, distance);
    initial begin
        clk = 0;
        reset_p = 1;
        echo = 0;
    end  
    always #4 clk = ~clk;
    
    initial begin
        #8;
		reset_p = 0; #8;							      // start H_IDLE
		wait(trigger); 								    // when state = S_T_HIGH_10, 15us trigger transmit / wait trigger pedge
		wait(!trigger);								   // when finish 16us trigger transmit / wait trigger nedge / 
		#20000;						
        echo = 1; #1000000;						       	// 1000us / 58 -> 17 cm
		echo = 0;
		#1000000;
		$stop;
    end
endmodule
