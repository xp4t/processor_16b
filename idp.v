`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.07.2024 13:57:04
// Design Name: 
// Module Name: idp
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


module idp(
input clk, rst, sel, en,
input [2:0] write_add, fir_add, sec_add,
input [3:0] opcode,
input [15:0] secin,
output [15:0] fir,
output [15:0] aluout,
output N, Z, C
    );
    wire [15:0] secout;
    wire [15:0] secmux;
    
    register regii(clk, rst, en, write_add, fir_add, sec_add, aluout, fir, sec);
    alu a1(fir, secmux, opcode, aluout, N, Z, C);
    
    assign secmux = sel ? secin : sec ;
endmodule
