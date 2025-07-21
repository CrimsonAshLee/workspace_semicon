`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/15/2025 10:03:50 AM
// Design Name: 
// Module Name: tb_nor_gate
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


module tb_nor_gate;

    reg a, b;
    wire q;

    nor_gate_behavioral uut(.a(a), .b(b), .q(q));
    // nor_gate_dataflow uut(.a(a), .b(b), .q(q));
    // nor_gate_structural uut(.a(a), .b(b), .q(q));

    initial begin
    // initial 블록 안에서 a와 b 입력에 NOR 게이트의 모든 가능한 조합(00, 01, 10, 11)을 순차적으로 인가
    // 각 입력 조합은 #10 이라는 딜레이를 통해 일정 시간 동안 유지. 
    // 이를 통해 NOR 게이트의 진리표를 검증가능
        
        $display("Time\ta b | q");
        $monitor("%4t\t%b %b | %b", $time, a, b, q);

        a = 0 ; b = 0; #10;             // 0, 0 일때 10ns 유지.
        a = 0 ; b = 1; #10;             // hal delay와 같은 개념은 아니지만
        a = 1 ; b = 0; #10;             // 비슷한 느낌으로 이해해도 좋음
        a = 1 ; b = 1; #10;

        $finish;
    end

endmodule