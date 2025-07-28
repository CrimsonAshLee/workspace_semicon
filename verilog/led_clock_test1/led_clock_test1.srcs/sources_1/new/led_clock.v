`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/24/2025 07:11:58 PM
// Design Name: 
// Module Name: led_clock
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



/*
* 버튼 1 (btn_start_stop): 스톱워치 시작/일시정지
* 버튼 2 (btn_reset): 스톱워치 초기화
* 0.1초 단위로 증가 (10Hz 클럭 기반)
* FND (7세그먼트 디스플레이): HH : MM 형식으로 시간 표시
* LED: 초의 1의 자리 (9개 LED), 초의 10의 자리 (5개 LED) 표시
*/


// 100MHz 클럭을 10Hz 클럭으로 분주하는 모듈
// 입력 클럭이 100MHz라고 가정합니다.
module clock_divider_10Hz(
    input clk,       // 시스템 주 클럭 (예: 100MHz)
    input reset_p,   // 비동기 리셋 신호
    output reg clk_10Hz // 10Hz 출력 클럭
);

    // 100_000_000 / (10Hz * 2) = 5_000_000
    // 0부터 4_999_999까지 카운트 (총 5_000_000 사이클)
    // 100MHz 클럭에서 5_000_000 사이클은 0.05초 (50ms)
    // clk_10Hz가 반전되므로 0.05초마다 반전되어 0.1초 주기의 10Hz 클럭 생성
    reg [26:0] count;

    always @(posedge clk or posedge reset_p) begin
        if (reset_p) begin // reset_p가 활성화되면 카운터와 출력 클럭 초기화
            count <= 0;
            clk_10Hz <= 0;
        end
        else begin
            if (count == 26'd999_999_999) begin // 카운트가 목표값에 도달하면
                count <= 0;           // 카운터 리셋
                clk_10Hz <= ~clk_10Hz; // 10Hz 클럭 토글
            end
            else
            count <= count + 1; // 카운터 증가
        end
    end

endmodule


// 스톱워치 카운터 모듈 (HH:MM:SS 형식)
// FND에는 HH:MM을, LED에는 SS를 표시하기 위해 모든 카운터를 유지합니다.
module stopwatch_counter (
    input clk_10Hz,       // 10Hz 클럭 입력 (0.1초마다 카운트)
    input reset_p,        // 시스템 리셋 신호
    input btn_start_stop, // 시작/일시정지 버튼
    input btn_reset,      // 초기화 (리셋) 버튼

    output reg [3:0] sec_ones,  // 초의 1의 자리 (BCD)
    output reg [3:0] sec_tens,  // 초의 10의 자리 (BCD)
    output reg [3:0] min_ones,  // 분의 1의 자리 (BCD)
    output reg [3:0] min_tens,  // 분의 10의 자리 (BCD)
    output reg [3:0] hour_ones, // 시의 1의 자리 (BCD)
    output reg [3:0] hour_tens  // 시의 10의 자리 (BCD)
);

    // 스톱워치 상태 정의
    parameter IDEL      = 2'b00;    // 대기 (정지) 상태
    parameter RUNNING   = 2'b01;    // 동작 (카운트 증가) 상태
    parameter PAUSED    = 2'b10;    // 일시정지 상태

    reg [1:0] current_state, next_state; // 현재 상태 및 다음 상태 레지스터

    // 상태 레지스터 (sequential logic)
    always @(posedge clk_10Hz or posedge reset_p) begin
        if (reset_p) // 리셋 신호가 활성화되면 IDEL 상태로 초기화
            current_state <= IDEL;
        else
            current_state <= next_state; // 다음 상태로 전이
    end

    // 다음 상태 결정 로직 (combinatorial logic)
    always @(*) begin
        case (current_state)
            IDEL : begin
                // IDEL 상태에서 btn_start_stop이 눌리면 RUNNING으로
                next_state = btn_start_stop ? RUNNING : IDEL;
           end
            RUNNING : begin
                // RUNNING 상태에서 btn_start_stop이 눌리면 PAUSED로
                next_state = btn_start_stop ? PAUSED : RUNNING;
           end
            PAUSED : begin
                // PAUSED 상태에서 btn_reset이 눌리면 IDEL로 (초기화)
                if (btn_reset)
                    next_state = IDEL;
                // PAUSED 상태에서 btn_start_stop이 눌리면 RUNNING으로 (재개)
                else if (btn_start_stop)
                    next_state = RUNNING;
                // 아무것도 눌리지 않으면 PAUSED 유지
                else
                    next_state = PAUSED;
           end
            default: next_state = IDEL; // 정의되지 않은 상태는 IDEL로
        endcase
    end
    
    // 카운터 로직 (sequential logic)
    always @(posedge clk_10Hz or posedge reset_p) begin
        if (reset_p || current_state == IDEL) begin
            // 리셋 누르거나 정지 상태면 모든 카운터 0으로 초기화
            sec_ones <= 0;
            sec_tens <= 0;
            min_ones <= 0;
            min_tens <= 0;
            hour_ones <= 0;
            hour_tens <= 0;
            
        end
        else if (current_state == RUNNING) begin
            // 동작중일때만 시간 증가
            if (sec_ones == 9) begin // 초의 1의 자리가 9이면
                sec_ones <= 0;       // 0으로 리셋
                if (sec_tens == 5) begin // 초의 10의 자리가 5이면 (59초)
                    sec_tens <= 0;       // 0으로 리셋
                        if (min_ones == 9) begin // 분의 1의 자리가 9이면
                            min_ones <= 0;       // 0으로 리셋
                            if (min_tens == 5) begin // 분의 10의 자리가 5이면 (59분)
                                min_tens <= 0;       // 0으로 리셋
                                // 시 카운트 로직 (24시간 형식: 00-23)
                                if (hour_tens == 2 && hour_ones == 3) begin // 23시 59분 59초 -> 다음은 00시 00분 00초
                                    hour_ones <= 0;
                                    hour_tens <= 0;
                                end else if (hour_ones == 9) begin // X9시 -> (X+1)0시 (예: 09시 -> 10시, 19시 -> 20시)
                                    hour_ones <= 0;
                                    hour_tens <= hour_tens + 1;
                                end else begin // X0-X8시 -> X1-X9시
                                    hour_ones <= hour_ones + 1;
                                end
                            end
                            else
                                min_tens <= min_tens + 1; // 분의 10의 자리 증가
                        end
                        else begin
                            min_ones <= min_ones + 1; // 분의 1의 자리 증가
                        end
                end
                else begin
                    sec_tens <= sec_tens + 1; // 초의 10의 자리 증가
                end
            end
            else begin
                sec_ones <= sec_ones + 1; // 초의 1의 자리 증가
            end
        end
    end
endmodule


// 버튼 디바운싱 모듈
// 클럭 입력과 버튼 입력(btn_in)을 받아 디바운싱된 출력(btn_out)을 생성
module debounce (
    input clk,    // 시스템 주 클럭
    input btn_in, // 원본 버튼 입력

    output reg btn_out // 디바운싱된 버튼 출력
);
    reg [15:0] count; // 디바운싱 타이머 카운터
    reg btn_sync_0, btn_sync_1; // 버튼 입력을 동기화하기 위한 레지스터

    // count가 16'hFFFF (65535)에 도달하면 안정된 것으로 간주
    wire stable = (count == 16'hFFFF);
    
    // 입력 버튼 신호를 클럭에 동기화 (2단 플립플롭을 사용하여 메타스테이블 방지)
    always @(posedge clk) begin
        btn_sync_0 <= btn_in;
        btn_sync_1 <= btn_sync_0;
    end

    // 카운터 기반 디바운스 로직
    always @(posedge clk) begin
        if (btn_sync_1 == btn_out) begin // 동기화된 입력이 현재 출력과 같으면
            count <= 0; // 카운터 리셋 (변화가 없으므로 안정 상태)
        end
        else begin // 동기화된 입력이 현재 출력과 다르면 (변화 감지)
            count <= count + 1; // 카운터 증가
            if (stable) // 카운터가 안정 값에 도달하면 (충분히 긴 시간 동안 변화가 없으면)
                btn_out <= btn_sync_1; // 출력을 동기화된 입력으로 업데이트
        end
    end

endmodule


// 100MHz 입력받아 2KHz 클럭을 생성하는 모듈
// 이 클럭은 7세그먼트 디스플레이 자리를 스캔에 사용됨
module clock_divider_2KHz (
    input clk,       // 시스템 주 클럭 (예: 100MHz)
    input reset_p,   // 비동기 리셋 신호
    output reg clk_2KHz // 2KHz 출력 클럭
);

    // 100_000_000 / (2KHz * 2) = 25_000
    // 0부터 24_999까지 카운트 (총 25_000 사이클)
    // 100MHz 클럭에서 25_000 사이클은 0.00025초 (0.25ms)
    // clk_2KHz가 반전되므로 0.25ms마다 반전되어 0.5ms 주기의 2KHz 클럭 생성
    reg [15:0] count;

    always @(posedge clk or posedge reset_p) begin
        if (reset_p) begin // 리셋 신호가 활성화되면 카운터와 출력 클럭 초기화
            count <= 0;
            clk_2KHz <= 0;
        end
        else begin
            if (count == 24_999) begin // 카운트가 목표값에 도달하면
                count <= 0;           // 카운터 리셋
                clk_2KHz <= ~clk_2KHz; // 2KHz 클럭 토글
            end
            else begin
                count <= count + 1; // 카운터 증가
            end
        end
    end    
endmodule

// 2KHz 클럭을 이용하여 어떤 자릿수를 표시할지 선택하고, 해당 자릿수의 값을 출력하는 모듈
module display_scan_controller (
    input scan_clk,   // 2KHz 스캔 클럭
    input reset_p,    // 시스템 리셋 신호
    input [3:0] min_ones, // 분 1의 자리 값
    input [3:0] min_tens, // 분 10의 자리 값
    input [3:0] hour_ones, // 시 1의 자리 값
    input [3:0] hour_tens, // 시 10의 자리 값

    output reg [1:0] scan_count,  // 현재 스캔 중인 자릿수 인덱스 (0:분1, 1:분10, 2:시1, 3:시10)
    output reg [3:0] select_digit // 현재 선택된 자릿수의 BCD 값
);
    
    always @(posedge scan_clk or posedge reset_p) begin
        if (reset_p) begin
            scan_count <= 0; // 리셋 시 scan_count 0으로 초기화
        end
        else begin
            scan_count <= scan_count + 1; // scan_count 증가 (0, 1, 2, 3 반복)
        end
    end

    // scan_count 값에 따라 select_digit에 해당 시간 값 할당 (조합 로직)
    always @(*) begin
        case (scan_count)
            2'd0: select_digit = min_ones;  // 첫 번째 자리: 분의 1의 자리
            2'd1: select_digit = min_tens;  // 두 번째 자리: 분의 10의 자리
            2'd2: select_digit = hour_ones; // 세 번째 자리: 시의 1의 자리
            2'd3: select_digit = hour_tens; // 네 번째 자리: 시의 10의 자리
            default: select_digit = 0;      // 기본값
        endcase
    end
endmodule


// 7세그먼트 디스플레이의 자릿수를 선택하고 BCD 값을 7세그먼트 패턴으로 디코딩하는 모듈
// 점(DP) 표시 기능 포함
module anode_selector_wdp (
    input [1:0] scan_count, // 현재 스캔 중인 자릿수 인덱스
    input [3:0] digit_in,   // 현재 선택된 자릿수의 BCD 값
    output reg [3:0] an_out, // 4자리 애노드 출력 (활성화: 0, 비활성화: 1)
    output reg [7:0] seg_out // 7세그먼트 출력 (a, b, c, d, e, f, g, dp)
);

    // scan_count 값에 따라 해당 애노드를 활성화 (조합 로직)
    // 공통 애노드 방식: 0이 활성화, 1이 비활성화
    always @(*) begin
        case (scan_count)
            2'd0: an_out = 4'b1110; // an[0] (가장 오른쪽 자리)
            2'd1: an_out = 4'b1101; // an[1]
            2'd2: an_out = 4'b1011; // an[2]
            2'd3: an_out = 4'b0111; // an[3] (가장 왼쪽 자리)
            default: an_out = 4'b1111; // 기본값 (모든 애노드 비활성화)
        endcase

        // BCD 입력에 따라 7세그먼트 패턴 할당 (조합 로직)
        // 공통 애노드 방식: 0이 세그먼트 ON, 1이 세그먼트 OFF
        // 2번째 FND (scan_count 2'd1)에만 DP (소수점) 표시 (8'b0xxxxxxx)
        case (scan_count) // an_out 대신 scan_count로 직접 조건 검사
            2'd2: begin // 두 번째 FND (min_tens 자리)에 DP 표시
                case (digit_in)
                    4'd0: seg_out = 8'b0100_0000;   // 0 (dp 켜짐)
                    4'd1: seg_out = 8'b0111_1001;   // 1
                    4'd2: seg_out = 8'b0010_0100;   // 2
                    4'd3: seg_out = 8'b0011_0000;   // 3
                    4'd4: seg_out = 8'b0001_1001;   // 4
                    4'd5: seg_out = 8'b0001_0010;   // 5
                    4'd6: seg_out = 8'b0000_0010;   // 6
                    4'd7: seg_out = 8'b0111_1000;   // 7
                    4'd8: seg_out = 8'b0000_0000;   // 8
                    4'd9: seg_out = 8'b0001_0000;   // 9
                    default: seg_out = 8'b0111_1111; // 그 외 값은 모든 세그먼트 OFF
                endcase
            end
            default: begin // 그 외 FND에는 DP 꺼짐
                case(digit_in)
                    4'd0: seg_out = 8'b1100_0000;   // 0 (dp 꺼짐)
                    4'd1: seg_out = 8'b1111_1001;   // 1
                    4'd2: seg_out = 8'b1010_0100;   // 2
                    4'd3: seg_out = 8'b1011_0000;   // 3
                    4'd4: seg_out = 8'b1001_1001;   // 4
                    4'd5: seg_out = 8'b1001_0010;   // 5
                    4'd6: seg_out = 8'b1000_0010;   // 6
                    4'd7: seg_out = 8'b1111_1000;   // 7
                    4'd8: seg_out = 8'b1000_0000;   // 8
                    4'd9: seg_out = 8'b1001_0000;   // 9
                    default: seg_out = 8'b1111_1111; // 그 외 값은 모든 세그먼트 OFF
                endcase
            end
        endcase
    end
endmodule


// 초의 1의 자리를 LED로 표시하는 드라이버 모듈 (9개 LED)
// BCD 값을 원-핫(one-hot) 형태로 변환하여 LED를 고 끕니다.
module sec_ones_led_driver (
    input [3:0] sec_ones_in, // 초의 1의 자리 BCD 입력 (0-9)
    input reset_p,           // 시스템 리셋
    input enable,            // LED 출력을 활성화할 조건 (예: 스톱워치 RUNNING 상태)
    output reg [8:0] sec_ones_led_out // 9개 LED 출력 (LSB는 1, MSB는 9)
);

    always @(*) begin
        // 리셋 상태이거나, 활성화되지 않았거나, 입력값이 0이면 모든 LED 끔
        if (reset_p || !enable || sec_ones_in == 0) begin
            sec_ones_led_out = 9'b000_000_000; // 모든 LED 끔
        end else begin
            case (sec_ones_in)
                4'd1: sec_ones_led_out = 9'b000_000_001; // 1일 때 첫 번째 LED 고 나머지는 끔
                4'd2: sec_ones_led_out = 9'b000_000_011;
                4'd3: sec_ones_led_out = 9'b000_000_111;
                4'd4: sec_ones_led_out = 9'b000_001_111;
                4'd5: sec_ones_led_out = 9'b000_011_111;
                4'd6: sec_ones_led_out = 9'b000_111_111;
                4'd7: sec_ones_led_out = 9'b001_111_111;
                4'd8: sec_ones_led_out = 9'b011_111_111;
                4'd9: sec_ones_led_out = 9'b111_111_111; // 9일 때 아홉 번째 LED 고 나머지는 끔
                default: sec_ones_led_out = 9'b000_000_000; // 그 외 값은 모두 끔 (안전 장치)
            endcase
        end
    end
endmodule


// 초의 10의 자리를 LED로 표시하는 드라이버 모듈 (5개 LED)
// BCD 값을 원-핫(one-hot) 형태로 변환하여 LED를 고 끕니다.
module sec_tens_led_driver (
    input [3:0] sec_tens_in, // 초의 10의 자리 BCD 입력 (0-5)
    input reset_p,           // 시스템 리셋
    input enable,            // LED 출력을 활성화할 조건
    output reg [4:0] sec_tens_led_out // 5개 LED 출력 (LSB는 10, MSB는 50)
);

    always @(*) begin
        // 리셋 상태이거나, 활성화되지 않았거나, 입력값이 0이면 모든 LED 끔
        if (reset_p || !enable || sec_tens_in == 0) begin
            sec_tens_led_out = 5'b00000; // 모든 LED 끔
        end else begin
            case (sec_tens_in)
                4'd1: sec_tens_led_out = 5'b00001; // 10초일 때 첫 번째 LED 고 나머지는 끔
                4'd2: sec_tens_led_out = 5'b00011;
                4'd3: sec_tens_led_out = 5'b00111;
                4'd4: sec_tens_led_out = 5'b01111;
                4'd5: sec_tens_led_out = 5'b11111; // 50초일 때 다섯 번째 LED 고 나머지는 끔
                default: sec_tens_led_out = 5'b00000; // 그 외 값은 모두 끔 (안전 장치)
            endcase
        end
    end
endmodule


// 엣지 검출기 모듈 (네거티브 엣지)
// 클럭의 네거티브 엣지에서 cp 신호의 변화를 감지합니다.
module edge_detector_n(
    input clk,     // 클럭
    input reset_p, // 리셋
    input cp,      // 감지할 신호
    
    output p_edge, // 포지티브 엣지 감지 (cp가 0->1)
    output n_edge  // 네거티브 엣지 감지 (cp가 1->0)
);

    reg ff_cur, ff_old; // 플립플롭을 이용한 신호 동기화

    always @(negedge clk or posedge reset_p) begin // 클럭의 네거티브 엣지 또는 리셋 상승 엣지
        if(reset_p) begin
            ff_cur <= 0;
            ff_old <= 0;
        end else begin
            ff_old <= ff_cur; // 이전 값 저장
            ff_cur <= cp;     // 현재 값 저장
        end
    end

    // 엣지 감지 로직
    assign p_edge = ({ff_cur, ff_old} == 2'b10) ? 1 : 0; // 0->1 변화
    assign n_edge = ({ff_cur, ff_old} == 2'b01) ? 1 : 0; // 1->0 변화
endmodule

// 엣지 검출기 모듈 (포지티브 엣지)
// 클럭의 포지티브 엣지에서 cp 신호의 변화를 감지합니다.
module edge_detector_p(
    input clk,     // 클럭
    input reset_p, // 리셋
    input cp,      // 감지할 신호
    
    output p_edge, // 포지티브 엣지 감지 (cp가 0->1)
    output n_edge  // 네거티브 엣지 감지 (cp가 1->0)
);

    reg ff_cur, ff_old; // 플립플롭을 이용한 신호 동기화

    always @(posedge clk or posedge reset_p) begin // 클럭의 포지티브 엣지 또는 리셋 상승 엣지
        if(reset_p) begin
            ff_cur <= 0;
            ff_old <= 0;
        end else begin
            ff_old <= ff_cur; // 이전 값 저장
            ff_cur <= cp;     // 현재 값 저장
        end
    end

    // 엣지 감지 로직
    assign p_edge = ({ff_cur, ff_old} == 2'b10) ? 1'b1 : 1'b0; // 0->1 변화
    assign n_edge = ({ff_cur, ff_old} == 2'b01) ? 1'b1 : 1'b0; // 1->0 변화
endmodule


// 링 카운터 모듈 (Case 문 기반)
// 1개의 비트가 정해진 순서대로 한 비트씩 이동 순환합니다.
module ring_counter (
    input clk,     // 클럭
    input reset_p, // 리셋
    output reg [3:0] q // 링 카운터 출력
);
    always @(posedge clk or posedge reset_p) begin
        if (reset_p) begin
            q <= 4'b0001;       // 리셋 시 초기값 0001 설정
        end
        else begin
            case (q)
               4'b0001 : q <= 4'b0010;
               4'b0010 : q <= 4'b0100;
               4'b0100 : q <= 4'b1000;
               4'b1000 : q <= 4'b0001; // 마지막 상태에서 다시 처음으로 순환
                default: q <= 4'b0001;  // 예상치 못한 값일 경우 초기값으로 리셋
            endcase
        end
    end
    
endmodule


// 링 카운터 모듈 (시프트 레지스터 기반)
// 시프트 연산을 통해 1개의 비트를 순환시킵니다.
module ring_counter_shift (
    input clk,     // 클럭
    input reset_p, // 리셋
    output reg [3:0] q // 링 카운터 출력
);

    always @(posedge clk or posedge reset_p) begin
        if (reset_p) begin
            q <= 4'b0001; // 리셋 시 초기값 0001 설정
        end
        else begin
            if (q == 4'b1000) // 마지막 비트가 1이면
                q <= 4'b0001; // 처음으로 순환
            else if(q == 4'b0000 || q > 4'b1000) // 잘못된 값이면 초기값으로
                q <= 4'b0001;
            else
                q <= {q[2:0], 1'b0}; // 왼쪽으로 시프트 (LSB에 0 채움)
        end
    end
    
endmodule


// FND 스캔을 위한 링 카운터 모듈 (예시)
// 엣지 검출기와 클럭 분주기를 사용하여 FND 애노드를 순환 제어합니다.
module ring_counter_fnd (
    input clk,      // 시스템 주 클럭
    input reset_p,  // 리셋
    output reg [3:0] q // FND 애노드 제어 출력
);
    reg [2:0] clk_div; // 클럭 분주용 카운터 (예시: 8분주)

    // 클럭 분주 (clk_div[3]이 16분주된 클럭 엣지를 생성)
    always @(posedge clk) begin
        clk_div <= clk_div + 1;
    end

    wire clk_div_16_p; // 16분주된 클럭의 포지티브 엣지

    // 엣지 검출기 인스턴스화
    edge_detector_n ed( // 네거티브 엣지 검출기를 사용 (clk_div[3]의 1->0 전환)
        .clk(clk),
        .reset_p(reset_p),
        .cp(clk_div[3]), // 16분주된 클럭 신호
        .p_edge(clk_div_16_p), // 이 신호는 엣지 검출기 내부에서 사용되지 않음 (n_edge가 필요)
        .n_edge() // n_edge는 사용되지 않으므로 연결 안 함
    );

    always @(posedge clk or posedge reset_p) begin // clk_div_16_p 대신 clk에 동기화
        if (reset_p) begin
            q <= 4'b1110;    // 리셋 시 초기값 (an[0] 활성화)
        end
        // else if (clk_div_16_p) begin // 이 조건은 ed 모듈의 n_edge를 사용해야 함
        //     if (q == 4'b0111)
        //         q <= 4'b1110;
        //     else
        //         q <= {q[2:0], 1'b1}; // 오른쪽으로 시프트 (MSB에 1 채움)
        // end
        // 위 주석 처리된 부분은 ring_counter_fnd의 의도와 맞지 않으므로,
        // FND 스캔은 display_scan_controller와 anode_selector_wdp가 담당하므로 이 모듈은 현재 사용되지 않습니다.
        // 만약 FND 스캔을 링 카운터로 구현하려면 이 모듈을 수정해야 합니다.
    end
    
endmodule


// LED를 위한 링 카운터 모듈 (예시)
// 클럭 분주 후 링 카운터처럼 LED를 순환 점등합니다.
module ring_counter_led (
    input clk,     // 시스템 주 클럭
    input reset_p, // 리셋
    output reg [15:0] led // LED 출력
);
    
    reg [20:0] clk_div = 0; // 클럭 분주용 카운터

    always @(posedge clk) begin
        clk_div = clk_div + 1; // 클럭 분주
    end

    wire clk_div_20_p; // 분주된 클럭의 포지티브 엣지

    // 엣지 검출기 인스턴스화
    edge_detector_p ed( // 포지티브 엣지 검출기를 사용
        .clk(clk),
        .reset_p(reset_p),
        .cp(clk_div[20]), // 분주된 클럭 신호 (예: 2^20 분주)
        .p_edge(clk_div_20_p), // 포지티브 엣지 감지
        .n_edge() // 네거티브 엣지는 사용되지 않으므로 연결 안 함
    );
    
    always @(posedge clk or posedge reset_p) begin
        if(reset_p)
            led = 16'b0000_0000_0000_0001; // 리셋 시 첫 번째 LED 고 나머지는 끔

        else if(clk_div_20_p) // 분주된 클럭의 포지티브 엣지에서
            led = {led[14:0], led[15]}; // 링 카운터처럼 LED를 왼쪽으로 순환 시프트
    end

endmodule


// 스톱워치 시스템의 최상위 모듈
// 모든 서브 모듈을 인스턴스화하고 연결합니다.
module stopwatch_top ( // 모듈 이름이 led_watch로 되어있으나, 파일명과 일치시키기 위해 stopwatch_top으로 유지합니다.
    input clk,          // 시스템 주 클럭 (예: 100MHz)
    input reset_p,      // 시스템 전체 비동기 리셋 (FPGA 보드의 리셋 버튼 등)
    input btn_start_stop, // 스톱워치 시작/일시정지 버튼 (원본 입력)
    input btn_reset,    // 스톱워치 초기화 버튼 (원본 입력)

    output [7:0] seg, // 7세그먼트 디스플레이 세그먼트 출력
    output [3:0] an,   // 7세그먼트 디스플레이 애노드 선택 출력

    output [8:0] sec_ones_led, // 초의 1의 자리 LED 출력 (9개)
    output [4:0] sec_tens_led  // 초의 10의 자리 LED 출력 (5개)
);

    // 내부 와이어 선언
    wire clk_10Hz; // 10Hz 클럭 신호
    wire [3:0] sec_ones, sec_tens; // 스톱워치 카운터의 초 단위 출력
    wire [3:0] min_ones, min_tens; // 스톱워치 카운터의 분 단위 출력
    wire [3:0] hour_ones, hour_tens; // 스톱워치 카운터의 시 단위 출력

    wire [1:0] scan_count; // 디스플레이 스캔 카운트
    wire [3:0] select_digit; // 현재 디스플레이할 BCD 숫자

    wire start_stop_clean, reset_clean; // 디바운싱된 버튼 신호

    // 100MHz 클럭을 10Hz로 분주하는 모듈 인스턴스화
    clock_divider_10Hz u1(
        .clk(clk),
        .reset_p(reset_p),   // 시스템 리셋을 클럭 분주기에 적용
        .clk_10Hz(clk_10Hz)
    );

    // btn_start_stop 버튼 디바운싱 모듈 인스턴스화
    debounce du1(
        .clk(clk),
        .btn_in(btn_start_stop),
        .btn_out(start_stop_clean)
    );

    // btn_reset 버튼 디바운싱 모듈 인스턴스화
    debounce du2(
        .clk(clk),
        .btn_in(btn_reset), // 최상위 모듈의 btn_reset 입력 사용
        .btn_out(reset_clean)
    );

    // 스톱워치 카운터 모듈 인스턴스화
    stopwatch_counter u2(
        .clk_10Hz(clk_10Hz),
        .reset_p(reset_p),
        .btn_start_stop(start_stop_clean), // 디바운싱된 시작/일시정지 버튼 연결
        .btn_reset(reset_clean),    // 디바운싱된 초기화 버튼 연결
        .sec_ones(sec_ones),
        .sec_tens(sec_tens),
        .min_ones(min_ones),
        .min_tens(min_tens),
        .hour_ones(hour_ones),
        .hour_tens(hour_tens)
    );

    wire scan_clk;
    // 100MHz 클럭을 2KHz로 분주하는 모듈 인스턴스화 (7세그먼트 스캔용)
    clock_divider_2KHz u3(
        .clk(clk),
        .reset_p(reset_p),   // 시스템 리셋을 2KHz 클럭 분주기에 적용
        .clk_2KHz(scan_clk)
    );
    
    // 디스플레이 스캔 컨트롤러 모듈 인스턴스화 (FND용)
    display_scan_controller u4(
        .scan_clk(scan_clk),
        .reset_p(reset_p),   // 시스템 리셋을 디스플레이 스캔 컨트롤러에 적용
        .hour_ones(hour_ones),
        .hour_tens(hour_tens),
        .min_ones(min_ones),
        .min_tens(min_tens),
        .scan_count(scan_count),
        .select_digit(select_digit)
    );

    // 7세그먼트 디코더 및 애노드 셀렉터 통합 모듈 인스턴스화 (FND용)
    anode_selector_wdp u7(
        .scan_count(scan_count),
        .digit_in(select_digit),
        .an_out(an),
        .seg_out(seg)
    );

    // 초의 1의 자리를 LED로 표시하는 드라이버 인스턴스화
    sec_ones_led_driver u_sec_ones_led(
        .sec_ones_in(sec_ones),
        .reset_p(reset_p),
        .enable(u2.current_state == u2.RUNNING), // 스톱워치가 RUNNING 상태일 때만 LED 활성화
        .sec_ones_led_out(sec_ones_led)
    );

    // 초의 10의 자리를 LED로 표시하는 드라이버 인스턴스화
    sec_tens_led_driver u_sec_tens_led(
        .sec_tens_in(sec_tens),
        .reset_p(reset_p),
        .enable(u2.current_state == u2.RUNNING), // 스톱워치가 RUNNING 상태일 때만 LED 활성화
        .sec_tens_led_out(sec_tens_led)
    );

    // 참고: 제공된 edge_detector_n, edge_detector_p, ring_counter, ring_counter_shift,
    // ring_counter_fnd, ring_counter_led 모듈은 현재 LED 표시 로직에 직접 사용되지 않습니다.
    // LED 표시는 BCD 값을 원-핫 형태로 변환하는 드라이버를 통해 구현되었습니다.
    // 이는 교수님께서 말씀하신 "링카운터"의 개념을 LED가 순차적으로 켜지는 방식으로 해석한 것입니다.

endmodule

// 다음 아이디어는 진짜 손목시계 처럼 구상해보기
// 자체 seg -> hh:mm 구성, 특정 버튼 누를시 ss:ms 토글 전환
// 로컬 날짜, 시간 동기화. 타이머 기능 추가