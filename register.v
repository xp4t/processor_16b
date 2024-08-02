`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.07.2024 21:51:33
// Design Name: 
// Module Name: register
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


module register(
input clk, rst, en, 
input [2:0] write_add, fir_add, sec_add,
input [15:0] write,
output [15:0] fir, sec
    );
//decoder instantiation 
decoder_3x8 write_dec(.in(write_add),.en(en),.out({r7_load,r6_load,r5_load,r4_load,r3_load,r2_load,r1_load,r0_load}));

decoder_3x8 fir_dec(.in(fir_add),.en(1'b1),.out({r7_outenA, r6_outenA, r5_outenA, r4_outenA, r3_outenA, r2_outenA, r1_outenA, r0_outenA}));

decoder_3x8 sec_dec(.in(sec_add),.en(1'b1),.out({r7_outenB, r6_outenB, r5_outenB, r4_outenB,r3_outenB, r2_outenB, r1_outenB, r0_outenB}));



//register instantiation
reg_16b r7(.clk(clk), .rst(rst), .load(r7_load), .outenA(r7_outenA), .outenB(r7_outenB), .in(write), .dataA(fir), .dataB(sec));
reg_16b r6(.clk(clk), .rst(rst), .load(r6_load), .outenA(r6_outenA), .outenB(r6_outenB), .in(write), .dataA(fir), .dataB(sec));
reg_16b r5(.clk(clk), .rst(rst), .load(r5_load), .outenA(r5_outenA), .outenB(r5_outenB), .in(write), .dataA(fir), .dataB(sec));
reg_16b r4(.clk(clk), .rst(rst), .load(r4_load), .outenA(r4_outenA), .outenB(r4_outenB), .in(write), .dataA(fir), .dataB(sec));
reg_16b r3(.clk(clk), .rst(rst), .load(r3_load), .outenA(r3_outenA), .outenB(r3_outenB), .in(write), .dataA(fir), .dataB(sec));
reg_16b r2(.clk(clk), .rst(rst), .load(r2_load), .outenA(r2_outenA), .outenB(r2_outenB), .in(write), .dataA(fir), .dataB(sec));
reg_16b r1(.clk(clk), .rst(rst), .load(r1_load), .outenA(r1_outenA), .outenB(r1_outenB), .in(write), .dataA(fir), .dataB(sec));
reg_16b r0(.clk(clk), .rst(rst), .load(r0_load), .outenA(r0_outenA), .outenB(r0_outenB), .in(write), .dataA(fir), .dataB(sec));

endmodule
