`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/12/2025 06:37:21 PM
// Design Name: 
// Module Name: prof_controller
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


module fnd_cntr(
    input clk, reset_p,
    input [15:0] fnd_value,
    input hex_bcd,
    output [7:0] seg_7,
    output [3:0] com);
    
    wire [15:0] bcd_value;
    bin_to_dec bcd(.bin(fnd_value[11:0]), .bcd(sec_bcd));
    
    reg [16:0] clk_div;
    always @(posedge clk)clk_div = clk_div + 1;
    
    anode_selector ring_com(
        .scan_count(clk_div[16:15]), .an_out(com));
    reg [3:0] digit_value; 
    wire [15:0] out_value;
    assign out_value = hex_bcd ? fnd_value : bcd_value;   
    always @(posedge clk or posedge reset_p)begin
        if(reset_p)begin
            digit_value = 0;
        end
        else begin
            case(com)
                4'b1110 : digit_value = out_value[3:0];
                4'b1101 : digit_value = out_value[7:4];
                4'b1011 : digit_value = out_value[11:8];
                4'b0111 : digit_value = out_value[15:12];
            endcase
        end
    end
    seg_decoder dec(.digit_in(digit_value), .seg_out(seg_7));
endmodule

module debounce (
    input clk,
    input btn_in,
    output reg btn_out
);

    reg [15:0] count;
    reg btn_sync_0, btn_sync_1;
    wire stable = (count == 16'hFFFF);

    always @(posedge clk) begin
        btn_sync_0 <= btn_in;
        btn_sync_1 <= btn_sync_0;
    end

    always @(posedge clk) begin
        if(btn_sync_1 == btn_out) begin
            count <= 0;
        end else begin
            count <= count + 1;
            if(stable)
                btn_out <= btn_sync_1;
        end
    end

endmodule

module btn_cntr(
    input clk, reset_p,
    input btn,
    output btn_pedge, btn_nedge);
    wire debounced_btn;
    debounce btn_0(.clk(clk), .btn_in(btn), .btn_out(debounced_btn));
    
    edge_detector_p btn_ed(
        .clk(clk), .reset_p(reset_p), .cp(debounced_btn),
        .p_edge(btn_pedge), .n_edge(btn_nedge));

endmodule

module dht11_cntr(
    input clk, reset_p,
    inout dht11_data,
    output reg [7:0] humidity, temperature,
    output [15:0] led);

    localparam S_IDLE       = 6'b00_0001;
    localparam S_LOW_18MS   = 6'b00_0010;
    localparam S_HIGH_20US  = 6'b00_0100;
    localparam S_LOW_80US   = 6'b00_1000;
    localparam S_HIGH_80US  = 6'b01_0000;
    localparam S_READ_DATA  = 6'b10_0000;
    
    localparam S_WAIT_PEDGE = 2'b01;
    localparam S_WAIT_NEDGE = 2'b10;
    
    wire clk_usec_nedge;
    clock_div_100 us_clk(.clk(clk), .reset_p(reset_p),
        .nedge_div_100(clk_usec_nedge));
    
    reg [21:0] count_usec;
    reg count_usec_e;
    always @(negedge clk, posedge reset_p)begin
        if(reset_p)count_usec = 0;
        else if(clk_usec_nedge && count_usec_e)count_usec = count_usec + 1;
        else if(!count_usec_e)count_usec = 0;
    end
    
    wire dht_nedge, dht_pedge;
    edge_detector_p dht_ed(
        .clk(clk), .reset_p(reset_p), .cp(dht11_data),
        .p_edge(dht_pedge), .n_edge(dht_nedge));
        
    reg dht11_buffer;
    reg dht11_data_out_e;
    assign dht11_data = dht11_data_out_e ? dht11_buffer : 'bz;
    
    reg [5:0] state, next_state;
    assign led[5:0] = state;
    reg [1:0] read_state;
    always @(negedge clk, posedge reset_p)begin
        if(reset_p)state = S_IDLE;
        else state = next_state;
    end
    
    reg [39:0] temp_data;
    reg [5:0] data_count;
    assign led[11:6] = data_count;
    always @(posedge clk, posedge reset_p)begin
        if(reset_p)begin
            next_state = S_IDLE;
            temp_data = 0;
            data_count = 0;
            dht11_data_out_e = 0;
            read_state = S_WAIT_PEDGE;
        end
        else begin
            case(state)
                S_IDLE:begin
                    if(count_usec < 22'd3_000_000)begin //3_000_000
                        count_usec_e = 1;
                        dht11_data_out_e = 0;
                    end
                    else begin
                        count_usec_e = 0;
                        next_state = S_LOW_18MS;
                    end
                end
                S_LOW_18MS   :begin
                    if(count_usec < 22'd18_000)begin //18_000
                        count_usec_e = 1;
                        dht11_data_out_e = 1;
                        dht11_buffer = 0;
                    end
                    else begin
                        count_usec_e = 0;
                        next_state = S_HIGH_20US;
                        dht11_data_out_e = 0;
                    end
                end
                S_HIGH_20US  :begin
                    // if(count_usec < 22'd20)begin
                    //     count_usec_e = 1;
                    // end
                    // else begin
                        if(dht_nedge)begin
                            next_state = S_LOW_80US;
                            count_usec_e = 0;
                        end
                    // end
                end
                S_LOW_80US   :begin
                    if(dht_pedge)next_state = S_HIGH_80US;
                end
                S_HIGH_80US  :begin
                    if(dht_nedge)next_state = S_READ_DATA;
                end
                S_READ_DATA  :begin
                    case(read_state)
                        S_WAIT_PEDGE:begin
                            if(dht_pedge)read_state = S_WAIT_NEDGE;
                            count_usec_e = 0;
                        end
                        S_WAIT_NEDGE:begin
                            if(dht_nedge)begin
                                read_state = S_WAIT_PEDGE;
                                data_count = data_count + 1;
                                if(count_usec < 50)temp_data = {temp_data[38:0], 1'b0};
                                else temp_data = {temp_data[38:0], 1'b1};
                            end
                            else count_usec_e = 1;
                        end
                    endcase
                    if(data_count >= 40)begin
                        next_state = S_IDLE;
                        data_count = 0;
                        humidity = temp_data[39:32];
                        temperature = temp_data[23:16];
                    end
                end
                default: next_state = S_IDLE;
            endcase
        end
    end
endmodule
