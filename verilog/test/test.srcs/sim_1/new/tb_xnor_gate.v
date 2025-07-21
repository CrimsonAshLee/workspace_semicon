`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/15/2025 10:50:49 AM
// Design Name: 
// Module Name: tb_xnor_gate
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


module tb_xnor_gate;
    reg a, b;
    wire q;

     xnor_gate_behavioral uut (.a(a), .b(b), .q(q));
//    xnor_gate_dataflow uut (.a(a), .b(b), .q(q));
//    xnor_gate_structural uut (.a(a), .b(b), .q(q));

    initial begin
        $display("Time\ta b | q");                      // 
        $monitor("%0t\t%b %b | %b", $time, a, b, q);    // t = $time, %b = binary, 

        // inpute combination test
        a = 0 ; b = 0 ; #10;            // #10 = 10ns
        a = 0 ; b = 1 ; #10;
        a = 1 ; b = 0 ; #10;
        a = 1 ; b = 1 ; #10;

        $finish;
    end

endmodule