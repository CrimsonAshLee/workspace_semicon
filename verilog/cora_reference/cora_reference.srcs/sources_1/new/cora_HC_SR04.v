`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/20/2025 08:07:27 PM
// Design Name: 
// Module Name: cora_HC_SR04
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


module HC_SR04(
    input clk, reset_p,
    input echo,
    output reg trigger,
    output reg [15:0] distance,
    output reg [7:0] led_bar
    );
    
    parameter H_IDLE = 4'b0001;
    parameter H_TRIG_10US = 4'b0010;
    parameter H_READ_DATA = 4'b0100;
    parameter H_CAL_DISTANCE = 4'b1000;

    parameter H_WAIT_PEDGE = 2'b01;
    parameter H_WAIT_NEDGE = 2'b10;
    
    wire clk_usec;
    reg [15:0] count_usec;
    reg count_usec_e;
    
    wire hc_pedge, hc_nedge;
    reg [15:0] count_clk;
    reg [3:0] state, next_state;
    reg [1:0] read_state;
    
    clock_usec usec_clk(.clk(clk), .reset_p(reset_p), .clk_usec(clk_usec));    
    edge_detector_n ed_start0(.clk(clk), .cp_in(echo), .reset_p(reset_p), .p_edge(hc_pedge), .n_edge(hc_nedge));   

     always @(negedge clk or posedge reset_p)begin
        if(reset_p) count_usec = 0;
        else begin
            if(clk_usec && count_usec_e) count_usec = count_usec + 1;
            else if (!count_usec_e) count_usec = 0;
        end
    end
    
    always @(negedge clk or posedge reset_p)begin
        if(reset_p)state = H_IDLE;
        else state = next_state;
    end
    
    always @(posedge clk or posedge reset_p)begin
        if(reset_p)begin
            count_usec_e = 0;
            next_state = H_IDLE;
            read_state = H_WAIT_PEDGE;
            trigger = 0;
            count_clk = 0;
            distance = 0;
            led_bar = 8'b1111_1111;
        end
        else begin 
            case(state)
                H_IDLE : begin
                    led_bar[0] = 0;
                    if(count_usec < 16'd65_000)begin  // datasheet suggest over 60ms
                        count_usec_e = 1; 
                        trigger = 0;
                    end
                    else begin
                        next_state = H_TRIG_10US;
                        count_usec_e = 0;
                        led_bar = 8'b1111_1111;
                    end
                end
                H_TRIG_10US : begin
                    led_bar[1] = 0;
                    if(count_usec < 16'd15)begin    // 10us trigger output
                        count_usec_e = 1;
                        trigger = 1;
                    end
                    else begin
                        next_state = H_READ_DATA;
                        count_usec_e = 0;           // reset count_usec
                        trigger = 0;
                        read_state = H_WAIT_PEDGE;
                    end
                end
                H_READ_DATA : begin
                    led_bar[2] = 0;
                    case(read_state)
                        H_WAIT_PEDGE : begin
                            led_bar[3] = 0;
                            if(hc_pedge)begin
                                count_usec_e = 1;
                                read_state = H_WAIT_NEDGE;
                            end                
                            else begin  
                                count_usec_e = 0;
                            end
                        end    
                        H_WAIT_NEDGE : begin
                            led_bar[4] = 0;
                            if(count_usec < 16'd23_200) begin
                                if(hc_nedge)begin
                                    count_clk = count_usec;
                                    next_state = H_CAL_DISTANCE;
                                end 
                                else begin 
                                    count_usec_e = 1;
                                    read_state = H_WAIT_NEDGE;
                                end
                            end
                            else begin
                                read_state = H_WAIT_PEDGE;
                                next_state = H_IDLE;
                            end     
                        end           
                        default : begin
                            read_state = H_WAIT_PEDGE;
                            next_state = H_IDLE;
                        end
                    endcase
                end
                H_CAL_DISTANCE : begin
                    led_bar[5] = 0;
                    distance = count_clk / 58;
                    count_clk = 0;
                    next_state = H_IDLE;
                    read_state = H_WAIT_PEDGE;
                end
           default : next_state = H_IDLE;
           endcase
        end    
    end
endmodule
