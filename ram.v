`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.07.2024 13:39:42
// Design Name: 
// Module Name: ram
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


module ram(
input clk, en,
input [15:0] add,
input [15:0] datain,
output [15:0] dataout
    );
    dist_mem_gen_0 ramip (
  .a(add),      // input wire [7 : 0] a
  .d(datain),      // input wire [15 : 0] d
  .clk(clk),  // input wire clk
  .we(en),    // input wire we
  .spo(dataout)  // output wire [15 : 0] spo
);
endmodule
