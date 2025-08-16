`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/12/2025 06:44:36 PM
// Design Name: 
// Module Name: practice01_combinational_logic
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


module and_gate(    // verilog에서 기본적으로 gate들은 제공이 된다.
    input A, // A라는 입력 포트를 선언
    input B, // B라는 입력 포트를 선언
    output F // F라는 출력 포트를 선언
    );
    
    // assign 문은 회로의 연결을 지정하는 명령어
    // F라는 출력 포트에 A와 B의 AND 연산 결과를 할당(연결)
    // & 기호는 비트별 AND 연산자
    assign F = A & B;

endmodule

module half_adder_structural (
    input A, B,         // A, B라는 두 입력 포트를 선언
    output sum, carry   // sum, carry라는 두 출력 포트를 선언
    );
    
    // xor는 미리 정의된 '기본 게이트 프리미티브(Gate Primitive)'이다.
    // (sum, A, B)는 xor 게이트의 출력이 sum에, 입력이 A와 B에 연결됨을 의미
    // A와 B의 XOR 연산 결과가 합(sum)이 됨
    xor (sum, A, B); 
    
    // and는 미리 정의된 '기본 게이트 프리미티브'이다.
    // (carry, A, B)는 and 게이트의 출력이 carry에, 입력이 A와 B에 연결됨을 의미
    // A와 B의 AND 연산 결과가 올림수(carry)가 됨
    and (carry, A, B);
    
endmodule

module half_adder_behavioral (
    input A, B,             
    output reg sum, carry
    // always 블록 안에서 값을 할당받는 출력 포트(sum, carry)는 
    // 반드시 reg 타입으로 선언해야 한다. reg는 값이 저장되는 변수 타입이다.   
    );

    // always 블록은 '항상' 특정 조건이 만족될 때 실행되는 코드 블록
    // @(A, B)는 A 또는 B의 값이 변할 때마다 이 블록을 실행하라는 의미
    always @(A, B) begin
        // case 문은 주어진 표현식([A, B])의 값에 따라 다른 코드를 실행
        // 이는 하드웨어의 '진리표'를 코드로 옮긴 것과 같다.
        case ({A, B})
            // A와 B가 '00'일 때
            2'b00: begin sum = 0; carry = 0; end
            // A와 B가 '01'일 때
            2'b01: begin sum = 1; carry = 0; end
            // A와 B가 '10'일 때
            2'b10: begin sum = 1; carry = 0; end
            // A와 B가 '11'일 때
            2'b11: begin sum = 0; carry = 1; end
        endcase
    end
    
endmodule

module half_adder_dataflow (
    input A, B,         
    output sum, carry 
    );

    // wire는 신호를 연결하는 '전선' 역할을 하는 데이터 타입
    // sum_value는 A와 B의 덧셈 결과를 담을 2비트짜리 전선(wire)
    // reg와는 다르게 wire는 저장기능이 없다.
    wire [1:0] sum_value;

    // assign 문은 A와 B를 더해서 그 결과를 sum_value에 연속적으로 할당함
    // 베릴로그에서 '+' 연산자는 덧셈 회로를 의미한다. 단순 덧셈이 아님.
    assign sum_value = A + B;
    
    // sum_value의 가장 낮은 비트(0번 비트)를 sum 출력에 연결한다
    assign sum = sum_value[0];
    
    // sum_value의 가장 높은 비트(1번 비트)를 carry 출력에 연결한다
    assign carry = sum_value[1];
    
endmodule