`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/20/2025 08:09:12 PM
// Design Name: 
// Module Name: cora_multi_watch
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


module multi_watch(
    input clk,
    input reset_p,
    input [3:0] btn,
    output reg led_y, led_g, led_r,
    output [3:0] com,
    output [7:0] seg_7
    );
   
    wire mode_change;                                       //btn[3]ÀÇ ÀÔ·Â
    button_cntr bcntr_setmode(.clk(clk), .reset_p(reset_p), .btn(btn[3]), .btn_pe(mode_change));
    
    reg [1:0] count_mode;                                   //2bit Ä«¿îÅÍ
    always @(posedge clk) begin
//            if(mode_change) count_mode = count_mode + 1;    //žðµåº¯°æœÃ Ä«¿îÅÍ Áõ°¡
//            else if(count_mode >= 3) count_mode = 0;        //Ä«¿îÅÍ°¡ 3ÀÌ»óÀÌžé 0Àž·Î ÃÊ±âÈ­
        if(count_mode >= 3) count_mode = 0;
        else begin
            if(mode_change) count_mode = count_mode + 1;
        end
    end

    reg [15:0] value;
    wire [15:0] value_watch;
    wire [15:0] value_stop;
    wire [15:0] value_cook;
    // œÃ°è, œºÅŸ¿öÄ¡, ÁÖ¹æÅžÀÌžÓ °¢°¢ÀÇ value ·¹ÁöœºÅÍ
    
    reg [3:0] btn1;
    reg [3:0] btn2;
    reg [3:0] btn3;
    // œÃ°è, œºÅŸ¿öÄ¡, ÁÖ¹æÅžÀÌžÓ °¢°¢ÀÇ ¹öÆ° ·¹ÁöœºÅÍ
    
    reg reset_p1, reset_p2, reset_p3;
    wire led_y1, led_g1, led_r1;
    wire watch_set_mode, lap, start_stop_cook; 
    // œÃ°è, œºÅŸ¿öÄ¡, ÁÖ¹æÅžÀÌžÓ °¢°¢ÀÇ btn[0]¿¡Œ­ÀÇ t-flipflop °ª

    hour_watch hour(.clk(clk), .reset_p(reset_p1), .btn(btn1[3:0]), .value(value_watch), .set_mode(watch_set_mode));
    // œÃ°£ ºÐÀ» Ãâ·ÂÇÏŽÂ œÃ°è ÀÎœºÅÏœº
    stop_watch_msec stop(.clk(clk), .reset_p(reset_p2), .btn(btn2[3:0]), .value(value_stop), .lap(lap));        
    // 10msec ŽÜÀ§·Î Ãâ·ÂÇÏŽÂ œºÅŸ¿öÄ¡ ÀÎœºÅÏœº  
    cook_timer99 cook(.clk(clk), .reset_p(reset_p3), .btn(btn3[3:0]), .value(value_cook), .start_stop(start_stop_cook));
    // 99:59±îÁö Ãâ·ÂÇÏŽÂ ÁÖ¹æÅžÀÌžÓ ÀÎœºÅÏœº 
     
    always @(posedge clk) begin
        case(count_mode)
            2'b00 : begin
                value = value_watch;
                btn1 = btn;
                reset_p1 = reset_p;
                if(!watch_set_mode) begin
                    led_y = 1; led_g = 0; led_r = 0;
                end
                else if(watch_set_mode) begin
                    led_y = led_y1; led_g = 0; led_r = 0;
                end
            end                                             
            //count_mode°¡ 0ÀÏ °æ¿ì, œÃ°è·Î µ¿ÀÛ(³ë¶û»ö led Á¡µî), set_mode ÁøÀÔœÃ led Åä±Û  
            2'b01 : begin
                value = value_stop;
                btn2 = btn;
                reset_p2 = reset_p;
                if(!lap) begin
                    led_y = 0; led_g = 1; led_r = 0;
                end
                else if(lap) begin
                    led_y = 0; led_g = led_g1; led_r = 0;
                end
            end
            //count_mode°¡ 1ÀÏ °æ¿ì, œºÅŸ¿öÄ¡·Î µ¿ÀÛ(ÃÊ·Ï»ö led Á¡µî), œºÅŸ¿öÄ¡ ÀÛµ¿ œÃ led Åä±Û  
            2'b10 : begin
                value = value_cook;
                btn3 = btn;
                reset_p3 = reset_p;
                if(start_stop_cook) begin
                    led_y = 0; led_g = 0; led_r = 1;
                end
                else if(!start_stop_cook) begin
                    led_y = 0; led_g = 0; led_r = led_r1;
                end
            end
            //count_mode°¡ 2ÀÏ °æ¿ì, ÁÖ¹æÅžÀÌžÓ·Î µ¿ÀÛ(»¡°­»ö led Á¡µî), ÁÖ¹æÅžÀÌžÓ ÀÛµ¿ œÃ led Åä±Û  
            default : begin
                value = value_watch;
                btn1 = btn;
                reset_p1 = reset_p;
                if(watch_set_mode) begin
                    led_y = 1; led_g = 0; led_r = 0;
                end
                else if(!watch_set_mode) begin
                    led_y = led_y1; led_g = 0; led_r = 0;
                end
                //count_mode = 2'b00;
            end
            //µðÆúÆ®°ª, œÃ°è·Î µ¿ÀÛ(³ë¶û»ö led Á¡µî), set_mode ÁøÀÔœÃ led Åä±Û  
        endcase    
    end
    
    reg [27:0] clk_div;
    always @(posedge clk)clk_div = clk_div + 1;
    pwm_100 pwm_y(.clk(clk), .reset_p(reset_p), .duty({1'b0, clk_div[27:22]}), .pwm_preq(10000), .pwm_100pc(led_y1));
    pwm_100 pwm_g(.clk(clk), .reset_p(reset_p), .duty({2'b00, clk_div[27:23]}), .pwm_preq(10000), .pwm_100pc(led_g1));
    pwm_100 pwm_r(.clk(clk), .reset_p(reset_p), .duty({1'b0, clk_div[27:22]}), .pwm_preq(10000), .pwm_100pc(led_r1));
    // pwmÀ» ÀÌ¿ë, dutyºñ led_y(64), led_g(32), led_r(64)·Î Â÷µî µ¿ÀÛ 
    FND_4digit_cntr fnd_cntr(.clk(clk), .reset_p(reset_p), .value(value), .com(com), .seg_7(seg_7));
    // value°ªÀ» FND·Î Ãâ·Â
endmodule
