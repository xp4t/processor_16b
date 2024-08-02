`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.07.2024 11:01:08
// Design Name: 
// Module Name: reg_19b
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


module reg_16b(
input clk, rst, load, outenA, outenB,
input [15:0] in,
output [15:0] dataA, dataB
    );
reg [15:0] dataout;
always@ (posedge clk)
begin
    if (rst)
        dataout = 16'b0;
    else
        if(load)
            dataout <= in;
        else
            dataout <= dataout;
end
assign dataA = outenA ? dataout : 16'hz;    
assign dataB = outenB ? dataout : 16'hz;      
endmodule
