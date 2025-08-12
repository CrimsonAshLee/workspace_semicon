`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/12/2025 06:49:08 PM
// Design Name: 
// Module Name: practice_controller
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


module debounce (
    input clk,            // 시스템 클럭 입력 (모든 동작의 기준)
    input btn_in,         // 떨림이 있는 원본 버튼 신호
    output reg btn_out    // 떨림이 제거된, 안정적인 버튼 출력 신호
);
    reg [15:0] count;           // 신호의 안정성을 세는 16비트 카운터
    reg btn_sync_0, btn_sync_1; // 비동기 입력 신호를 클럭에 동기화하기 위한 2개의 플립플롭

    wire stable = (count == 16'hFFFF); // 카운터가 최대값에 도달했는지 확인하는 와이어

    always @(posedge clk) begin       // 클럭의 상승 엣지마다 실행
        btn_sync_0 <= btn_in;         // 버튼 입력을 첫 번째 플립플롭에 저장
        btn_sync_1 <= btn_sync_0;     // 첫 번째 플립플롭의 출력을 두 번째에 저장
    end

    always @(posedge clk) begin       // 클럭의 상승 엣지마다 실행
        if (btn_sync_1 == btn_out) begin // 동기화된 신호와 출력이 같으면 (안정적이면)
            count <= 0;               // 카운터 리셋
        end
        else begin                      // 동기화된 신호와 출력이 다르면 (변화 감지)
            count <= count + 1;       // 카운터 증가
            if(stable)                // 카운터가 충분히 오래 유지되었으면
            btn_out <= btn_sync_1;    // 출력을 안정된 신호로 업데이트
        end        
    end
endmodule











module btn_cntr (
    input clk,          // 시스템 클럭 입력
    input reset_p,      // 리셋 입력
    input btn,          // 물리적인 떨림이 포함된 버튼 신호 입력

    output btn_pedeg,   // 버튼 눌림(상승 엣지)을 감지한 신호
    output btn_nedge    // 버튼 떼기(하강 엣지)를 감지한 신호

    );
    // wire debounce_btn; // 'debounce_btn' 와이어가 선언되지 않아서 오류 발생
                         // 하지만 실제 Vivado에서는 자동으로 와이어가 연결될 수 있음

    // 하위 모듈: debounce
    debounce btn_0(
        .clk(clk),              // 시스템 클럭을 debounce 모듈의 클럭으로 연결
        .btn_in(btn),           // 떨림이 있는 원본 버튼 신호를 debounce 모듈의 입력으로 연결
        .btn_out(debounce_btn)  // debounce 모듈의 출력(떨림 제거된 신호)을 'debounce_btn' 와이어에 연결
    );

    // 하위 모듈: edge_detector_p
    edge_detector_p btn_ed(
        .clk(clk),              // 시스템 클럭을 edge_detector 모듈의 클럭으로 연결
        .reset_p(reset_p),      // 리셋 신호를 edge_detector 모듈의 리셋으로 연결
        .cp(debounce_btn),      // 떨림이 제거된 신호를 edge_detector 모듈의 입력으로 연결
        .p_edge(btn_pedge),     // edge_detector의 상승 엣지 감지 출력을 'btn_pedge' 출력 포트에 연결
        .n_edge(btn_nedge)      // edge_detector의 하강 엣지 감지 출력을 'btn_nedge' 출력 포트에 연결
    );

endmodule