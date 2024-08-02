`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.08.2024 00:01:21
// Design Name: 
// Module Name: top_module
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


module top_module(
input clk, rst, memsel,
output [7:0] status
    );
wire [15:0] dataout, address, din, memadd, addcout;

processor_16b u0(clk, rst, din, dataout, addr, status, mem_wr);

ram r0(clk, en, memadd, dataout, datain);

address_counter a0(clk, rst, addcout); 

assign mem_add = (memsel) ? addcout : addr;

endmodule
