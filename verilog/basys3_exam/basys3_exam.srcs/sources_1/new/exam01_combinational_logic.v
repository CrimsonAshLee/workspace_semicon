`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/21/2025 09:28:44 AM
// Design Name: 
// Module Name: and_gate
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


module and_gate(
    input A,
    input B,
    output F
    );
    
    assign F = A & B;

endmodule

module half_adder_structural(       // 모듈선언, 구조적 모델링
    input A, B,
    output sum, carry       // carry는 올림수
    );

    xor (sum, A, B);        // (출력, 입력, 입력, 입력....) 입력은 여러개 일 수있음 (); 바깥은 입출력이 어떻게 동작하는지에 대해 설명
    and (carry, A, B);
    
    
endmodule                       // 모듈 끝

module half_adder_behavioral(       // 동작적 모델링
    input A, B,
    output reg sum, carry           // always 아래에 '=' 왼쪽에 변수를 선언하면(즉, 입력을 받는 변수) reg를 써줘야 한다.
    );

    always @(A, B)begin         // a b 값이 변하면  아래에 있는것들은 한번 실행하라는 의미
        case({A, B})                                    // A,B입력이 들어올건데 {묶어서} // 1bit, 1bit 묶어서 2bit
            2'b00: begin sum = 0; carry = 0; end        // 그것이 00 이면 sum = 0, carry = 0 이다 // b : binary, d : decimal
            2'b01: begin sum = 1; carry = 0; end        // 베릴로그의 수표현방식 : 2는 2bit 라는 뜻이고
            2'b10: begin sum = 1; carry = 0; end        // 'b는 binary
            2'b11: begin sum = 0; carry = 1; end
        endcase
    end                                                 // begin end로 중블럭을 대체함

endmodule

module half_adder_dataflow(             // 데이터의 흐름을 가지고 한것이 dataflow모델링이다
    input A, B,                         // A, B 입력 
    output sum, carry                   // 출력 
    );
    
    wire [1:0] sum_value;               // 2bit 짜리 와이어 [1:0], assign 문은 wire를 선언해야한다.
                                        // 0번 비트가 하위비트, 1번 비트가 상위비트
                                        // 0번 자리가 sum이 되고, 1번 자리가 carry 이다
    
    assign sum_value = A + B;           // A + B를 더해서 sum_value에 대입한다. A, B둘다 1일 경우 더하게되면 
                                        // 1bit 더하기 라도 캐리가 발생해서  1 '0' 두자리가 될 수 있다
                                        // 그래서 위의 wire옆에 [1:0] 두자리(2bit) 선언을 해준것이다.
                                        
    assign sum = sum_value[0];          // [0]은 하위비트
    assign carry = sum_value[1];        // [1]은 상위비트

endmodule

module full_adder_behavioral(
    input A, B, cin,
    output reg sum, carry
    );
    
    always @(A, B, cin)begin         // a b 값이 변하면  아래에 있는것들은 한번 실행하라는 의미
        case({A, B, cin})                                    // {}베릴로그에서는 
            3'b000: begin sum = 0; carry = 0; end        // b : binary, d : decimal
            3'b001: begin sum = 1; carry = 0; end
            3'b010: begin sum = 1; carry = 0; end
            3'b011: begin sum = 0; carry = 1; end
            3'b100: begin sum = 1; carry = 0; end
            3'b101: begin sum = 0; carry = 1; end
            3'b110: begin sum = 0; carry = 1; end
            3'b111: begin sum = 1; carry = 1; end
        endcase
    end
    
endmodule

module full_adder_structural(
    input A, B, cin,
    output sum, carry
    );
    
    wire sum_0, carry_0, carry_1;
    
    half_adder_structural ha0(.A(A), .B(B), .sum(sum_0), .carry(carry_0));       // 인스턴스명 : 객체를 가지고 만듦
    half_adder_structural ha1(.A(sum_0), .B(cin), .sum(sum), .carry(carry_1));
    
    or (carry, carry_0, carry_1);
    
     
endmodule

module full_adder_dataflow(
    input A, B, cin,
    output sum, carry
    );
    
    wire [1:0] sum_value;
    
    assign sum_value = A + B + cin;
    assign sum = sum_value[0];
    assign carry = sum_value[1];
    
endmodule    

module fadder_4bit_dataflow(
    input [3:0] A, B,
    input cin,
    output [3:0] sum,
    output carry
    );
    
    wire [4:0] sum_value;
    
    assign sum_value = A + B + cin;
    assign sum = sum_value[3:0];
    assign carry = sum_value[4];
    
endmodule

module fadder_4bit_stuctural(
    input [3:0] A, B,
    input cin,
    output [3:0] sum,
    output carry
    );
    
    wire [2:0] carry_w;

    full_adder_structural fa0(.A(A[0]), .B(B[0]), .cin(cin), .sum(sum[0]), .carry(carry_w[0]));
    full_adder_structural fa1(.A(A[1]), .B(B[1]), .cin(carry_w[0]), .sum(sum[1]), .carry(carry_w[1]));
    full_adder_structural fa2(.A(A[2]), .B(B[2]), .cin(carry_w[1]), .sum(sum[2]), .carry(carry_w[2]));
    full_adder_structural fa3(.A(A[3]), .B(B[3]), .cin(carry_w[2]), .sum(sum[3]), .carry(carry));
    
endmodule

module mux_2_1(
    input [1:0] d,
    input s,
    output f
    );

    assign f = s ? d[1] : d[0];         // s가 참이면 f는 d[1]이 들어가고 거짓이면 d[0]이다

endmodule

module mux_4_1(
    input [3:0] d,
    input [1:0] s,
    output f
    );

    assign f = d[s];       

endmodule    

module mux_8_1(
    input [7:0] d,
    input [2:0] s,
    output f
    );

    assign f = d[s];       

endmodule

module demux_1_4_d(
    input d,
    input [1:0] s,
    output [3:0] f
    );
    
    assign f = (s == 2'b00) ? {3'b000, d} :
               (s == 2'b01) ? {2'b00, d, 1'b0} :
               (s == 2'b00) ? {1'b00, d, 2'b00} : {d,  3'b000};
               
endmodule 

module mux_demux_test(
    input [3:0] d,
    input [1:0] mux_s,
    input [1:0] demux_s,
    output [3:0] f
    );
    
    wire mux_f;
    
    mux_4_1 mux_4(.d(d), .s(mux_s), .f(mux_f));
    demux_1_4_d demux4(.d(mux_f), .s(demux_s), .f(f));

endmodule

module encoder_4_2(
    input [3:0] signal,
    output reg [1:0] code       // default는 wire 
    );
    
//    assign code = (signal == 4'b1000) ? 2'b11 :
//                  (signal == 4'b0100) ? 2'b10 :
//                  (signal == 4'b0010) ? 2'b01 : 2'b00;          // if else if...else if 같은 느낌 

//    always @(signal)begin
//        if(signal == 4'b1000) code = 2'b11;
//        else if(signal == 4'b0100) code = 2'b10;
//        else if(signal == 4'b0010) code = 2'b01;
//        //else if(signal == 4'b0001) code = 2'b00;
//        else code = 2'b00;
//    end
    
    always @(signal)begin
        case(signal)
            4'b0001: code = 2'b00;
            4'b0010: code = 2'b01;
            4'b0100: code = 2'b10;
            4'b1000: code = 2'b11;
            default: code = 2'b00;          //  안쓰면 심각한 오류문제가 발생 한다 
        endcase
    end    
   
endmodule

module decoder_2_4(
    input [1:0] code,
    output reg [3:0] signal
    );
    
//    assign signal = (code == 2'b00) ? 4'b0001 :
//                    (code == 2'b01) ? 4'b0010 :
//                    (code == 2'b10) ? 4'b0100 : 4'b1000;
   
//      always @(code) begin
//        if( code == 2'b00 ) signal = 4'b0001;
//        else if( code == 2'b01 ) signal = 4'b0010;
//        else if( code == 2'b10 ) signal = 4'b0100;
//        else if( code == 2'b11 ) signal = 4'b1000;
//        else signal = 4'b0000;
//      end

    always @(signal) begin
        case (code)
            2'b00: signal = 4'b0001;
            2'b01: signal = 4'b0010;
            2'b10: signal = 4'b0100;
            2'b11: signal = 4'b1000;
            default: signal = 4'b0000;
        endcase
    end
                    

endmodule


module seg_decoder (
    input [3:0] digit_in,
    output reg [7:0] seg_out
);

    always @(*) begin
        case (digit_in)
                            // pgfe_dcba
            4'd0: seg_out = 8'b1100_0000; // 0 (dp 꺼짐)
            4'd1: seg_out = 8'b1111_1001; // 1
            4'd2: seg_out = 8'b1010_0100; // 2
            4'd3: seg_out = 8'b1011_0000; // 3
            4'd4: seg_out = 8'b1001_1001; // 4
            4'd5: seg_out = 8'b1001_0010; // 5
            4'd6: seg_out = 8'b1000_0010; // 6
            4'd7: seg_out = 8'b1111_1000; // 7
            4'd8: seg_out = 8'b1000_0000; // 8
            4'd9: seg_out = 8'b1001_0000; // 9
            4'hA: seg_out = 8'b1000_1000; // A
            4'hb: seg_out = 8'b1000_0011; // b
            4'hC: seg_out = 8'b1100_0110; // C
            4'hd: seg_out = 8'b1010_0001; // d
            4'hE: seg_out = 8'b1000_0110; // E
            4'hF: seg_out = 8'b1000_1110; // F

            default: seg_out = 8'b1111_1111;    
        endcase
    end    
endmodule

// 자릿수 선택
// dispaly_scan_controller 에서 넘어온 
// 현재 스캔중인 자리 인덱스(scan_count)를 기반으로 4자리 선택
module anode_selector (
    input [1:0] scan_count,
    output reg [3:0] an_out
);
    always @(*) begin
        case (scan_count)
            2'd0: an_out = 4'b1110; // an[0]
            2'd1: an_out = 4'b1101; // an[1]
            2'd2: an_out = 4'b1011; // an[2]
            2'd3: an_out = 4'b0111; // an[3]
            default: an_out = 4'b1111;
        endcase
    end
endmodule


module bin_to_dec(
    input [11:0] bin,           // 12비트 이진 입력
    output reg [15:0] bcd       // 4자리의 BCD를 출력 (4비트 x 4자리)
    );

    integer i;      // 반복문

    always @(bin) begin
        
        bcd = 0;    // initial value

        for(i = 0; i < 12; i = i + 1) begin
            // 1) 알고리즘 각 단위비트 자리별로 5이상이면 +3 해줌
            if(bcd[3:0] >= 5) bcd[3:0] = bcd[3:0] + 3;          // 1의 자리수
            if(bcd[7:4] >= 5) bcd[7:4] = bcd[7:4] + 3;          // 10의 자리수
            if(bcd[11:8] >= 5) bcd[11:8] = bcd[11:8] + 3;       // 100의 자리수
            if(bcd[15:12] >= 5) bcd[15:12] = bcd[15:12] +3;     // 1000의 자리수

            // 2) 1비트 left shift + 새로운 비트 붙임
            bcd = {bcd[14:0], bin[11 - i]};
        end
        
    end
endmodule














