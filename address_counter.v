`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.07.2024 22:17:07
// Design Name: 
// Module Name: address_counter
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


module address_counter(
input clk, reset, 
output reg [15:0] add
    ); 
	always@ (posedge clk)
	begin 
		if (reset == 1'b1) 
		add <= 16'b0000_0000_0000_0000; 
		else 
		add <= add + 16'b0000_0000_0000_0001; 
	end 
endmodule
