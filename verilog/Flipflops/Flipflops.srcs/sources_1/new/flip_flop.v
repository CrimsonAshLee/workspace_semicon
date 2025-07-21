`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/18/2025 02:34:51 PM
// Design Name: 
// Module Name: flip_flop
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


// 플립플롭 -> 저장소자
// 클럭신호에 동기화 -> 상태가 변경 -> 엣지트리거
// 타이밍제어가 정확
// 용도 : 동기식 레지스터, FSM상태 저장, 파이프라인 레지스터, 카운터 등...
// D플립플롭,  T플립플롭, JK플립플롭
// 안전성 높음

// 래치 -> 기억소자
// 클럭대신 제어신호에 의해서 동작 (비동기적 -> 레벨트리거)
// 타이밍제어가 힘듬 (비동기) -> 간단한 제어
// SR래치, D래치
// 안정성이 낮음

// vivado에서 권장은 플립플롭이고 래치는 특수한 경우에만 사용

////////////////////////////////////////////////////

// D Flip-Flop
// 입력된 데이터(D를 클럭신호(clk)의 엣지(edge)에 맞춰 출력(Q)에 전달 : 동기식
// 시간 clk   D  Q
// t0   0    1  0
// t1   1(R) 1  1 <- 상승엣지에서 D=1 이니까 Q = 1
// t2   0    0  1 <- 엣지가 없음           Q 유지
// t3   1(R) 0  0 <- 상승엣지에서 D=0 이니까 Q = 0



module D_flip_flop_Basic(
    input clk,      // 클럭 입력
    input d,        // 데이터 입력
    output reg q    // 출력
    );

    always @(posedge clk) begin     // 상승엣지 일때...
        q <= d;     // q에 d를 저장    
    end

endmodule


module D_flip_flop_n ( // negative
    input d,
    input clk,
    input reset_p,       // 비동기 리셋신호(상승엣지에서 작동)
    input enable,        // 1일때만 데이터 입력 허용
    output reg q
);

    always @(negedge clk or posedge reset_p) begin
        // 비동기 신호인 rest_p가 1이 되면 즉시 q를 0으로 리셋 
        if(reset_p)
            q <= 0;
        else if(enable)     // enable이 1일 때만 d를 q로 저장
            q <= d;         // enable이 0일때는 q를 이전값으로 유지
    end
    
endmodule
