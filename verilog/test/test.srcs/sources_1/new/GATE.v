`timescale 1ns / 1ps // 기준 클락 / 해상도
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/14/2025 10:33:53 AM
// Design Name: 
// Module Name: GATE
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

// 한글이 써질려면...D2Coding Fonts
// 1 l I

// and gate
module and_gate(
    input a, b, // 인풋 할거야 a, b
    output reg q   // reg 는 변수, output 할거야 q에. wire는 변수가 아님.
    );

    always @(a, b) begin        // always는 뭔가 바뀌면 이라는뜻(a든 b이든)
        case({a,b})             // parameter : a, b
            2'b00 : q = 0;      // 2비트 binary 타입에 00 이면 q값은 0
            2'b01 : q = 0;      //
            2'b10 : q = 0;      //
            2'b11 : q = 1;      // 
        endcase
                                // 해설 :  a든 b든 바뀌고 선택을 하고서 2비트의 공간을 확보해서 00이면 q값은 0이고..
                                // 즉 진리표이다. 진리표라는 것은 하드웨어가 이렇게 움직인다는 것. 
                                // 이 움직이는 것을 글과 수식으로 설명한 것. 0 0, 1 1로 규정 지은게 아닌
                                // 좀더 풀어 말하면 움직임을 보고 수학적으로 0 0, 1 1 임을 적은것
    end
endmodule


// 동작적 모델
// always 블록과 case문을, if문을 이용해서 회로의 동작(행동)을 기술
module and_gate_behavioral (
    input a, b,
    output reg q
);
    always @(a or b) begin  // a, b 둘 중 하나라도 값이 변경되면 블록 실행
        if (a == 1'b1 && b == 1'b1) // a와 b가 모두 1이면
            q = 1'b1;               // q에 1 저장
        else                        // 아니면
            q = 1'b0;               // q에 0 저장
    end
    
endmodule


// 구조적 모델
// 실제 게이트(AND)를 이용해서 회로의 구조를 기술
// 하드웨어의 구성요소를 직접 인스턴스화 함.
module and_gate_structural (
    input a, b,
    output q                // 여기 주의!!! wire 타입이어야함 !!!
                            // 명시하지 않으면 기본은 wire이다
);
    and U1(q, a, b);        // 첫 번째는 출력, 나머지는 입력
                            // AND 게이트 인스턴스 생성
                            // verilog의 기본 내장 게이트 and를
                            // U1이라는 이름으로 인스턴스화 한 것
endmodule


// 데이터 플로우 모델
// assign문으로 출력과 입력간의 논리를 기술
// 데이터 흐름 중심
module and_gate_dataflow (
    input a, b,
    output q
);
    assign q = a & b;   // AND게이트의 논리 연산을 assign문으로 직접 표현
    // assign : a & b 연산 결과를 q에 지속적으로 할당(대입)함
endmodule

// 동작적 : 동작을 코드로 표현 / 복잡한 로직 처리에 유리
// 구조적 : 게이트를 연결해서 회로 구조를 표현 / 실제회로 구조를 이해하는데 적합
// 데이터플로우 : 출력 = 입력 이런식으로 서술 / 간단한 조합논리 회로에 적합
// 3가지를 뒤범벅해서 사용함


// OR GATE
module or_gate (
    // 이것 또한 동작적 모델링에 속함
    input a, b,
    output reg q
);
    always @(a, b) begin
        case ({a, b})
        // 입력 a, b를 하나의 2비트 벡터({a, b})로 묶어서 각 경우를 처리
            2'b00 : q = 0; // a는 0, b는 0 일때 q는 0
            2'b01 : q = 1;
            2'b10 : q = 1;
            2'b11 : q = 1;

        // default : q = 1'bx; 
        // 모든 경우(2비트 경우의수를 모두 다룸)를 명시했다면 default는 생략 가능하지만
        // 일반적으로 래치(latch) 생성을 막기 위해 모든 조건에 대해 q에 값을 할당하거나
        // default 케이스를 추가하여 알 수 없는 상태(X)를 방지하는 것이 좋다
    
        endcase
    end
endmodule


module or_gate_behavioral (
    input a, b,
    output reg q
);
    always @(a, b) begin
        if(a == 1'b1 || b == 1'b1)
        // 만약 a 또는 b 가 하나라도 1이면 참 
            q = 1'b1;
            // q에 1을 대입
        else
        // 조건이 거짓이면(둘다 0인 경우)
            q = 1'b0;
            // q에 0을 대입
        
    end
    
endmodule

module or_gate_structural (
    input a, b,
    output q
);
    or U1(q, a, b);     // (출력, 입력, 입력)
                        // 인스턴스는 습관적으로 적어주는게 좋다
endmodule


module or_gate_dataflow (
    input a, b,
    output q
);
    assign q = a | b;
endmodule


// nand gate
module nand_gate_behavioral (
// nand_gate_behavioral 라는 이름의 모듈을 정의
    
    input a, b,     // a, b 두개의 입력 포트 선언
    
    output reg q    // q 라는 출력 포트 선언
                    // reg는 always 내부에서 값이 할당될 레지스터
                    // 레지스터는 값이 변경될 때 까지 현재 상태 유지

);                  // 포트 선언 끝
    
    always @(a or b) begin  // a, b == a or b 같은 표현이다
                            // a or b 둘 중 하나라도 값이 변경될 때 마다라는 뜻
    // always 문은 특정 조건이 만족될 때 마다 내부의 코드를 실행함
    // 절차지향적
        
        if(a == 1'b1 && b == 1'b1) // 1'b1 : 1비트 이진수 1
        // a 와 b가 모두 1인지 검사
            
            q = 1'b0;
            // if 조건이 참일 경우에 q에 0을 대입(둘다 1인 경우)
            // NAND의 핵심 : 1, 1일 때만 0 출력

        else
        // if 조건이 거짓일 경우(하나라도 0이거나 둘다 0인 경우)
            q = 1'b1;
            // else 조건이 참일 경우 q에 1을 대입
            // 즉 (0,0)(0,1)(1,0) 일때를 말함
    end
    
endmodule


module nand_gate_dataflow (
    input a, b,         // 외부에서 데이터 받음
    output q            // assign 문은 wire가 기본
                        // assign 문은 reg를 안쓴다
);
    assign q = ~(a & b);
    // dataflow의 핵심!
    // assign문은 연속적인 할당을 한다
    // 신호 q 에 즉시, 그리고 지속적으로 할당함
    // 마치 물리적인 wire로 연결된 것 처럼 동작함

endmodule


module nand_gate_structural (
    input a, b,
    output q
);
    nand U1 (q, a, b);          // verilog 기본내장 nand 게이트 사용
    // 구조적 모델링의 핵심!
    // 기본내장 게이트 사용
    // U1 : 모듈내에서 nand 게이트의 인스턴스를 구별하기 위해 지어줌

/*
인스턴스화란?
베릴로그에서 하드웨어는 계층적으로 설계된다. 
복잡한 시스템은 더 작고 관리하기 쉬운 하위 모듈들로 구성된다 
각 하위 모듈은 특정 기능을 수행하도록 설계되고 
이 모듈들을 인스턴스화함으로써 더 큰 상위 모듈이나 전체 시스템을 구축할 수 있다.

왜 인스턴스화를 사용할까?
재사용성: 한 번 설계한 모듈은 여러 번 인스턴스화하여 재사용할 수 있어서
        설계 시간을 줄이고 오류를 줄이는 데 도움이 된다. 
        마치 레고 블록을 여러 번 사용하는 것과 같다. 🧱

모듈성: 설계를 작은 단위로 분리하여 관리하고 이해하기 쉽게 만든다. 
       각 모듈은 독립적으로 테스트하고 검증할 수 있다.

추상화: 복잡한 내부 구현을 숨기고 
       모듈의 입출력 인터페이스만으로 상위 모듈과 통신하게 함으로써 
       설계의 복잡성을 줄여준다.

*/


    
endmodule


// nor gate
module nor_gate_behavioral (
    input a, b,
    output reg q
);
    always @(a or b) begin       // a, b == a or b 같은 표현이다       
    // a 와 b 중 하나라도 변경될 때마다 실행
    // 'a or b'는 민감도 목록으로, 이벤트가 발생할 트리거를 명시함

        if(a == 1'b1 || b == 1'b1)      
        // 만약 a or b 일때 둘 중 하나라도 1일 경우 참
            
            q = 1'b0;                   
            // 조건이 참 일 때 q에 0 을 대입 
            // (NOR 게이트의 특성 : 둘중 하나만 1이어도 출력이 0)
        else                            
        // 그 외의 모든 경우 (a와 b가 둘 다 0인 경우)
            q = 1'b1;                   
            // q에 1을 대입
    end
    
endmodule


module nor_gate_dataflow (
    input a, b,
    output q
);
    assign q = ~(a | b);
    // a or b 를 NOT 연산하여 q에 지속적으로 할당
                    
endmodule


module nor_gate_structural (
    input a, b,
    output q
);
    nor U1 (q, a, b);   
    // verilog 기본 내장 nor 게이트를 U1이라는 이름으로 인스턴스화
    // q는 출력 a, b는 입력
    
endmodule


// xor gate
// 핵심 : 두 입력이 다를 때만 1을 출력!
module xor_gate_behavioral (
    input a, b,
    output reg q
);
    always @(a, b) begin
        if(a != b)
        // a와 b가 서로 다를 경우(0,1 혹은 1, 0 만 가능)
            
            q = 1'b1;
            // q에 1을 대입
        else
        // 그 외 경우
            q = 1'b0;
            // q에 0을 대입
        
    end
    
endmodule


module xor_gate_structural (
    input a, b,
    output q
);
    xor U1(q, a, b);     // 인스턴스는 습관적으로 적어주는게 좋다
endmodule


module xor_gate_dataflow (
    input a, b,
    output q
);
    assign q = a ^ b;
endmodule


// xnor
module xnor_gate_behavioral (
    input a, b,
    output reg q
);
    always @(a, b) begin
        if(a == b)
        // a == b 일때 (0, 0 이거나 1, 1만 가능) 참
            q = 1'b1;
            // 참이면 q에 1을 대입
        else
        // 그 외의 경우 실행(0, 1 이거나 1, 0)
            q = 1'b0;
            // 조건이 거짓일 때 q에 0을 대입
        
    end
    
endmodule

module xnor_gate_structural (
    input a, b,
    output q
);
    xnor U1(q, a, b);     // 인스턴스는 습관적으로 적어주는게 좋다
endmodule


module xnor_gate_dataflow (
    input a, b,
    output q
);
    assign q = ~(a ^ b);
endmodule

// gates
module gates (
    input a, b,
    output q0, q1, q2, q3, q4, q5, q6
);
    assign q0 = ~a;                     // NOT
    assign q1 = a & b;                  // AND
    assign q2 = a | b;                  // OR
    assign q3 = ~(a & b);               // NAND
    assign q4 = ~(a | b);               // NOR
    assign q5 = a ^ b;                  // XOR
    assign q6 = ~(a ^ b);               // XNOR

endmodule