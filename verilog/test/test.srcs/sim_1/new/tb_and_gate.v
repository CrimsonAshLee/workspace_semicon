`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/14/2025 12:41:50 PM
// Design Name: 
// Module Name: tb_and_gate
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


module tb_and_gate;
    
    reg a, b;
    // reg는 값을 저장하고 유지하는 메모리와 같음
    // 플립플롭이나 레지스터처럼 새로운 값을 받기 전까지 그대로 유지
    // initial 이나 always 같은 절차적 블록 내에서만 값이 할당 될 수 있음
    // 값을 설정하고 다음 설정 전 까지 유지해야하므로 reg로 선언
    
    wire q;
    // wire는 글자 그대로 물리적인 연결선을 의미함
    // assign문에 의해 지속적으로 구동되거나 
    // 다른 모듈의 출력포트에 연결되어 그 모듈의 출력 값에 의해 구동됨 

    // 정리
    // 입력 신호 (a, b): 테스트벤치가 값을 '생성'해서 DUT에 '넣어줘야' 하므로, 
    // 값을 저장하고 절차적으로 할당할 수 있는 reg 타입이어야 합니다.

    // 출력 신호 (q): 테스트벤치가 DUT로부터 **값을 '받아와서' '관찰'**해야 하므로, 
    // DUT의 출력에 의해 구동되는 연결선 역할을 하는 wire 타입이어야 합니다.

    and_gate_behavioral uut (.a(a), .b(b), .q(q));

    initial begin
        $display("Time\ta b | q");
        $monitor("%4t\t%b %b | %b", $time, a, b, q);

        a = 0; b = 0; #10;
        a = 0; b = 1; #10;
        a = 1; b = 0; #10;
        a = 1; b = 1; #10;

        $finish;
    end

endmodule
