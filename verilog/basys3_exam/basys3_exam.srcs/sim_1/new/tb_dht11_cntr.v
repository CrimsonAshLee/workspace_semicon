`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/18/2025 12:14:33 PM
// Design Name: 
// Module Name: tb_dht11_cntr
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


module tb_dht11_cntr();   // tb파일은 입출력이 없다. 내부 와이어만 보기 때문

    localparam [7:0] humi_value = 8'd70;
    localparam [7:0] tmpr_value = 8'd25;
    localparam [7:0] check_sum = humi_value + tmpr_value;
    localparam [39:0] data = {humi_value, 8'd0, tmpr_value, 8'd0, check_sum};

    reg clk, reset_p; //  input은 reg로

    wire [7:0] humidity, temperature;
    // assign humidity = // 8'b0000_0001;
    reg dout, wr_e;   // write enable
    tri1 dht11_data;    // reg, wire, integer외에 나머지변수는 tb에서 사용
                        // tri1 : 풀업저항이 달린 wire 변수로 simulation에서만 사용 가능
    assign dht11_data = wr_e ? dout : 'bz; // 'bz : 몇비트인지 선언이 없다.
                                           // 다 임피던스이다
    
    dht11_cntr DUT( // .과 ()안을 안써주고 순서대로 써주면 순서대로 연결된다.
                    // 어떤것은 지정하고 어떤것은 안쓰고는 안된다. 통일할것
        clk,
        reset_p,
        dht11_data,   
        humidity, 
        temperature,
        );

    initial begin
        clk = 0;
        reset_p = 1;
        wr_e = 0;
    end

    always #5 clk = ~clk;   // #5 : 5ns delay, 1clk은 10ns

    integer i;  // for문을 위한 i

    initial begin
        #10;
        reset_p = 0; #10;
        wait(!dht11_data);  // wait : while문. true가 될때까지 반복(18ms)
        wait(dht11_data);   // high들어옴
        #20_000;
        dout = 0; wr_e = 1; #80_000;
        wr_e = 0; #80_000;
        wr_e = 1;
        for (i = 0; i < 40; i = i + 1) begin    // 40번 반복해서 data40개 보냄
            dout = 0; #50_000; // 50us
            dout = 1;
            if (data[39 - i]) begin
                #70_000;
            end
            else begin
                #27_000;
            end
        end
        dout = 0; #10;
        wr_e = 0; #1000;
        $stop;  // 시뮬레이션 종료. $ : 시스템명령어
    end

endmodule   // tb가 좀더 소프트웨어 적인 문법이 더 존재한다.
