`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/11/2025 11:23:59 AM
// Design Name: 
// Module Name: test_top
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


module ring_counter_led_top(
    input clk, reset_p,     // FPGA 보드에서 제공되는 주 클럭 신호
                            // 회로를 초기화 하는 리셋 신호
    output reg [15:0] led   // 16개의 LED를 제어하는 16비트 출력
    );
    
    reg [20:0] clk_div;     // 21비트 너비의 레지스터 선언. 클락을 하는 카운터 역할
    always @(posedge clk)clk_div = clk_div + 1; // clk의 상승 엣지마다 아래 코드 실행
                                                // clk의 상승 엣지마다 clk_div 값을 1씩 증가(클럭 분주기)
    always @(posedge clk_div[20] or posedge reset_p)begin
        // always블록은 reset_p의 상승 엣지 또는 clk_div[20]의
        // 상승 엣지에서만 동작함. 즉 매우느린 clk_div[20]에 맞게 바뀜

        if(reset_p)led = 16'b0000_0000_0000_0001;
        // reset_p가 활성화되면 모든 led를 끄고 첫번째led(가장 오른쪽 비트)만 켬

        else led = {led[14:0], led[15]};
        // 리셋이 아닌경우 led값을 순환 쉬프트함.

    end
    
endmodule

module ring_counter_led_edge_detector_p(
    input clk,
    input reset_p,
    
    output reg [15:0] led
    
    );

    reg [20:0] clk_div;
    always @(posedge clk)clk_div = clk_div + 1;
    wire clk_div_18;    
    edge_detector_p clk_div_edge(
        .clk(clk), .reset_p(reset_p), .cp(clk_div[18]),
        .p_edge(clk_div_18)
    );

    always @(posedge clk or posedge reset_p) begin
        if(reset_p)led = 16'b0000_0000_0000_0001;
        // reset_p가 활성화되면 모든 led를 끄고 첫번째led(가장 오른쪽 비트)만 켬

        else led = {led[14:0], led[15]};
    end
endmodule

module watch (
    input clk, reset_p,
    input btn_mode, inc_sec, inc_min,

    output reg [7:0] sec, min,
    output reg set_watch
    );

    always @(posedge clk, posedge reset_p) begin
        if (reset_p) begin
            set_watch = 0;
        end
        else if(btn_mode) begin
            set_watch = ~set_watch;
        end
    end

    reg [26:0] cnt_sysclk;
    // reg [5:0] sec, min;  // 있어야하나?
    always @(posedge clk, posedge reset_p) begin
        if(reset_p)begin
            cnt_sysclk = 0; // 1? 0?
            sec = 0;
            min = 0;
        end
        else begin
            if (set_watch) begin
                if(inc_sec) begin
                    if (sec >= 59) begin
                        sec = 0;
                    end 
                    else begin
                        sec = sec + 1;
                    end 
                end
                if (inc_min) begin
                    if(inc_min >= 59) begin
                        min = 0;
                    end 
                    else begin
                        min = min + 1;
                    end 
                end    
            end 
            else begin
                if(cnt_sysclk >= 27'd99_999_999)begin
                    cnt_sysclk = 0;
                    if(sec >= 59) begin
                        sec = 0;
                        if(min >= 59) begin
                            min = 0;
                        end 
                        else begin
                            min = min + 1;
                        end 
                    end
                    else begin
                        sec = sec + 1;
                    end 
                end
                else begin
                    cnt_sysclk = cnt_sysclk + 1;
                end 
            end    
        end
    end
    
endmodule

module watch_top_before_modfied(
    input clk, reset_p,
    input [2:0] btn,

    output [7:0] seg_7,
    output [3:0] com,
    output [15:0] led
    );
    
    wire btn_mode, inc_sec, inc_min;
    
    btn_cntr mode_btn(
        .clk(clk), .reset_p(reset_p), .btn(btn[0]), .btn_pedge(btn_mode));
    btn_cntr inc_sec__btn(
        .clk(clk), .reset_p(reset_p), .btn(btn[1]), .btn_pedge(inc_sec));
    btn_cntr inc_min_btn(
        .clk(clk), .reset_p(reset_p), .btn(btn[2]), .btn_pedge(inc_min));
        
    reg set_watch;
    assign led[0] = set_watch;
    always @(posedge clk, posedge reset_p)begin
        if(reset_p)begin
            set_watch = 0;
        end
        else if(btn_mode)begin
            set_watch = ~set_watch;
        end
    end

    reg [26:0] cnt_sysclk;
    reg [7:0] sec, min;
    always @(posedge clk, posedge reset_p)begin
        if(reset_p)begin
            cnt_sysclk = 0;
            sec = 0;
            min = 0;
        end
        else begin
            if(set_watch)begin
                if(inc_sec)begin
                    if(sec >= 59)sec = 0;
                    else sec = sec + 1;
                end
                if(inc_min)begin
                    if(min >= 59)min = 0;
                    else min = min + 1;
                end
            end
            else begin
                if(cnt_sysclk >= 27'd99_999_999)begin
                    cnt_sysclk = 0;
                    if(sec >= 59)begin
                        sec = 0;
                        if(min >= 59) begin
                            min = 0;
                        end 
                        else begin
                            min = min + 1;
                        end 
                    end
                    else sec = sec + 1;
                end
                else begin
                    cnt_sysclk = cnt_sysclk + 1;
                end 
            end
        end
    end
    wire [15:0] sec_bcd, min_bcd;
    bin_to_dec bcd_sec(.bin(sec), .bcd(sec_bcd));
    bin_to_dec bcd_min(.bin(min), .bcd(min_bcd));
    fnd_cntr fnd(.clk(clk), .reset_p(reset_p),
        .fnd_value({min_bcd[7:0], sec_bcd[7:0]}), .hex_bcd(1),
        .seg_7(seg_7), .com(com));

endmodule


module watch_top (
    input clk, reset_p,
    input [2:0] btn,

    output [7:0] seg_7,
    output [3:0] com,
    output [15:0] led
);

    // wire [2:0] debounce_btn;
    wire btn_mode, inc_sec, inc_min;    // 벡터보단 구별이 편함
    wire [7:0] sec, min;
    wire set_watch;
    wire [15:0] sec_bcd, min_bcd;
    assign led[0] = set_watch;

//     debounce btn_0(
//     .clk(clk),
//     .btn_in(btn[0]),
//     .btn_out(btn_mode)
// );

//     debounce btn_1(
//     .clk(clk),
//     .btn_in(btn[1]),
//     .btn_out(inc_sec)
// );

//     debounce btn_2(
//     .clk(clk),
//     .btn_in(btn[2]),
//     .btn_out(inc_min)
// );

    btn_cntr mode_btn(
    .clk(clk), 
    .reset_p(reset_p),
    .btn(btn[0]),
    .btn_pedge(btn_mode)
);
    btn_cntr inc_sec_btn(
    .clk(clk), 
    .reset_p(reset_p),
    .btn(btn[1]),
    .btn_pedge(inc_sec)
);
    btn_cntr inc_min_btn(
    .clk(clk), 
    .reset_p(reset_p),
    .btn(btn[2]),
    .btn_pedge(inc_min)
);

    // wire mode_btn_pedge;
    // edge_detector_p mode_ed(
    //     .clk(clk), 
    //     .reset_p(reset_p),
    //     .cp(btn_mode), 
    //     .p_edge(mode_btn_pedge)
    // );
    // edge_detector_p inc_sec_ed(
    //     .clk(clk), 
    //     .reset_p(reset_p),
    //     .cp(inc_sec), 
    //     .p_edge(inc_sec_pedge)
    // );
    // edge_detector_p inc_min_ed(
    //     .clk(clk), 
    //     .reset_p(reset_p),
    //     .cp(inc_min), 
    //     .p_edge(inc_min_edge)
    // );

    // always @(posedge clk, posedge reset_p) begin
    //     if (reset_p) begin
    //         set_watch = 0;
    //     end
    //     else if(btn_mode)begin
    //         set_watch = ~set_watch;
    //     end
    // end

    // reg [26:0] cnt_sysclk;
    // reg [7:0] sec, min;
    // always @(posedge clk, posedge reset_p) begin
    //     if(reset_p)begin
    //         cnt_sysclk = 0;
    //         sec = 0;
    //         min = 0;
    //     end
    //     else begin
    //         if (set_watch) begin
    //             if(inc_sec) begin
    //                 if (sec >= 59)sec = 0;
    //                 else sec = sec + 1;
    //         end
    //         if (inc_min) begin
    //             if(inc_min >= 59)min = 0;
    //             else min = min + 1;
    //         end    
    //     end 
    //     else begin
    //         if(cnt_sysclk >= 27'd99_999_999)begin
    //             cnt_sysclk = 0;
    //             if(sec >= 59)begin
    //                 sec = 0;
    //                 if(min >= 59)min = 0;
    //                 else min = min + 1;
    //             end
    //             else sec = sec + 1;
    //         end
    //         else cnt_sysclk = cnt_sysclk + 1;
    //         end    
    //     end
    // end

    // always문 대체하고 watch를 instance화
    watch watch_instance (
        .clk(clk), 
        .reset_p(reset_p),
        .btn_mode(btn_mode), 
        .inc_sec(inc_sec), 
        .inc_min(inc_min),
        .sec(sec), 
        .min(min), 
        .set_watch(set_watch)
        );

    bin_to_dec bcd_sec(.bin(sec), .bcd(sec_bcd));
    bin_to_dec bcd_min(.bin(min), .bcd(min_bcd));

    fnd_cntr fnd(.clk(clk), .reset_p(reset_p),
    .fnd_value({min_bcd[7:0], sec_bcd[7:0]}), .hex_bcd(1),
    .seg_7(seg_7), .com(com));

endmodule


module cook_timer (
    input clk, reset_p,
    input btn_mode, inc_sec, inc_min, alarm_off,

    output reg [7:0] sec, min,
    output reg alarm,
    output reg start_set
);

    reg set_flag;
    reg [7:0] set_sec, set_min;
    reg [26:0] cnt_sysclk = 0;
    wire [15:0] cur_time = {min, sec};

    always @(posedge clk, posedge reset_p) begin
        if(reset_p) begin
            start_set = 0;
            alarm = 0;
        end
        else if(btn_mode && cur_time != 0 && start_set == 0)begin
            start_set = 1;
            set_sec = sec;
            set_min = min;
        end
        else if (start_set && btn_mode) begin
            start_set = 0;
        end
        else if (start_set && min == 0 && sec == 0) begin
            start_set = 0;
            alarm = 1;
        end
        else if (alarm && (alarm_off || inc_sec || inc_min || btn_mode)) begin
            alarm = 0;
            set_flag = 1;
        end
        else if (cur_time != 0) begin
            set_flag = 0;
        end
    end 
    
    // assign cur_time = {min, sec}; // 영상설명 다시보기
    always @(posedge clk, posedge reset_p) begin
        if(reset_p)begin
            cnt_sysclk = 0;
            sec = 0;
            min = 0;
        end
        else begin
            if (start_set) begin
                if (cnt_sysclk >= 99_999_999) begin // Q) -1 하는 이유?
                    cnt_sysclk = 0;
                    if (sec == 0) begin
                        if (min) begin
                            sec = 59;
                            min = min - 1;
                        end
                    end
                    else begin
                        sec = sec - 1;
                    end 
                end
                else begin
                    cnt_sysclk = cnt_sysclk + 1;
                end 
            end
            else begin
                if (inc_sec) begin
                    if (sec >= 59) begin
                        sec = 0;
                    end
                    else begin
                        sec = sec + 1;
                    end
                end
                else if (inc_min) begin
                    if (min >= 99) begin
                        min = 0;
                    end
                    else begin
                        min = min + 1;
                    end
                end
                if (set_flag) begin
                    sec = set_sec;
                    min = set_min;
                end
            end
        end
    end
endmodule


module cook_timer_top (
    input clk, reset_p,
    input [3:0] btn,
    output [7:0] seg_7,
    output [3:0] com,
    output alarm,   // reg안써도됨?
    output [15:0] led   // 디버깅용 led
);
    wire start_set;
    
    assign led[0] = start_set;
    assign led[15] = alarm;

    wire [7:0] sec, min;

    wire btn_mode, inc_sec, inc_min, alarm_off;
    wire [7:0] sec_bcd, min_bcd;

    btn_cntr mode_btn(
        .clk(clk), 
        .reset_p(reset_p),
        .btn(btn[0]),
        .btn_pedge(btn_mode)
    );

    btn_cntr inc_sec_btn(
        .clk(clk), 
        .reset_p(reset_p),
        .btn(btn[1]),
        .btn_pedge(inc_sec)
    );

    btn_cntr inc_min_btn(
        .clk(clk), 
        .reset_p(reset_p),
        .btn(btn[2]),
        .btn_pedge(inc_min)
    );

    btn_cntr alarm_off_btn(
        .clk(clk),
        .reset_p(reset_p),
        .btn(btn[3]),
        .btn_pedge(alarm_off)
    );
    
    cook_timer cook_timer_instance(
    .clk(clk), 
    .reset_p(reset_p),
    .btn_mode(btn_mode),
    .inc_sec(inc_sec),
    .inc_min(inc_min),
    .alarm_off(alarm_off),
    .sec(sec),
    .min(min),
    .alarm(alarm),
    .start_set(start_set)
    );

    bin_to_dec bcd_sec(.bin(sec), .bcd(sec_bcd));
    bin_to_dec bcd_min(.bin(min), .bcd(min_bcd));

    fnd_cntr fnd(.clk(clk), .reset_p(reset_p),
    .fnd_value({min_bcd[7:0], sec_bcd[7:0]}), .hex_bcd(1),
    .seg_7(seg_7), .com(com));


endmodule


module stop_watch (
    input clk, reset_p,
    input btn_start, btn_lap, btn_clear,

    output [7:0] fnd_sec, fnd_csec,
    output reg lap, start_stop
);
    
    always @(posedge clk, posedge reset_p) begin
        if (reset_p) begin
            start_stop = 0;
        end
        else if (btn_start) begin // 플립플롭?
            start_stop = ~start_stop;
        end
        else if (btn_clear) begin
            start_stop = 0;
        end
    end

    reg [7:0] sec, csec;
    reg [7:0] lap_sec, lap_csec;

    always @(posedge clk, posedge reset_p) begin
        if (reset_p) begin
            lap = 0;
            lap_sec = 0;
            lap_csec = 0;
        end
        else if (btn_lap) begin // 플립플롭?
            lap = ~lap;
            lap_sec = sec;
            lap_csec = csec;
        end
        else if (btn_clear) begin
            lap = 0;
            lap_sec = 0;
            lap_csec = 0;
        end
    end

    reg [26:0] cnt_sysclk; // = 0; // reg타입일때 =0은 시뮬레이션 할때 0 준것
    always @(posedge clk, posedge reset_p) begin
        if (reset_p) begin
            sec = 0;
            csec = 0;
            cnt_sysclk = 0;
        end
        else begin
            if (start_stop) begin
                if (cnt_sysclk >= 999_999) begin // 이숫자가 왜 100분의 1초이고 왜 이숫자씀?
                    cnt_sysclk = 0;
                    if (csec >= 99) begin
                        csec = 0;
                        if (sec >= 99) begin // 스탑워치니까 99까지만한다
                            sec = 0;
                        end
                        else begin
                            sec = sec + 1;
                        end
                    end
                    else begin
                        csec = csec + 1;
                    end
                end
                else begin
                    cnt_sysclk = cnt_sysclk + 1;
                end
            end
            if (btn_clear) begin
                sec = 0;
                csec = 0;
                cnt_sysclk = 0;
            end
        end
    end
    assign fnd_sec = lap ? lap_sec : sec;
    assign fnd_csec = lap ? lap_csec : csec;
endmodule

module stop_watch_top (
    input clk, 
    input reset_p,
    input [2:0] btn,

    output [7:0] seg_7,
    output [3:0] com,
    output [15:0] led
);

    wire btn_start, btn_lap, btn_clear;
    wire [7:0] fnd_sec, fnd_csec;
    wire lap, start_stop;

    assign led[0] = start_stop;
    assign led[1] = lap;

    btn_cntr start_btn(
        .clk(clk), 
        .reset_p(reset_p),
        .btn(btn[0]),
        .btn_pedge(btn_start)
    );

    btn_cntr lap_btn(
        .clk(clk), 
        .reset_p(reset_p),
        .btn(btn[1]),
        .btn_pedge(btn_lap)
    );

    btn_cntr clear_btn(
        .clk(clk), 
        .reset_p(reset_p),
        .btn(btn[2]),
        .btn_pedge(btn_clear)
    );

    stop_watch stop_watch_instance(
        .clk(clk),
        .reset_p(reset_p),
        .btn_start(btn_start),
        .btn_lap(btn_lap),
        .btn_clear(btn_clear),
        .lap(lap),
        .start_stop(start_stop)
    );

    wire [7:0] fnd_sec, fnd_csec;               // 이거 wire, assign문 3줄 왜 쓴거지?

    bin_to_dec bcd_sec(
        .bin(fnd_sec), 
        .bcd(sec_bcd)
        );
    bin_to_dec bcd_csec(
        .bin(fnd_csec), 
        .bcd(csec_bcd)
        );

    fnd_cntr fnd(
        .clk(clk), 
        .reset_p(reset_p),
        .fnd_value({sec_bcd, csec_bcd}), 
        .hex_bcd(1),  // 이러게해도되는 이유? 상위 비트가 0이라서?
        .seg_7(seg_7), 
        .com(com)
        );
    
endmodule


module multifunction_watch_top (
    input clk, reset_p,
    input [3:0] btn,
    input alarm_off,    // 슬라이드 스위치

    output [7:0] seg_7,
    output [3:0] com,
    output alarm,       // 알람출력
    output [15:0] led
);

    localparam WATCH = 0;   // 전처리기 기능. define, 가독성 올려주기
    localparam COOK_TIMER = 1;
    localparam STOP_WATCH = 2;

    reg [1:0] mode;
    assign led[1:0] = mode;
    assign led[15] = alarm;
    wire btn_mode;
    btn_cntr mode_btn (
        .clk(clk), 
        .reset_p(reset_p), 
        .btn(btn[0]), 
        .btn_pedge(btn_mode)
    );
    always @(posedge clk, posedge reset_p) begin
        if (reset_p) begin
            mode = WATCH;
        end
        else if (btn_mode) begin
            if (mode == WATCH) begin
                mode = COOK_TIMER;
            end
            else if (mode == COOK_TIMER) begin
                mode = STOP_WATCH;
            end
            else if (mode == STOP_WATCH) begin
                mode = WATCH;
            end
        end
    end

    reg [2:0] watch_btn, cook_btn, stop_btn;
    wire [7:0] watch_seg_7, cook_seg_7, stop_seg_7;
    wire [3:0] watch_com, cook_com, stop_com;
    always @(*) begin
        case (mode)
           WATCH : begin
            watch_btn = btn[3:1];
            cook_btn = 0;
            stop_btn = 0;
           end
           COOK_TIMER : begin
            watch_btn = 0;
            cook_btn = btn[3:1];
            stop_btn = 0;
           end
           STOP_WATCH : begin
            watch_btn = 0;
            cook_btn = 0;
            stop_btn = btn[3:1];
           end 
        endcase
    end

    watch_top watch(
        .clk(clk),
        .reset_p(reset_p),
        .btn(watch_btn),
        .seg_7(watch_seg_7),
        .com(watch_com)
    );

    // wire alarm; 출력으로 만들어야하기 때문에 wire는 부적절
    cook_timer_top timer(
        .clk(clk), 
        .reset_p(reset_p),
        .btn({alarm_off, cook_btn}),
        .seg_7(cook_seg_7),
        .com(cook_com),
        .alarm(alarm)
    );

    stop_watch_top stop(
        .clk(clk), 
        .reset_p(reset_p),
        .btn(stop_btn),
        .seg_7(stop_seg_7),
        .com(stop_com)
    );

    // fnd출력
    assign seg_7 = mode == WATCH ? watch_seg_7 : 
                   mode == COOK_TIMER ? cook_seg_7 :
                   mode == STOP_WATCH ? stop_seg_7 : watch_seg_7;
    assign com = mode == WATCH ? watch_com : 
                 mode == COOK_TIMER ? cook_com :
                 mode == STOP_WATCH ? stop_com : watch_com;

endmodule


module multifunction_watch_top_v2 (
    input clk, reset_p,
    input [3:0] btn,
    input alarm_off,    // 슬라이드 스위치

    output [7:0] seg_7,
    output [3:0] com,
    output alarm,       // 알람출력
    output [15:0] led
);

    localparam WATCH = 0;   // 전처리기 기능. define, 가독성 올려주기
    localparam COOK_TIMER = 1;
    localparam STOP_WATCH = 2;

    reg [1:0] mode;
    assign led[1:0] = mode;
    assign led[15] = alarm;
    wire btn_mode;
    btn_cntr mode_btn (
        .clk(clk), 
        .reset_p(reset_p), 
        .btn(btn[0]), 
        .btn_pedge(btn_mode)
    );

    always @(posedge clk, posedge reset_p) begin
        if (reset_p) begin
            mode = WATCH;
        end
        else if (btn_mode) begin
            if (mode == WATCH) begin
                mode = COOK_TIMER;
            end
            else if (mode == COOK_TIMER) begin
                mode = STOP_WATCH;
            end
            else if (mode == STOP_WATCH) begin
                mode = WATCH;
            end
        end
    end
    wire [2:0] debounced_btn_pedge;
    btn_cntr mode_btn1(
        .clk(clk),
        .reset_p(reset_p),
        .btn(btn[1]),
        .btn_pedge(debounced_btn_pedge[0])
    );
    btn_cntr mode_btn2(
        .clk(clk),
        .reset_p(reset_p),
        .btn(btn[2]),
        .btn_pedge(debounced_btn_pedge[1])
    );
    btn_cntr mode_btn3(
        .clk(clk),
        .reset_p(reset_p),
        .btn(btn[3]),
        .btn_pedge(debounced_btn_pedge[2])
    );

    reg [2:0] watch_btn, cook_btn, stop_btn;
    always @(*) begin
        case (mode)
            WATCH : begin
                watch_btn = debounced_btn_pedge;
                cook_btn = 0;
                stop_btn = 0;
            end
            COOK_TIMER : begin
                watch_btn = 0;
                cook_btn = debounced_btn_pedge;
                stop_btn = 0;
            end
            STOP_WATCH : begin
                watch_btn = 0;
                cook_btn = 0;
                stop_btn = debounced_btn_pedge;
            end 
        endcase
    end
    wire [7:0] watch_sec, watch_min, cook_sec, cook_min, stop_sec, stop_csec;
    wire set_watch;
    assign led[4] = set_watch;
    watch watch_instance(
        .clk(clk),
        .reset_p(reset_p),
        .btn_mode(watch_btn[0]),
        .inc_sec(watch_btn[1]),
        .inc_min(watch_btn[2]),
        .sec(watch_sec),
        .min(watch_min),
        .set_watch(set_watch)
    );

    wire start_set;
    assign led[6] = start_set;
    // wire alarm; 출력으로 만들어야하기 때문에 wire는 부적절
    cook_timer_ cook_timer_instance(
        .clk(clk), 
        .reset_p(reset_p),
        .btn_mode(cook_btn[0]), 
        .inc_sec(cook_btn[1]), 
        .inc_min(cook_btn[2]), 
        .alarm_off(alarm_off),
        .sec(cook_sec), 
        .min(cook_min),
        .alarm(alarm), 
        .start_set(start_set)
        );

    wire lap, start_stop;
    assign led[8] = start_stop;
    assign led[9] = lap;     

    stop_watch stop_watch_instance(
        .clk(clk), 
        .reset_p(reset_p),
        .btn_start(stop_btn[0]), 
        .btn_lap(stop_btn[1]), 
        .btn_clear(stop_btn[2]),
        .fnd_sec(stop_sec), 
        .fnd_csec(stop_csec),
        .lap(lap), 
        .start_stop(start_stop)
        );

    // fnd출력
    wire [7:0] bin_low, bin_high;
    wire [7:0] fnd_value_low, fnd_value_high;
    wire [15:0]fnd_value = {fnd_value_high, fnd_value_low}; 
    assign bin_low = mode == WATCH ? watch_sec :
                   mode == COOK_TIMER ? cook_sec :
                   mode == STOP_WATCH ? stop_csec : watch_sec;             
    assign bin_high = mode == WATCH ? watch_min :
                   mode == COOK_TIMER ? cook_min :
                   mode == STOP_WATCH ? stop_sec : watch_min;
    
    bin_to_dec bcd_low(
        .bin(bin_low), 
        .bcd(fnd_value_low)
        );
    bin_to_dec bcd_high(
        .bin(bin_high), 
        .bcd(fnd_value_high)
        );   
    fnd_cntr fnd(
        .clk(clk), 
        .reset_p(reset_p),
        .fnd_value(fnd_value),
        .hex_bcd(1),
        .seg_7(seg_7), .com(com));

endmodule

module dht11_top (
    input clk, reset_p,
    inout dht11_data,
    output [7:0] seg_7,
    output [3:0] com,
    output [15:0] led
);
    wire [7:0] humidity, temperature;

    dht11_cntr dht11(        
        clk,
        reset_p,
        dht11_data,   
        humidity, 
        temperature,
        led
        );

    wire [7:0] humi_bcd, tmpr_bcd;
    bin_to_dec bcd_sec(.bin(humidity), .bcd(humi_bcd));
    bin_to_dec bcd_csec(.bin(temperature), .bcd(tmpr_bcd));

    fnd_cntr fnd(
        .clk(clk), 
        .reset_p(reset_p),
        .fnd_value({humi_bcd, tmpr_bcd}), 
        .hex_bcd(1),
        .seg_7(seg_7), 
        .com(com));
    
endmodule