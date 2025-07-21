`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/15/2025 02:06:57 PM
// Design Name: 
// Module Name: adder
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

// Half Adder Behavioral
// 두개의 1비트를 입력(a, b)
// 합(s), 자리올림(c) 출력하는 반가산기
module Half_adder_behavioral(
    input a,                        // 1bit 입력 a
    input b,                        // 1bit 입력 b
    output reg s,                   // 합(sum)을 저장할 레지스터 타입의 출력
    output reg c                    // 자리올림(c)을 저장할 레지스터 타입의 출력
    );

    // a 또는 b의 변화가 생길 때 마다 always블록 실행
    always @(a, b) begin
        case ({a, b})
            2'b00 : begin       // a = 0, b = 0 -> 합 = 0, 자리올림 = 0
                s = 0;
                c = 0;        
            end
             2'b01 : begin       // a = 0, b = 1 -> 합 = 1, 자리올림 = 0
                s = 1;
                c = 0;        
            end
             2'b10 : begin       // a = 1, b = 0 -> 합 = 1, 자리올림 = 0
                s = 1;
                c = 0;        
            end
             2'b11 : begin       // a = 1, b = 1 -> 합 = 0, 자리올림 = 1
                s = 0;
                c = 1;        
            end
    // always @(a , b)는 a나 b 중 하나라도 변하면 
    // case 블록을 다시 실행해서 출력을 갱신하도록 한다

        endcase
    end
endmodule


module half_adder_structural (
    input a, b,     // 1비트 입력 a, b 선언
    output s, c     // sum s와 carry c 출력 선언
                    // structural에서는 reg를 쓰지 않는다.
                    // wire로 연결되기 때문
);
    and U_AND (c, a, b);
    // 기본내장 AND 게이트 인스턴스화
    // and는 입력이 1, 1 일때만 1을 출력하며 이것은 carry와 같다

    xor U_XOR (s, a, b);
    // 기본내장 XOR 게이트를 인스턴스화
    // xor은 두 입력이 다를 때 1을 출력하며 이는 sum과 같다
endmodule


module half_adder_dataflow (
    input a, b,
    output s, c
);
    // a와 b의 합을 저장할 2비트 와이어를 만들기
    // 최대값은 1 + 1 = 2 (2'b10) 이므로 2비트가 필요
    wire [1:0] sum_value; // 1에서 0까지 2비트 와이어 sum_value를 선언

    // verilog에서 '+' 연산자는 벡터를 생성해서 (여기서 벡터는 연속된것(스칼라는 하나만 있는것))
    // 결과를 sum_value에 저장
    // ex) a = 1, b = 1 -> sum_value = 2'b10
    assign sum_value = a + b;

    // sum_value의 최하위 비트(LSB)인 sum_value[0]을 s에 할당
    // 결과값은 XOR 연산결과와 같음
    assign s = sum_value[0];    // sum

    // sum_value의 최상위 비트(MSB)인 sum_value[1]을 c에 할당
    // 결과값은 AND 연산 결과와 같음 (둘다 1일 경우에만 캐리 발생)
    assign c = sum_value[1];    // carry

endmodule


// N bit half adder
module half_adder_N_bit # (parameter N = 8)(        // N의 기본값 8bit를 의미
    input inc,                                      // 더할 값 (보통은 1, 또는 0)
    input [N-1:0] load_data,                        // 입력 데이터 (N bit)
    output [N-1:0]  sum                             // 출력 합계 결과 (N bit)
);

    wire [N-1:0] carry_out;                         // 각 자리의 carry 출력을 저장할 배열

    half_adder_dataflow ha0(                        // 첫번째 비트(LSB)는 inc와 load_data[0]을
        .a(inc),                                    // 하프에더로 연산
        .b(load_data[0]),
        .s(sum[0]),
        .c(carry_out[0])
    );

    genvar i;                                       // generate문을 위한 변수 선언
    generate
        for (i = 1; i < N; i = i + 1) begin : hagen // Label을 "hagen"으로 블록 지정
            half_adder_dataflow ha(
                .a(carry_out[i - 1]),               // 이전 자리의 캐리 입력
                .b(load_data[i]),                   // 현재 자리의 입력 비트
                .s(sum[i]),                         // 현재 자리의 합 출력
                .c(carry_out[i])                    // 다음 자리로 전달될 케릭 출력
            );
        end
    endgenerate
    
endmodule


module half_adder_N_bit # (parameter N = 8)(    
// # (parameter N = 8)은 이 모듈이 'N'이라는 파라미터를 가지며
// N의 기본값은 8비트임을 의미합니다. 모듈 인스턴스화 시 N을 변경할 수 있음
                                             
    input inc,                                      // 1비트 입력 신호를 선언 
                                                    // (보통은 1 또는 0을 더하는 값으로 사용될 의도인 듯)

    input [N-1:0] load_data,                        // load_data 라는 N비트 입력 신호를 선언 (주요 피연산자)

    output [N-1:0]  sum                             // sum 이라는 N비트 출력 신호를 선언 (덧셈 결과)
);

    wire [N-1:0] carry_out;                         // 'carry_out'이라는 N비트 와이어 배열을 선언
                                                    // 각 비트는 해당 자리의 캐리(자리올림) 출력을 저장할 용도

    // 첫 번째 비트(LSB)를 처리하는 Half Adder를 인스턴스화합니다. (0번째 인덱스)
    // 인스턴스 이름은 'ha0'입니다.
    half_adder_dataflow ha0(
        .a(inc),                                    // 'ha0'의 첫 번째 입력 'a'에 모듈의 'inc'를 연결합니다.
                                                    // 즉, 'inc'가 최하위 비트의 덧셈에 직접 참여합니다.
        .b(load_data[0]),                              // 오류 가능성: 'ha0'의 두 번째 입력 'b'에 N비트 전체 'load_data'를 연결했습니다.
                                                    // Half Adder는 1비트 입력 2개를 받는데, N비트 'load_data' 전체가 연결되면 문제가 발생합니다.
                                                    // 의도: .b(load_data[0]) 이어야 합니다.
        .s(sum[0]),                                 // 'ha0'의 합(sum) 출력 's'를 'sum' 배열의 최하위 비트 'sum[0]'에 연결합니다.
        .c(carry_out[0])                            // 'ha0'의 캐리(carry) 출력 'c'를 'carry_out' 배열의 첫 번째 비트 'carry_out[0]'에 연결합니다.
    );

    genvar i;                                       // generate 문을 사용하기 위한 정수형 변수 'i'를 선언

    generate                                        // generate 블록을 시작 (반복적으로 하드웨어 인스턴스를 생성할 때 사용)
        for (i = 1; i < N; i = i + 1) begin : hagen // for 루프를 사용하여 'i'가 1부터 N-1까지 반복되도록 합니다.
                                                    // 각 반복 블록에는 'hagen'이라는 레이블이 붙습니다 (예: hagen[1], hagen[2]...)
            half_adder_dataflow ha(                 // 'half_adder_dataflow' 모듈을 인스턴스화합니다. (인스턴스 이름 'ha'는 'hagen[i]'와 결합)
                .a(carry_out[i - 1]),               // 'ha'의 첫 번째 입력 'a'에 이전 자리의 캐리 출력 'carry_out[i-1]'을 연결합니다.
                                                    // 이는 전가산기(Full Adder)에서 이전 자리에서 넘어오는 캐리 입력(carry-in)과 유사한 역할을 합니다.
                .b(load_data[i]),                   // 'ha'의 두 번째 입력 'b'에 'load_data'의 현재 비트 'load_data[i]'를 연결합니다.
                .s(sum[i]),                         // 'ha'의 합(sum) 출력 's'를 'sum' 배열의 현재 비트 'sum[i]'에 연결합니다.
                .c(carry_out[i])                    // 'ha'의 캐리(carry) 출력 'c'를 'carry_out' 배열의 현재 비트 'carry_out[i]'에 연결합니다.
                                                    // 이는 다음 자리로 전달될 캐리 출력입니다.
            );
        end // for 루프 끝
    endgenerate // generate 블록 끝
    
endmodule // 모듈 정의 끝


// Full-adder
module full_adder_structural (
    input a, b, cin,                // 입력비트 3개 (이전자리에 올라온 자리올림은 cin)
    output sum, carry               // 출력
);
    wire sum_0;                     // 첫번째 반가산기의 합
    wire carry_0;                   // 첫번째 반가산기의 캐리
    wire carry_1;                   // 두번째 반가산기의 캐리

    // 첫번째 반가산기 : 입력 a, b를 더함
    // 결과로 sum_0에 중간합이 저장, carry_0 에 자리올림
    half_adder_structural ha0(
        .a(a),
        .b(b),
        .s(sum_0),
        .c(carry_0)
    );

    // 두번째 반가산기 : sum_0 하고 cin 을 더함
    // 최종합(sum)은 여기서 나옴, carry_1은 중간 자리올림
    half_adder_structural ha1(
        .a(sum_0),
        .b(cin),
        .s(sum),
        .c(carry_1)

    );
    // 최종 자리올림은 두 자리 올림의 OR연산 (carry_0, carry_1)
    // 둘 중 하나라도 1이면 carry 출력은 1
    or (carry, carry_0, carry_1);

endmodule


module full_adder_behavioral (
    input a, b, cin,
    output reg sum, carry
);

    always @(a, b, cin) begin
        // 입력 3비트를 하나의 값으로 묶어서 case 처리
        case ({a, b, cin})
            3'b000 : begin sum = 0; carry = 0; end // 0 + 0 + 0 = sum 0, carry 0
            3'b001 : begin sum = 1; carry = 0; end // 0 + 0 + 1 = sum 1, carry 0
            3'b010 : begin sum = 1; carry = 0; end // 0 + 1 + 0 = sum 1, carry 0
            3'b011 : begin sum = 0; carry = 1; end // 0 + 1 + 1 = sum 0, carry 1
            3'b100 : begin sum = 1; carry = 0; end // 1 + 0 + 0 = sum 1, carry 0
            3'b101 : begin sum = 0; carry = 1; end // 1 + 0 + 1 = sum 0, carry 1
            3'b110 : begin sum = 0; carry = 1; end // 1 + 1 + 0 = sum 0, carry 1
            3'b111 : begin sum = 1; carry = 1; end // 1 + 1 + 1 = sum 1, carry 1
            
        endcase
    end
    
endmodule


module full_adder_dataflow (
    input a, b, cin,
    output sum, carry
);
    wire [1:0] sum_value;   // 2비트 와이어 -> 덧셈결과 (하위 : sum, 상위 : carry)

    assign sum_value = a + b + cin;

    assign sum = sum_value[0];
    assign carry = sum_value[1];

endmodule


module fadder_4bit_structural (
    input [3:0] a, b,       // 4bit input
    input cin,              // first carry input
    output [3:0] sum,       // result 4bit
    output carry            // final carry (MSB)
);
    
    wire [2:0] carry_w;     // 내부 전가산기 캐리 연결용

    // 첫번째 비트 : cin 과 함께 계산
    full_adder_structural fa0(
        .a(a[0]),
        .b(b[0]),
        .cin(cin),
        .sum(sum[0]),
        .carry(carry_w[0])
    );
    // 두번째 비트 : 이전 자리 캐리를(carry_w[0]) cin으로 사용
    full_adder_structural fa1(
        .a(a[1]),
        .b(b[1]),
        .cin(carry_w[0]),
        .sum(sum[1]),
        .carry(carry_w[1])
    );
    // 세번째
    full_adder_structural fa2(
        .a(a[2]),
        .b(b[2]),
        .cin(carry_w[1]),
        .sum(sum[2]),
        .carry(carry_w[2])
    );
    // 네번째
    full_adder_structural fa3(
        .a(a[3]),
        .b(b[3]),
        .cin(carry_w[2]),
        .sum(sum[3]),
        .carry(carry)
    );

endmodule


module fadder_sub_4bit_structural (
    input [3:0] a, b,   // 4bit input
    input s,            // select signal(0 : add, 1 : sub)
    output [3:0] sum,   // 4bit result
    output carry        // final carry (carry or borrow)
);
    
    wire [2:0] carry_w; // 각 자리에서 발생하는 중간 캐리
    wire [3:0] b_w;     // b 입력값과 s 신호를 xor 한 결과(b의 보수 처리용)

    // b의 각 비트와 s를 xor
    // s가 0이면 b_w는 b와 같음(덧셈모드)
    // s가 1이면 b_w는 b의 각 비트가 반전됨 (뺄셈 모드, 2의 보수 연산 준비)
    xor (b_w[0], b[0], s);
    xor (b_w[1], b[1], s);
    xor (b_w[2], b[2], s);
    xor (b_w[3], b[3], s);

    full_adder_structural fa0(.a(a[0]), .b(b_w[0]), .cin(s),          .sum(sum[0]), .carry(carry_w[0]));
    full_adder_structural fa1(.a(a[1]), .b(b_w[1]), .cin(carry_w[0]), .sum(sum[1]), .carry(carry_w[1]));
    full_adder_structural fa2(.a(a[2]), .b(b_w[2]), .cin(carry_w[1]), .sum(sum[2]), .carry(carry_w[2]));
    full_adder_structural fa3(.a(a[3]), .b(b_w[3]), .cin(carry_w[2]), .sum(sum[3]), .carry(carry));

endmodule


module fadder_sub_4bit_dataflow (
    input [3:0] a, b,
    input s,
    output [3:0] sum,
    output carry
);
    wire [4:0] sum_value;       // 5bit wire : 덧셈/뺄셈 결과 (4비트 + 캐리비트)
    
    assign sum_value = s ? a - b : a + b;
    assign sum = sum_value[3:0];

    assign carry = s ? ~sum_value[4] : sum_value[4];

endmodule


module fadder_sub_4bit_behavioral (
    input [3:0] a, b,
    input s,
    output reg [3:0] sum,
    output reg carry
);

    reg [4:0] temp; // 5비트 임시 변수
    
    always @(*) begin
        if (s == 0)
            temp = a + b;
        else
            temp = a - b;

        sum = temp[3:0];
        carry = s ? ~temp[4] : temp[4];
    end

endmodule