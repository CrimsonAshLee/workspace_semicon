`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/30/2025 10:27:47 AM
// Design Name: 
// Module Name: exam02_sequential_logic
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

module D_flip_flop_n(   
    input d,
    input clk,
    input enable,
    input reset_p,
    output reg q
    );
    
    always @(negedge clk or posedge reset_p)begin      // 레벨 트리거와 엣지는 섞어서 못쓴다. 어느것이 우선인지 정해야 한다.
        if(reset_p)begin      // 네거티브와 퍼지티브가 동시에 들어오면 리셋이 우선이다.
                q = 1'b0;
        end
        else if(enable)begin
            q = d;
        end
     end
endmodule
        

module D_flip_flop_p(   
    input d,
    input clk,
    input enable,
    input reset_p,
    output reg q
    );
    
    always @(posedge clk or posedge reset_p)begin      // 레벨 트리거와 엣지는 섞어서 못쓴다. 어느것이 우선인지 정해야 한다.
        if(!reset_p)begin      // 네거티브와 퍼지티브가 동시에 들어오면 리셋이 우선이다.
                q = 1'b0;
        end
        else if(enable)begin
            q = d;
        end
     end
endmodule

module T_flip_flop_n(
    input clk, reset_p,
    input enable,
    input t,
    output reg q
    );
    
    always @(negedge clk, posedge reset_p)begin
        if(reset_p)q = 0;
        else begin
            if(enable)begin
               if(t) q = ~q;
            end
        end
    end
    
endmodule    

module T_flip_flop_p(
    input clk, reset_p,
    input enable,
    input t,
    output reg q
    );
    
    always @(posedge clk, posedge reset_p)begin
        if(reset_p)q = 0;
        else begin
            if(enable)begin
               if(t) q = ~q;
            end
        end
    end
    
endmodule

module up_counter_asyc(
    input clk, reset_p,
    output [3:0] count
    );

    T_flip_flop_n cnt0(.clk(clk), .reset_p(reset_p), .enable(1'b1), .t(1'b1), .q(count[0]));
    T_flip_flop_n cnt1(.clk(count[0]), .reset_p(reset_p), .enable(1'b1), .t(1'b1), .q(count[1]));
    T_flip_flop_n cnt2(.clk(count[1]), .reset_p(reset_p), .enable(1'b1), .t(1'b1), .q(count[2]));
    T_flip_flop_n cnt3(.clk(count[2]), .reset_p(reset_p), .enable(1'b1), .t(1'b1), .q(count[3]));

endmodule

module down_counter_asyc(
    input clk, reset_p,
    output [3:0] count
    );

    T_flip_flop_p cnt0(.clk(clk), .reset_p(reset_p), .enable(1'b1), .t(1'b1), .q(count[0]));
    T_flip_flop_p cnt1(.clk(count[0]), .reset_p(reset_p), .enable(1'b1), .t(1'b1), .q(count[1]));
    T_flip_flop_p cnt2(.clk(count[1]), .reset_p(reset_p), .enable(1'b1), .t(1'b1), .q(count[2]));
    T_flip_flop_p cnt3(.clk(count[2]), .reset_p(reset_p), .enable(1'b1), .t(1'b1), .q(count[3]));

endmodule

module up_counter_p(
    input clk, reset_p,
    output reg [3:0] count
    );
    
    always @(posedge clk, posedge reset_p)begin
        if(reset_p)count = 0;
        else count = count + 1;
    end
    
endmodule

module up_counter_n(
    input clk, reset_p,
    output reg [3:0] count
    );
    
    always @(negedge clk, posedge reset_p)begin
        if(reset_p)count = 0;
        else count = count + 1;
    end
    
endmodule

module down_counter_p(
    input clk, reset_p,
    output reg [3:0] count
    );
    
    always @(posedge clk, posedge reset_p)begin
        if(reset_p)count = 0;
        else count = count - 1;
    end
    
endmodule

module ring_counter (
    input clk,
    input reset_p,

    output reg [3:0] q
);
    always @(posedge clk or posedge reset_p) begin
        if (reset_p) begin
            q <= 4'b0001;       // 초기값 0001 설정
        end
        else begin
            case (q)
               4'b0001 : q <= 4'b0010;
               4'b0010 : q <= 4'b0100;
               4'b0100 : q <= 4'b1000;
               4'b1000 : q <= 4'b0001;
                default: q <= 4'b0001;  // 문제 생기면 초기값으로!
            endcase
        end
    end
    
endmodule

module ring_counter_shift (
    input clk,
    input reset_p,
    
    output reg [3:0] q
);

    always @(posedge clk or posedge reset_p) begin
        if (reset_p) begin
            q <= 4'b0001;
        end
        else begin
            if (q == 4'b1000)
                q <= 4'b0001;
            else if(q == 4'b0000 || q > 4'b1000)
                q <= 4'b0001;
            else
                q <= {q[2:0], 1'b0};
        end
    end
    
endmodule

module ring_counter_p (
    input clk,
    input reset_p,

    output reg [3:0] q
);
    always @(posedge clk or posedge reset_p) begin
        if (reset_p)
            q <= 4'b0001;       // 초기값 0001 설정
        
        else 
            q = {q[2:0], q[3]};

    end
    
endmodule

module ring_counter_led (
    input clk,
    input reset_p,

    output reg [15:0] q
);
    always @(posedge clk or posedge reset_p) begin
        if (reset_p)
            q <= 4'b0000_0000_0000_0001;       
        
        else 
            q = {q[14:0], q[15]};

    end
    
endmodule

module edge_detector_n(
    input clk,
    input reset_p,
    input cp,
    
    output p_edge,
    output n_edge

    );

    reg ff_cur, ff_old;

    always @(negedge clk or posedge reset_p) begin
        if(reset_p) begin
            ff_cur <= 0;
            ff_old <= 0;
        end else begin

            ff_old <= ff_cur;   //  <= 이것의 의미는 논블러킹, = 은 블러킹
            ff_cur <= cp;       // 블러킹, 논블러킹은 혼합해서 쓰지말고 하나만 쓰도록한다.
                                // 블러킹을 써야하는 상황, 논블러킹을 써야되는 상황이 있어서 따져봐야함

            // ff_old = ff_cur; // 블러킹을 쓰더라도 순서를 잘잡아주면 상관이 없긴하다.
            // ff_cur = cp;
        end
    end

    assign p_edge = ({ff_cur, ff_old} == 2'b10) ? 1 : 0;
    assign n_edge = ({ff_cur, ff_old} == 2'b01) ? 1 : 0;
endmodule

    // cur = 1, old = 0 => p = 1
    // cur = 1, old = 1 => p = 0
    // cur = 0, old = 1 => n = 1



module edge_detector_p(
    input clk,
    input reset_p,
    input cp,
    
    output p_edge,
    output n_edge

    );

    reg ff_cur, ff_old;

    always @(posedge clk or posedge reset_p) begin
        if(reset_p) begin
            ff_cur <= 0;
            ff_old <= 0;
        end else begin
            ff_old <= ff_cur;
            ff_cur <= cp;
        end
    end

    assign p_edge = ({ff_cur, ff_old} == 2'b10) ? 1'b1 : 1'b0;
    assign n_edge = ({ff_cur, ff_old} == 2'b01) ? 1'b1 : 1'b0;
endmodule
























