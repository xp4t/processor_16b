`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.07.2024 23:41:20
// Design Name: 
// Module Name: processor_16b
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


module processor_16b(
input clk, rst, 
input [15:0] din,
output [15:0] dataout, address,
output [7:0] status,
output mem_wr
    );
    wire [15:0] irout;
    wire [3:0] write_add, fir_add, sec_add;
    wire [3:0] opcode;
    
    control_unit u0(clk, rst, N, Z, C, irout ,write_add, fir_add, sec_add, add_sel, sel, pc_load, pc_inc, pc_sel, ir_load, mem_wr, reg_wr, opcode,status);
    
    executee eu0 (clk, rst, en, sel, pc_sel, pc_load, pc_inc, ir_load, add_sel, din,write_add, fir_add, sec_add,opcode,C, N, Z,dataout, irout, address);
    
endmodule
