`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.07.2024 13:47:56
// Design Name: 
// Module Name: program_counter
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


module program_counter(
input clk, rst, load, inc,
input [15:0] in,
output reg [15:0] dataout
    );
    always@ (posedge clk)
    begin
        if(rst)
            dataout <= 16'b0;
        else
            if(load)
                dataout <= in;
            else if (inc)
                dataout <= dataout+1;
            else
                dataout <= dataout;
    end
endmodule
