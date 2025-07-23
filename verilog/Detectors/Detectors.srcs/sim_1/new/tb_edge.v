`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/23/2025 11:30:28 AM
// Design Name: 
// Module Name: tb_edge
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


module tb_edge_detector;

    reg clk;
    reg reset_p;
    reg cp;

    wire p_edge_pos, n_edge_pos;
    wire p_edge_neg, n_edge_neg;

    always #5 clk = ~clk;       // (10ns)
        
    edge_detector_p uut_p(
        .clk(clk),
        .reset_p(reset_p),
        .cp(cp),
        .p_edge(p_edge_pos),
        .n_edge(n_edge_pos)
    );

    edge_detector_n uut_n(
        .clk(clk),
        .reset_p(reset_p),
        .cp(cp),
        .p_edge(p_edge_neg),
        .n_edge(n_edge_neg)
    );

    initial begin
        //initial
        clk = 0;
        reset_p = 1;
        cp = 0;

        #12;
        reset_p = 0;

        #10; cp = 1;
        #20; cp = 0;
        #15; cp = 1;
        #25; cp = 0;
        #25;

        $finish;
    end

endmodule


module tb_ring_counter;
    
    reg clk;
    reg reset_p;

    wire [3:0] q;

    ring_counter uut(
        .clk(clk),
        .reset_p(reset_p),
        .q(q)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        reset_p = 1;

        #10 reset_p = 0;

        #100;

        // 강제로 주입
        force uut.q = 4'b0110;
        #10;
        // default 동작이 어떻게 되는지?
        #50;

        $finish;
    end
    
endmodule


module tb_ring_counter_shift;
    
    reg clk;
    reg reset_p;

    wire [3:0] q;

    ring_counter_shift uut(
        .clk(clk),
        .reset_p(reset_p),
        .q(q)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        reset_p = 1;

        #10 reset_p = 0;

        #100;

        // 강제로 주입
        force uut.q = 4'b0110;
        #10;
        release uut.q;

        // default 동작이 어떻게 되는지?
        #50;

        $finish;
    end
    
endmodule


module tb_ring_counter_fnd;
    
    reg clk;
    reg reset_p;

    wire [3:0] q;

    ring_counter_fnd uut(
        .clk(clk),
        .reset_p(reset_p),
        .q(q)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        reset_p = 1;

        #10 reset_p = 0;

        #5000;

        $finish;
    end
    
endmodule


module tr_ring_counter_led;
    
    reg clk;
    reg reset_p;
    
    wire [15:0] led;

    ring_counter_led(
        .clk(clk),
        .reset_p(reset_p),
        .led(led)
    );

    initial begin
        clk = 0;
    end

    always #5 clk = ~clk;

    initial begin
        reset_p = 1;
        #20;
        reset_p = 0;

        #200000;

        $finish;
    end
    
endmodule