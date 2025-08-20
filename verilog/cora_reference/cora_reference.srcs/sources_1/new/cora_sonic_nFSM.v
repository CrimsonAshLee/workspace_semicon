`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/20/2025 08:10:57 PM
// Design Name: 
// Module Name: cora_sonic_nFSM
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


module sonic_nFSM(
    input clk, reset_p,
    input echo,
    output reg trig,
    output reg [15:0] distance_cm,
    output reg [7:0] led_bar
    );
    
    wire clk_usec;
    reg [16:0] count_usec;
    reg count_usec_e;   
    reg [16:0] count_echo;
    reg count_echo_e;   
    
    
    clock_usec usec_clk(.clk(clk), .reset_p(reset_p), .clk_usec(clk_usec));    
    
    always @(negedge clk or posedge reset_p)begin
        if(reset_p) count_usec = 0;
        else begin
            if(clk_usec && count_usec_e) count_usec = count_usec + 1;
            else if (!count_usec_e) count_usec = 0;
        end
    end   
    
     always @(negedge clk or posedge reset_p)begin
        if(reset_p) count_echo = 0;
        else begin
            if(clk_usec && count_echo_e) count_echo = count_echo + 1;
            else if (!count_echo_e) count_echo = 0;
        end
    end   
    wire echo_pedge, echo_nedge;
    edge_detector_n ed_start0(.clk(clk), .cp_in(echo), .reset_p(reset_p), .p_edge(echo_pedge), .n_edge(echo_nedge));   
    reg [16:0] temp_value [15:0];   // 17bit 16
    reg [16:0] old_usec;
    reg [20:0] sum_value;
    reg [3:0] index;
    reg [4:0] i;

    always @(posedge clk or posedge reset_p)begin
        if(reset_p)begin
            led_bar = 8'b11111111;
            index = 0;
            count_usec_e = 0;
            count_echo_e = 0;
            trig = 0;
        end    
        else if(count_usec < 17'd80_015) begin
            count_usec_e = 1;
                if(count_usec > 17'd80_000) begin
                    trig = 1;
                end
                else trig = 0;
                if(echo_pedge) begin
                    if(count_echo < 17'd80_000) begin
                        old_usec = count_echo;
                    end
                    else count_echo_e = 0;
                end    
                else if(echo_nedge) begin
                    if(count_echo < 17'd80_000) begin
                        temp_value[index] = count_echo - old_usec;
                        index = index + 1;
                        count_echo_e = 0;
                    end
                    else count_echo_e = 0;
                end
                else count_echo_e = 1;
        end
        else begin
            count_echo_e = 0;
            trig = 0;
            count_usec_e = 0;
        end
    end
    
    always @(posedge clk_usec or posedge reset_p) begin
        if(reset_p) begin
            sum_value = 0;
            i = 0;
        end
        else begin
            sum_value = 0;
            for (i = 0; i < 16; i = i + 1) begin
                sum_value = sum_value + temp_value[i];    
            end
        end    
    end
          
    always @(posedge clk_usec or posedge reset_p) begin
        if(reset_p) distance_cm = 0;
        else distance_cm = sum_value[20:4] / 58;
    end   
       
endmodule


module sonic_nFSM_TOP(
    input clk, reset_p,
    input echo,
    output trig,
    output [7:0] led_bar,
    output [3:0] com,
    output [7:0] seg_7
    );
    
    wire [15:0] distance_cm;
    sonic_nFSM sr04(clk, reset_p, echo, trig, distance_cm, led_bar);
    
    wire [15:0] value;
    bin_to_dec b2d(.bin(distance_cm[11:0]), .bcd(value));
    
    FND_4digit_cntr fnd_cntr(.clk(clk), .reset_p(reset_p), .value(value), .com(com), .seg_7(seg_7));
               
endmodule
