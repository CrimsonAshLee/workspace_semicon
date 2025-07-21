`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/15/2025 02:41:33 PM
// Design Name: 
// Module Name: tb_half_adder
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


module tb_half_adder;

    reg a, b;
    // reg 타입으로 선언. reg 타입은 initial 이나 always 내에서
    // 값을 할당하고 유지할 수 있음.

    wire s, c;
    // wire 타입은 다른 모듈의 출력에 의해 구동되거나
    // assign 문으로 값이 할당되는 물리적인 연결선을 나타냄

    Half_adder_behavioral uut (
        .a(a),  // Half_adder_behavioral의 입력 .a에
        .b(b),  // 테스트벤치의 (a)를 연결
        .s(s),
        .c(c)
    );

    initial begin   // initial은 시뮬레이션이 시작될때 한번만 실행됨
        $display("Time\ta b | s c");
        $monitor("%0t\t%b %b | %b %b", $time, a, b, s, c);

        a = 0; b = 0; #10;  // #10은 10ns 동안 시뮬레이션 지연을 나타냄
        a = 0; b = 1; #10;
        a = 1; b = 0; #10;
        a = 1; b = 1; #10;
        $finish;
    end

endmodule
