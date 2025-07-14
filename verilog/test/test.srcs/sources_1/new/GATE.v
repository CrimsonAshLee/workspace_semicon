`timescale 1ns / 1ps
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
module and_gate(
    input a, b, // 인풋 할거야 a, b
    output reg q   // reg 는 변수, output 할거야
    );

    always @(a, b) begin        // always는 뭔가 바뀌면 이라는뜻(a든 b이든)
        case({a,b})             //
            2'b00 : q = 0;      // 00 이면 q값은 0
            2'b01 : q = 0;      //
            2'b10 : q = 0;      //
            2'b11 : q = 1;      // 진리표라는 것은 하드웨어가 이렇게 움직인다는 것. 이 움직이는 것을 글과 수식으로 설명한 것.
        endcase
        
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
);
    and U1(q, a, b);        // AND 게이트 인스턴스 생성
endmodule


// 데이터 플로우 모델
// assign문으로 출력과 입력간의 논리를 기술
// 데이터 흐름 중심
module and_gate_dataflow (
    input a, b,
    output q
);
    assign q = a & b;
endmodule

// 동작적 : 동작을 코드로 표현 / 복잡한 로직 처리에 유리
// 구조적 : 게이트를 연결해서 회로 구조를 표현 / 실제회로 구조를 이해하는데 적합
// 데이터플로우 : 출력 = 입력 이런식으로 서술 / 간단한 조합논리 회로에 적합
// 3가지를 뒤범벅해서 사용함


// OR GATE
module or_gate (
    input a, b,
    output reg q
);
    always @(a, b) begin
        case ({a, b})
            2'b00 : q = 0;
            2'b01 : q = 1;
            2'b10 : q = 1;
            2'b11 : q = 1;

        endcase
    end
endmodule


module or_gate_behavioral (
    input a, b,
    output reg q
);
    always @(a, b) begin
        if(a == 1'b1 || b == 1'b1)
            q = 1'b1;
        else
            q = 1'b0;
        
    end
    
endmodule

module or_gate_structural (
    input a, b,
    output q
);
    or U1(q, a, b);     // 인스턴스는 습관적으로 적어주는게 좋다
endmodule


module or_gate_dataflow (
    input a, b,
    output q
);
    assign q = a | b;
endmodule