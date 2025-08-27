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
    // 여기 이후 부분이 입출력이 어떻게 동작해야되는지 서술하는 부분이다
    // 구조적 모델링은 게이트를 이용해서 회로를 만든다.
    
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
    // sensitivy List
    // 즉 모든 입력에 대해서 출력이 어떻게 되는지 서술한것
    always @(A, B) begin
        // case 문은 주어진 표현식({A, B})의 값에 따라 다른 코드를 실행
        // 이는 하드웨어의 '진리표'를 코드로 옮긴 것과 같다.
        case ({A, B})   // A, B 입력이 들어올때(그 조합에 따라)라는 뜻   
        // {} : 연산자의 비트를 묶어줄때 사용. 각각 1비트씩 이므로 2비트
        // always문의 '='왼쪽에 있는 변수는 reg선언이 필수. 즉, 입력을 받는 변수이다. 
        // reg 가 아니면 wire이다. wire는 입력값 바뀌면 출력이 즉시 바뀜 -> combinational logic
            // A와 B가 '00'일 때
            2'b00: begin sum = 0; carry = 0; end    // 베릴로그의 수표현 방식
            // A와 B가 '01'일 때                      // 2: 2bit, b: binary
            2'b01: begin sum = 1; carry = 0; end    
            // A와 B가 '10'일 때
            2'b10: begin sum = 1; carry = 0; end
            // A와 B가 '11'일 때
            2'b11: begin sum = 0; carry = 1; end
        endcase
    end
    
endmodule

module half_adder_dataflow ( // 어떤식으로 처리되서 어떤식으로 흘러가는지
                             // 데이터의 흐름으로 정리하는 방식
    input A, B,         
    output sum, carry 
    );

    // wire는 신호를 연결하는 '전선' 역할을 하는 데이터 타입
    // sum_value는 A와 B의 덧셈 결과를 담을 2비트짜리 전선(wire)
    // reg와는 다르게 wire는 저장기능이 없다.
    // 1 bit 더하기라도 캐리가 발생하면 두자리가 될수있어서 2자리를 선언한것
    wire [1:0] sum_value;

    // dataflow 모델은 assign문 사용. assign문 안에는 수식이 들어감
    // '='왼쪽에는 wire여야함. (always문이 reg인것과 차이)
    // assign 문은 A와 B를 더해서 그 결과를 sum_value에 연속적으로 할당함
    // 베릴로그에서 '+' 연산자는 덧셈 회로를 의미한다. 단순 덧셈이 아님.
    assign sum_value = A + B;
    
    // sum_value의 가장 낮은 비트(0번 비트)를 sum 출력에 연결한다
    assign sum = sum_value[0];
    
    // sum_value의 가장 높은 비트(1번 비트)를 carry 출력에 연결한다
    assign carry = sum_value[1];
    
endmodule

module full_adder_behavioral (  // 3개의 1비트 이진수를 더하는 회로를 설계한 것
    input A, B, cin,            // A, B는 더할 두 개의 1비트 입력, cin은 아래 자리에서 올라온 올림수(carry-in)
    output reg sum, carry       // sum은 덧셈 결과의 합(Sum), carry는 다음 자리로 올라갈 올림수(carry-out)
                                // 중요한 점: always 블록 안에서 값을 할당하므로, 출력 신호를 반드시 reg 타입으로 선언해야 함
);
    
    // always 문은 특정 신호가 변할 때마다 내부 블록을 실행한다.
    // @(A, B, cin)은 '민감도 리스트(Sensitivity List)'라고 부르는데
    // 이 리스트에 있는 A, B, cin 중 어느 하나라도 값이 바뀌면 always 블록이 즉시 실행된다.
    // 이는 조합 논리 회로의 '실시간 반응성'을 모델링하는 방식이다.
    always @(A, B, cin) begin
        // case 문은 주어진 표현식의 값에 따라 여러 경우 중 하나를 선택하는 제어문이다
        // {A, B, cin}은 A, B, cin 세 개의 1비트 신호를 묶어 하나의 3비트짜리 신호로 만든다
        // 이렇게 묶인 3비트 신호는 2³ = 8가지의 모든 경우의 수를 가질 수 있다.
        case ({A, B, cin})
            // 3'b000은 3비트짜리 이진수 000을 의미한다.
            // 입력 A, B, cin이 모두 0일 때 (0+0+0)의 경우
            3'b000: begin sum = 0; carry = 0; end
            
            // 입력 A, B, cin이 0, 0, 1일 때 (0+0+1)의 경우
            // 십진수 1은 2진수로 01이므로, sum=1, carry=0이 된다
            3'b001: begin sum = 1; carry = 0; end
            
            // 입력이 0, 1, 0일 때 (0+1+0)의 경우
            // 십진수 1은 2진수로 01이므로, sum=1, carry=0이 된다.
            3'b010: begin sum = 1; carry = 0; end
            
            // 입력이 0, 1, 1일 때 (0+1+1)의 경우
            // 십진수 2는 2진수로 10이므로, sum=0, carry=1이 된다
            3'b011: begin sum = 0; carry = 1; end
            
            // 입력이 1, 0, 0일 때 (1+0+0)의 경우
            // 십진수 1은 2진수로 01이므로, sum=1, carry=0이 된다.
            3'b100: begin sum = 1; carry = 0; end
            
            // 입력이 1, 0, 1일 때 (1+0+1)의 경우
            // 십진수 2는 2진수로 10이므로, sum=0, carry=1이 된다.
            3'b101: begin sum = 0; carry = 1; end
            
            // 입력이 1, 1, 0일 때 (1+1+0)의 경우
            // 십진수 2는 2진수로 10이므로, sum=0, carry=1이 된다.
            3'b110: begin sum = 0; carry = 1; end
            
            // 입력이 1, 1, 1일 때 (1+1+1)의 경우
            // 십진수 3은 2진수로 11이므로, sum=1, carry=1이 된다.
            3'b111: begin sum = 1; carry = 1; end
        endcase
    end

endmodule

module full_adder_structural (
    input A, B, cin,            
    output sum, carry           
    // 중요한 점: 이 코드에서는 항상 값이 실시간으로 연결되므로 
    // output을 reg가 아닌 wire로 선언해야 함  
    );
    
    // wire는 '내부 연결선' 역할을 하는 신호
    // sum_0, carry_0, carry_1은 모듈의 최종 출력이 아니라 
    // 중간 단계의 값을 연결해주는 임시 전선임
    wire sum_0, carry_0, carry_1;

    // 이전에 만들어두었던 'half_adder_structural'이라는 
    // 부품을 첫 번째로 불러와서 ha0이라는 이름으로 인스턴스화(instantiation)
    half_adder_structural ha0(  // 인스턴화된 모듈도 게이트 개념으로 볼 수 있음
        .A(A),                      // ha0 모듈의 내부 입력 포트(.A)에 현재 모듈의 입력 신호(A)를 연결한다
        .B(B),                      // ha0 모듈의 내부 입력 포트(.B)에 현재 모듈의 입력 신호(B)를 연결한다.
        .sum(sum_0),                // ha0 모듈의 내부 출력 포트(.sum)를 sum_0 라는 wire 에 연결한다.
        .carry(carry_0)             // ha0 모듈의 내부 출력 포트(.carry)를 carry_0 라는 wire에 연결한다.
        );

    // 두 번째 하프 에더 부품을 불러와서 ha1 이라고 인스터화함.
    // ha1의 입력에는 ha0의 출력 중 sum_0과 현재 모듈의 cin 신호를 연결한다
    // 이렇게 하면 '중간 합'과 '올림수 입력'을 더할 수 있다.
    half_adder_structural ha1(
        .A(sum_0),              // .A(ha1 모듈의 첫 번째 입력) 포트에 (sum_0) 신호를 연결한다.
                                // sum_0은 ha0 (첫 번째 하프 에더)의 덧셈 결과인 '중간 합'이다.
                                // 이 중간 합을 ha1의 첫 번째 입력으로 사용하는 것이다.
                                
        .B(cin),                // .B(ha1 모듈의 두 번째 입력) 포트에 (cin) 신호를 연결한다.
                                // cin은 풀 에더 모듈의 가장 처음에 들어온 '아래 자리 올림수' 입력이다.
                                // 이 입력을 ha1의 두 번째 입력으로 사용하는 것이다.
                                
        .sum(sum),              // .sum(ha1 모듈의 합 출력) 포트에, (sum) 신호를 연결한다.
                                // ha1은 중간 합(sum_0)과 올림수 입력(cin)을 더하므로
                                // 그 결과는 '최종 합'이 된다.
                                // 따라서 이 합 결과를 full_adder 모듈 전체의 최종 출력인 'sum'에 직접 연결한다.
                                
        .carry(carry_1)         // .carry(ha1 모듈의 올림수 출력) 포트에, (carry_1) 신호를 연결한다.
                                // ha1의 올림수 출력 역시 최종 올림수를 만드는 데 필요한 '중간 올림수'이다.
                                // 이 중간 값을 담기 위해 우리는 'carry_1'이라는 새로운 내부 연결선을 만들었다.
        );

    // 마지막으로 or 게이트를 이용해 두 하프 에더에서 나온 올림수를 합친다.
    // or (출력, 입력1, 입력2) 형식으로 사용하며, carry_0와 carry_1을 OR 연산하여 최종 carry를 만든다.
    or (carry, carry_0, carry_1);

endmodule

module full_adder_dataflow (
    input A, B, cin,     // 입력 핀 3개: A, B, 올림수(cin)
    output sum, carry    // 출력 핀 2개: 합(sum), 올림(carry)
    );
    
    // wire: 전선처럼 동작하는 변수. 값이 바뀌면 즉시 출력으로 연결됨.
    // [1:0] sum_value: 2비트 크기의 wire 선언
    //               A+B+cin의 최대값은 1+1+1=3(2진수 '11')이므로 2비트가 필요
    wire [1:0] sum_value; 
    
    // assign: '연속 할당문'. 입력값이 변하면 항상 실시간으로 계산하여 wire에 값을 할당함
    assign sum_value = A + B + cin;
    // A, B, cin의 현재 값을 더한 결과를 sum_value라는 전선에 실시간으로 연결함
    
    // sum 출력에 sum_value의 가장 낮은 비트([0])를 연결
    assign sum = sum_value[0];
    
    // carry 출력에 sum_value의 가장 높은 비트([1])를 연결
    assign carry = sum_value[1];

endmodule

module fadder_4bit_dataflow(
    input [3:0] A, B,   // A 4bit, B 4bit 입력
    input cin,          // carry 입력은 1bit 라서 따로적음
    output [3:0] sum,   // 마찬가지로 4bit + 4bit는 4bit
    output carry        // carry 출력 1bit 따로 적음
    );

    wire [4:0] sum_value;   
    
    assign sum_value = A + B + cin;
    // A, B 각각 4bit에서 가장 큰 값 : 1 1 1 1 -> 15, cin 1bit 가장 큰 값 : 1
    // A + B + cin = 15 + 15 + 1 = 31 을 이진수로 바꾸면 1 1 1 1 로 5bit
    // 즉, 출력은 5비트 까지 받아야하므로 wire [4:0] sum_value 가 된다.

    assign sum = sum_value[3:0];    // 하위 4비트
    assign carry = sum_value[4];    // 최상위 비트인 4번 비트

endmodule

// module fadder_Nbit_dataflow( // ex) 16bit 로 가정
//     input [N-1:0] A, B,   // A 4bit, B 4bit 입력
//     input cin,          // carry 입력은 1bit 라서 따로적음
//     output [N-1:0] sum,   // 마찬가지로 4bit + 4bit는 4bit
//     output carry        // carry 출력 1bit 따로 적음
//     );

//     wire [N:0] sum_value;   
    
//     assign sum_value = A + B + cin;
//     // A, B 각각 4bit에서 가장 큰 값 : 1 1 1 1 -> 15, cin 1bit 가장 큰 값 : 1
//     // A + B + cin = 15 + 15 + 1 = 31 을 이진수로 바꾸면 1 1 1 1 로 5bit
//     // 즉, 출력은 5비트 까지 받아야하므로 wire [4:0] sum_value 가 된다.

//     assign sum = sum_value[N-1:0];    // 하위 4비트
//     assign carry = sum_value[N];    // 최상위 비트인 4번 비트

// endmodule

module fadder_4bit_structural (
    input [3:0] A, B,    // 4비트 입력 A, B
    input cin,           // 1비트 입력 캐리(carry-in)
    output [3:0] sum,    // 4비트 출력 합(sum)
    output carry         // 1비트 출력 최종 캐리(carry-out)
    );
    
     wire [2:0] carry_w; // carry가 3개 필요하니까 3비트짜리로 선언
    // 내부적으로 1비트 전가산기 모듈들을 연결하기 위한 임시 '전선' 역할을 하는 wire를 선언합니다.
    // 총 3개의 내부 올림수(carry)가 필요하므로 3비트 와이어([2:0])를 선언합니다.
    
    // .은 인스턴스 모듈, ()는 현재 모듈
    // 0번째 비트의 덧셈을 담당하는 첫 번째 1비트 전가산기 모듈
    full_adder_structural fa0(  // fa0: 이 모듈의 인스턴스 이름
        .A(A[0]),         // .A: 1비트 fadder 모듈의 A 입력에, 현재 모듈의 A 입력 중 0번 비트([0])를 연결
        .B(B[0]),         // .B: 1비트 전가산기 모듈의 B 입력에, 현재 모듈의 B 입력 중 0번 비트([0])를 연결
        .cin(cin),        // .cin: 1비트 전가산기 모듈의 cin에, 현재 모듈의 cin을 연결
        .sum(sum[0]),     // .sum: 1비트 전가산기 모듈의 sum 출력에, 현재 모듈의 sum 출력 중 0번 비트를 연결
        .carry(carry_w[0]) // .carry: 1비트 전가산기 모듈의 carry 출력에, 내부 와이어 carry_w의 0번 비트를 연결
    );
    // 이와 같은 방식으로 4개의 1비트 전가산기 모듈을 인스턴스화하여 연결합니다.

    // 1번째 비트의 덧셈을 담당하는 두 번째 1비트 전가산기 모듈
    full_adder_structural fa1(
        .A(A[1]), 
        .B(B[1]), 
        .cin(carry_w[0]), // 이전 모듈(fa0)의 carry 출력을 현재 모듈(fa1)의 cin 입력에 연결
        .sum(sum[1]), 
        .carry(carry_w[1])
    );

    // 2번째 비트의 덧셈을 담당하는 세 번째 1비트 전가산기 모듈
    full_adder_structural fa2(
        .A(A[2]), 
        .B(B[2]), 
        .cin(carry_w[1]), // 이전 모듈(fa1)의 carry 출력을 현재 모듈(fa2)의 cin 입력에 연결
        .sum(sum[2]), 
        .carry(carry_w[2])
    );

    // 3번째 비트의 덧셈을 담당하는 네 번째 1비트 전가산기 모듈
    full_adder_structural fa3(
        .A(A[3]), 
        .B(B[3]), 
        .cin(carry_w[2]), // 이전 모듈(fa2)의 carry 출력을 현재 모듈(fa3)의 cin 입력에 연결
        .sum(sum[3]), 
        .carry(carry)     // 마지막 모듈의 carry 출력을 최종 carry 출력 핀에 연결
    );

endmodule