`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/21/2025 10:50:27 AM
// Design Name: 
// Module Name: T_flip_flop
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


module sr_latch(

    input s,
    input r,
    output q,
    output q_bar
    );

    nor (q, r, q_bar);
    nor (q_bar, s, q);

endmodule


module T_flip_flop_n (
    input clk,
    input reset_p,
    input t,
    output reg q
);

    always @(negedge clk or posedge reset_p) begin
        if(reset_p) begin
            q <= 1'b0;          // 논블로킹 할당 ( 블로킹 q = 0 ,,, q = 1b0 )
        end
        else begin
            if(t == 1'b1) begin
                q <= ~q;
            end 
            else begin
                q <= q;
            end
        end
    end

endmodule


module T_flip_flop_p (
    input clk, reset_p,
    input t,
    output reg q
);

    always @(posedge clk, posedge reset_p) begin
        if(reset_p) q = 0;
        else begin
            if(t) q = ~q;
            else q = q;
        end
        
    end
    
endmodule


// 비동기 업카운터
// T-flipflop을 4개 직렬로 연결
// 가장 오른쪽 비트부터 차례로 다음단계의 클럭으로 사용
// reset_p -> 1 되면 q 출력을 0으로
module up_counter_asyc (
    input clk,      // 외부클럭
    input reset_p,  // 비동기 리셋
    output [3:0] count
);
    T_flip_flop_n T0(
        .clk(clk),
        .reset_p(reset_p),
        .t(1'b1),           // 항상 토글
        .q(count[0])
    );
    T_flip_flop_n T1(
        .clk(count[0]),
        .reset_p(reset_p),
        .t(1'b1),
        .q(count[1])
    );
    T_flip_flop_n T2(
        .clk(count[1]),
        .reset_p(reset_p),
        .t(1'b1),
        .q(count[2])
    );
    T_flip_flop_n T3(
        .clk(count[2]),
        .reset_p(reset_p),
        .t(1'b1),
        .q(count[3])
    );
endmodule


module down_counter_asyc (
    input clk,
    input reset_p,
    output [3:0] count
);

    T_flip_flop_p T0(
        .clk(clk),
        .reset_p(reset_p),
        .t(1),
        .q(count[0])
    );
    T_flip_flop_p T1(
        .clk(count[0]),
        .reset_p(reset_p),
        .t(1),
        .q(count[1])
    );
    T_flip_flop_p T2(
        .clk(count[1]),
        .reset_p(reset_p),
        .t(1),
        .q(count[2])
    );
    T_flip_flop_p T3(
        .clk(count[2]),
        .reset_p(reset_p),
        .t(1),
        .q(count[3])
    );
    
endmodule


module up_counter_p (
    input clk,
    input reset_p,
    input enable,       // 카운터 동작을 제어

    output reg [3:0] count
);
    always @(posedge clk or posedge reset_p) begin
        if (reset_p)
            count <= 0;
        else if (enable)
            count <= count + 1;  // enable이 1 일 때만 count 증가
    
    end
    
endmodule


module down_counter_p (
    input clk,
    input reset_p,
    input enable,       // 카운터 동작을 제어

    output reg [3:0] count
);
    always @(posedge clk or posedge reset_p) begin
        if (reset_p)
            count <= 4'b1111; // 리셋 시 최대값(4비트 기준 15)으로 초기화
        else if (enable)
            count <= count - 1;  // enable이 1일 때만 count 감소
    end
    
endmodule


module test_top (
    
    input clk,
    input btnU,     // upcounte reset
    input btnD,     // enable

    output [3:0] led
);
    
    wire [3:0] up_count;

    up_counter_p U1(
        .clk(clk),
        .reset_p(btnU),
        .enable(btnD),
        .count(up_count)
    );

    assign led = up_count;
    

endmodule


// module edge_dectector_n (
//     input clk,      // 클럭
//     input reset_p,  // 리셋
//     input cp,       // 입력신호 감지
//     // output p_edge,  // 라이징 감지 출력
//     output n_edge   // 폴링 감지 출력
// );

//     reg ff_cur, ff_old; // 현재 cp 값과 이전 cp값을 저장할 플립플롭

//     always @(negedge clk or posedge reset_p) begin
//         if(reset_p)begin    // 리셋시 플립플롭 초기화
//             ff_cur <= 0;
//             ff_old <= 0;
//         end
//         else begin          // 이전값 저장하고 현재값 갱신
//             ff_old <= ff_cur;
//             ff_cur <= cp;
//         end
//     end
    
//     // 라이징 감지 : 이전 0, 현재 1이면 2'b10
//     // assign p_edge = ({ff_cur, ff_old} == 2'b10) ? 1 : 0;
//     // 폴링 감지 : 이전 1, 현재 0이면 2'b01
//     assign n_edge = ({ff_cur, ff_old} == 2'b01) ? 1 : 0;
  
    
// endmodule


// // 시스템 클럭이 100MHz
// // 일단 100 분주
// module clock_div_100 (
//     input clk,  // system clock 100MHz
//     input reset_p,
//     output clk_div_100, // 1MHz 펄스 출력
//     output cp_div_100
// );

//     reg [6:0] cnt_sysclk;

//     always @(negedge clk or posedge reset_p) begin
//         if(reset_p)
//             cnt_sysclk <= 1;
//         else begin
//             if(cnt_sysclk >=99)
//                 cnt_sysclk <= 0;
//             else
//                 cnt_sysclk <= cnt_sysclk + 1;
//         end        
//     end
    
//     assign cp_div_100 = (cnt_sysclk < 50) ? 0 : 1;

//     edge_dectector_n ed(
//         .clk(clk),
//         .reset_p(reset_p),
//         .cp(cp_div_100),
//         .n_edge(clk_div_100)
//     );

// endmodule


// // 1000 분주
// module clock_div_1000 (
//     input clk,
//     input reset_p,
//     output clk_div_1000

// );

//     reg [9:0] count;        // 10bit 0 ~ 9999
//     reg pulse;

//     always @(posedge clk or posedge reset_p) begin
//         if(reset_p) begin
//             count <= 0;
//             pulse <= 0;
//         end
//         else begin
//             if (count == 999) begin
//                 count <= 0;
//                 pulse <= 1;
//             end
//             else begin
//                 count <= count + 1;
//                 pulse <= 0;
//             end
//         end
//     end

//     assign clock_div_1000;

// endmodule


// module clock_div_1hz_top (
//     input clk,
//     input reset_p,
//     output clk_1hz
// );
//     wire clk_1mhz;      // 100MHz -> 1Mhz
//     wire clk_1khz;      // 1Mhz -> 1khz

//     // 1단 분주 : 100 분주 (100Mhz -> 1Mhz)
//     clock_div_100 U1(
//         .clk(clk),
//         .reset_p(reset_p),
//         .clk_div_100(clk_1mhz),
//         .cp_div_100()           // 사용안함
//     );
    
//     // 2단 분주 : 1000분주 (1Mhz -> 1Khz)
//     clock_div_1000 U2(
//         .clk(clk_1mhz),
//         .reset_p(reset_p),
//         .clock_div_1000(clk_1khz)
//     );

//     // 3단 분주 : 1000분주 (1khz -> 1hz)
//     clock_div_1000 U3(
//         .clk(clk_1khz),
//         .reset_p(reset_p),
//         .clock_div_1000(clk_1hz)
//     );

// endmodule


// module led_top (
//     input clk,
//     input btnU,
//     output reg led
// );
//     wire clk_1hz;

//     clock_div_1hz_top div_instance(
//         .clk(clk),
//         .reset_p(reset_p),
//         .clk_1hz(clk_1hz)
//     );

//     always @(posedge clk_1hz or posedge btnU) begin
//         if(btnU)
//             led <= 0;
//         else
//             led <= ~led;
//     end
// endmodule


module edge_detector_n (
    input clk, reset_p,     // 클럭, 리셋 
    input cp,               // 입력신호 감지
    // output p_edge, 
    output n_edge   // 라이징 감지 출력, 폴링 감지 출력
);
    reg ff_cur, ff_old;     // 현재 cp값과 이전 cp값을 저장할 플립플롭

    always @(negedge clk, posedge reset_p) begin
        if(reset_p) begin   //리셋시 플립플롭 초기화
            ff_cur <= 0;
            ff_old <= 0;
        end
        else begin          // 이전값 저장하고 현재값 갱신
            ff_old <= ff_cur;
            ff_cur <= cp;
        end
    end
    
    // 라이징 감지 : 이전 0, 현재 1이면 2'b10
    //assign p_edge = ({ff_cur, ff_old} == 2'b10) ? 1 : 0;
    
    // 폴링 감지 : 이전 1, 현재 0이면 2'b01
    assign n_edge = ({ff_cur, ff_old} == 2'b01) ? 1 : 0;
endmodule



// 시스템 클럭이 100MHz
// 일단 100 분주
module clock_div_100 (
    input clk,  // system clock 100MHz
    input reset_p,
    output clk_div_100, // 1MHz 펄스 출력
    output cp_div_100
);

    reg [6:0] cnt_sysclk;

    always @(negedge clk or posedge reset_p) begin
        if(reset_p)
            cnt_sysclk <= 1;
        else begin
            if(cnt_sysclk >=99)
                cnt_sysclk <= 0;
            else
                cnt_sysclk <= cnt_sysclk + 1;
        end        
    end
    
    assign cp_div_100 = (cnt_sysclk < 50) ? 0 : 1;

    edge_detector_n ed(
        .clk(clk),
        .reset_p(reset_p),
        .cp(cp_div_100),
        .n_edge(clk_div_100)
    );

endmodule



// 1000 분주
module clock_div_1000 (
    input clk,  // system clock 100MHz
    input reset_p,
    output clk_div_1000
);

    reg [9:0] count;
    reg pulse;

    always @(posedge clk, posedge reset_p) begin
        if(reset_p) begin
            count <= 0;
            pulse <= 0;
        end
        else begin
            if(count == 999) begin
                count <= 0;
                pulse <= 1;
            end
            else begin 
                count <= count + 1;
                pulse <= 0;
            end
        end
    end

    assign clk_div_1000 = pulse;


endmodule



module clock_div_1hz_top (
    input clk,
    input reset_p,
    output clk_1hz
);
    
    wire clk_1mhz;      // 100Mhz -> 1Mhz
    wire clk_1khz;      // 1Mhz -> 1kHz

    // 1단 분주 : 100분주 (100Mhz -> 1Mhz)
    clock_div_100 U1(
        .clk(clk),
        .reset_p(reset_p),
        .clk_div_100(clk_1mhz),
        .cp_div_100()
    );

    //2단 분주 :1000 분주 (1MHz -> 1Khz)
    clock_div_1000 U2(
        .clk(clk_1mhz),
        .reset_p(reset_p),
        .clk_div_1000(clk_1khz)
    );

    //3단 분주 :1000 분주 (1KHz -> 1hz)
    clock_div_1000 U3(
        .clk(clk_1khz),
        .reset_p(reset_p),
        .clk_div_1000(clk_1hz)
    );
endmodule




module led_top (
    input clk,
    input btnU,
    output reg led
);
    wire clk_1hz;

    clock_div_1hz_top div_instance(
        .clk(clk),
        .reset_p(btnU),
        .clk_1hz(clk_1hz)
    );

    always @(posedge clk_1hz , posedge btnU) begin
        if(btnU)
            led <= 0;
        else
            led <= ~led;
    end
    
endmodule