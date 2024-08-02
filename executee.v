`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.07.2024 22:46:11
// Design Name: 
// Module Name: executee
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


module executee(
input clk, rst, en, sel, pc_sel, pc_load, pc_inc, ir_load, add_sel,
input [15:0] din,
input [2:0] write_add, fir_add, sec_add,
input [3:0] opcode,
output C, N, Z,
output [15:0] dataout, irout, address
    );
wire [15:0] pc_out;
wire [15:0] pc_mux;
wire [15:0] sign_extn; 
wire [15:0] jadd; 
instreg i0(clk, rst, ir_load, din, irout);

idp i1(clk, rst, sel, en, write_add, fir_add, sec_add, opcode, din, fir, dataout, N, Z, C);

program_counter p0(clk, rst, pc_load, pc_inc, pc_mux, pc_out);

assign address = (add_sel) ? fir : pc_out;

assign sign_extn = {{8{irout[7]}}, irout[7:0]};

assign jadd = pc_out + sign_extn;

assign pc_mux = (pc_sel) ? dataout : jadd;
endmodule
