`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/22/2025 09:23:13 AM
// Design Name: 
// Module Name: led
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


module led_blink_1s(
    input clk,
    input reset,
    output reg [7:0] led
    );

    reg clk_1Hz;
    reg [26:0] count;

    // 간단하게 1Hz 클럭 생성
    always @(posedge clk or posedge reset) begin
        if(reset) begin
            count <= 0;
            clk_1Hz <= 0;
        end
        else begin
            if (count == 49999999) begin
                count <= 0;
                clk_1Hz <= ~clk_1Hz;
            end
            else begin
                count <= count + 1;
            end
        end
    end

    always @(posedge clk_1Hz or posedge reset) begin
        if(reset) begin
            led <= 8'b00000000;
        end
        else begin
            led <= ~led;
        end
    end

endmodule


module led_shift_R (
    input clk,
    input reset,
    output reg [7:0] led
    );

    reg clk_1Hz;
    reg [26:0] count;

    // 간단하게 1Hz 클럭 생성
    always @(posedge clk or posedge reset) begin
        if(reset) begin
            count <= 0;
            clk_1Hz <= 0;
        end
        else begin
            if (count == 49_999_999) begin
                count <= 0;
                clk_1Hz <= ~clk_1Hz;
            end
            else begin
                count <= count + 1;
            end
        end
    end

    always @(posedge clk_1Hz or posedge reset) begin
        if(reset) begin
            led <= 8'b10000000;
        end
        else begin
            if (led == 8'b00000001) begin
                led <= 8'b10000000;
            end
            else begin
                led <= led >> 1;
            end
        end
    end
    
endmodule


module led_shift_R2 (
    input clk,
    input reset,
    output reg [7:0] led
    );

    reg clk_1Hz;
    reg [26:0] count;
    reg dir;

    // 간단하게 1Hz 클럭 생성
    always @(posedge clk or posedge reset) begin
        if(reset) begin
            count <= 0;
            clk_1Hz <= 0;
        end
        else begin
            if (count == 49_999_999) begin
                count <= 0;
                clk_1Hz <= ~clk_1Hz;
            end
            else begin
                count <= count + 1;
            end
        end
    end

    // LED 이동 상태 업데이트
    always @(posedge clk_1Hz or posedge reset) begin
        if(reset) begin
            led <= 8'b10000000; // 왼쪽 끝부터 시작
            dir <= 0;           // 오른쪽 방향으로 시작
        end
        else begin
            if (dir == 0) begin // 오른쪽 이동
                if(led == 8'b00000001)
                    dir <= 1;   // 오른쪽 끝 도달하면 방향 반전
                else
                    led <= led >> 1;
            end
            else begin          // 왼쪽 이동
                if(led == 8'b10000000)
                    dir <= 0;   // 왼쪽 끝 도달하면 방향 반전
                else
                    led <= led << 1;
            end
        end
    end
    
endmodule