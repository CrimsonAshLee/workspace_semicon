`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/12/2025 06:45:46 PM
// Design Name: 
// Module Name: practice02_sequential_logic
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


    // cur = 1, old = 0 => p = 1
    // cur = 1, old = 1 => p = 0
    // cur = 0, old = 1 => n = 1    이 주석들은 무슨 뜻일까?

module edge_detector_n (          // 1에서 0으로 바뀌는 하강엣지일때 감지
    input clk,                    // 시스템 클럭 입력
    input reset_p,                // 리셋 입력
    input cp,                     // 엣지를 감지할 대상 신호 (보통 디바운스된 버튼 신호)

    output p_edge,                // 상승 엣지 감지 출력
    output n_edge                 // 하강 엣지 감지 출력
);
    reg ff_cur, ff_old;           // 현재와 이전 상태를 저장하는 1비트 레지스터

    // always 블록은 클럭의 하강 엣지 또는 리셋의 상승 엣지에서만 동작
    always @(negedge clk or posedge reset_p) begin
        if (reset_p) begin        // 리셋 신호가 들어오면
            ff_cur <= 0;          // 현재 상태 레지스터를 0으로 초기화
            ff_old <= 0;          // 이전 상태 레지스터를 0으로 초기화
        end
        else begin                // 리셋이 아니면
            ff_old <= ff_cur;     // 이전 상태 레지스터에 현재 상태를 저장 (한 클럭 늦게)
            ff_cur <= cp;         // 현재 상태 레지스터에 입력 신호를 저장
        end
    end

    // 상승 엣지 감지: 현재 상태가 1이고 이전 상태가 0일 때 1을 출력
    assign p_edge = ({ff_cur, ff_old} == 2'b10) ? 1 : 0;
    // 하강 엣지 감지: 현재 상태가 0이고 이전 상태가 1일 때 1을 출력
    assign n_edge = ({ff_cur, ff_old} == 2'b01) ? 1 : 0;

endmodule


module edge_detector_p(
    input clk,
    input reset_p,
    input cp,

    output p_edge,
    output n_edge
    );

    reg ff_cur, ff_old;

    always @(posedge clk or posedge reset_p) begin
        if (reset_p) begin
            ff_cur <= 0;
            ff_old <= 0;
        end
        else begin
            ff_old <= ff_cur;
            ff_cur <= cp;
        end
    end
    assign p_edge = ({ff_cur, ff_old} == 2'b10) ? 1'b1 : 1'b0;
    assign n_edge = ({ff_cur, ff_old} == 2'b01) ? 1'b1 : 1'b0;

endmodule
