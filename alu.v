`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: RITHWIK VALLABHAN
// 
// Create Date: 29.07.2024 20:40:37
// Design Name: 
// Module Name: alu
// Project Name: PROCESSOR_19B
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


module alu(
input [15:0] R, S,
input [3:0] opcode,
output reg [15:0] out, N, Z, C
    );
    reg [15:0] memory [255:0];
    always@(R or S or opcode) begin
    case(opcode)
        4'b0000: {C,out} = R + S; //ADD
        4'b0001: {C,out} = R - S; //SUB
        4'b0010: {C,out} = R * S; //MUL
        4'b0011: {C,out} = R / S; //DIV
        4'b0100: {C,out} = R + 1; //INC
        4'b0101: {C,out} = R - 1; //DEC
        //LOGICAL INSTRUCTIONS
        4'b0110: {C,out} = {1'b0, R & S}; //AND
        4'b0111: {C,out} = {1'b0, R | S}; //OR
        4'b1000: {C,out} = {1'b0, R ^ S}; //XOR
        4'b1001: {C,out} = {1'b0, ~R}; //NOT
        //Memory Access Instructions
        4'b1010: out = memory[S[7:0]]; //LD
        4'b1011: memory[S[7:0]] = R; //ST
        4'b1111: {C, out} = {1'b0, S};
        default: {C, out} = {1'b0, S}; 
    endcase
    //NEGATIVE FLAG
    N = out[15];
    //ZERO FLAG
		if  (out == 15'b0)
		      Z = 1'b1;
		else
		      Z = 1'b0;
    end
endmodule
