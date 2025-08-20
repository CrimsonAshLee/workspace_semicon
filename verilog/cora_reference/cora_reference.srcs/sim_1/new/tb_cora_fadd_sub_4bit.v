`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/20/2025 08:19:20 PM
// Design Name: 
// Module Name: tb_cora_fadd_sub_4bit
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


module tb_full_add_sub_4bit();

    reg [3:0] a, b;     //input = reg
    reg s;
    
    wire [3:0] sum;     //output = wire
    wire carry;
    
    full_add_sub_4bit_s DUT(a, b, s, sum, carry);   //a =/ instance a, a = reg a
    
    initial begin
       for({s, a, b} = 0; {s, a, b} <9'b111111111;{s, a, b} = {s, a, b} + 1)begin   
            #10;
            if (!s && (a + b) !== {carry, sum})
                $display("error %d + %d = %d but %d", a, b, a + b, {carry, sum}); //%d = decimal , %x = hexa
            else if(s && (a - b) !== {sum})
                $display("error %d - %d = %d but %d", a, b, a - b, {sum}); //%d = decimal , %x = hexa
            end
        a = 4'b1111; b = 4'b1111; s = 1'b1; #10;
        $stop;          //system function
            
    end
endmodule


module tb_fadd_sub_4bit();

    reg [3:0] a, b;     //input = reg
    reg s;
    
    wire [3:0] sum;     //output = wire
    wire carry;
    
    fadd_sub_4bit DUT(a, b, s, sum, carry);   //a =/ instance a, a = reg a
    
    initial begin
       for({s, a, b} = 0; {s, a, b} <9'b1_1111_1111;{s, a, b} = {s, a, b} + 1)begin   
            #10;
            if (!s && (a + b) !== {carry, sum})
                $display("error %d + %d = %d but %d", a, b, a + b, {carry, sum}); //%d = decimal , %x = hexa
            else if(s && (a - b) !== {sum})
                $display("error %d - %d = %d but %d", a, b, a - b, {sum}); //%d = decimal , %x = hexa
            end
        a = 4'b1111; b = 4'b1111; s = 1'b1; #10;
        $stop;          //system function
            
    end
endmodule