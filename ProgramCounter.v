`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:10:30 05/30/2015 
// Design Name: 
// Module Name:    ProgramCounter 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module ProgramCounter(
	 input clk,
    output reg [15:0] Count
    );
	
	 initial begin
	 Count = -1;
	 end
	 
	 always @(posedge clk)
	 begin
	 Count = Count + 1;
	 end


endmodule
