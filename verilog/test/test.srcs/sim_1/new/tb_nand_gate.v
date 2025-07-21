`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/15/2025 09:32:45 AM
// Design Name: 
// Module Name: tb_nand_gate
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

// Testbench : 앞에서 작성했던 NAND GATE 모듈들 3가지 중에
// 하나를 시뮬레이션 하고 검증하는것. 실제 하드웨어에 합성 되지 않음
module tb_nand_gate;

    reg a, b;       
    // 테스트할 DUT(Device Under Test)의 입력 포트에 연결될 신호 'a'와 'b'를 레지스터 타입으로 선언
    // 'reg'는 값을 저장하고, 'initial' 또는 'always' 블록 내에서 값이 할당될 수 있음.
    
    wire q;         
    // 테스트할 DUT의 출력 포트에 연결될 신호 'q'를 와이어 타입으로 선언
    // 'wire'는 물리적인 연결선을 나타내며, 다른 모듈의 출력에 의해 구동되거나 'assign' 문으로 할당됨.

    // 아래 세 줄 중 하나를 주석 해제하여 테스트할 NAND 게이트 모듈을 선택함
    nand_gate_behavioral uut(.a(a), .b(b), .q(q)); 
    // 'nand_gate_behavioral' 모듈을 'uut'라는 이름으로 인스턴스화합니다.
    // .a(a), .b(b), .q(q)는 테스트벤치의 신호 'a', 'b', 'q'를
    // 각각 'nand_gate_behavioral' 모듈의 해당 포트에 연결하는 포트 매핑.
    // .a, .b. .q는 각각 input a, b와 output reg q 이고 
    // (a)(b)(q)는 현재 모듈(테스트벤치)내부에서 선언된 신호 이름이다

    // nand_gate_dataflow uut(.a(a), .b(b), .q(q)); 
    // nand_gate_structural uut(.a(a), .b(b), .q(q));

    initial begin   
    // 시뮬레이션 시작 시 한 번만 실행되는 'initial' 블록을 정의합니다.
        
        $display("Time\ta b | q"); // 시뮬레이션 콘솔에 헤더를 출력
                                   // $display는 시뮬레이션 중 한 번만 메시지를 출력하는 시스템 함수
                                   // printf 같은 느낌
        
        $monitor("%4t\t%b %b | %b", $time, a, b, q); 
        // 지정된 신호(a, b, q) 중 하나라도 값이 변할 때마다
        // 현재 시간($time)과 각 신호의 값을 콘솔에 출력하도록 설정
        // $monitor는 값이 변할 때마다 자동으로 출력하는 시스템 함수
        // %4t: 4칸으로 시간을 표시, %b: 이진수 형식으로 값을 표시

        a = 0 ; b = 0; #10;             
        // 'a'와 'b'를 모두 0으로 설정하고, 10시간 단위(예: 10ns) 동안 이 상태를 유지
        // #10은 10시간 단위의 딜레이임
        
        a = 0 ; b = 1; #10;             
        // 'a'를 0, 'b'를 1로 설정하고 10시간 단위 동안 유지
        // "hal delay와 같은 개념은 아니지만" 
        // -> Verilog의 #딜레이는 실제 회로의 전파 지연과 유사한 시뮬레이션 지연을 의미함
        
        // "비슷한 느낌으로 이해해도 좋음" 
        // -> 순차적인 이벤트 발생 및 상태 유지를 나타냄
        
        a = 1 ; b = 0; #10;             
        // 'a'를 1, 'b'를 0으로 설정하고 10시간 단위 동안 유지함
        
        a = 1 ; b = 1; #10;             
        // 'a'와 'b'를 모두 1로 설정하고 10시간 단위 동안 유지한다

        $finish;                        // 시뮬레이션을 종료하는 시스템 함수
    end

endmodule // 모듈 정의를 마침