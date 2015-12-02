`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// AUTHOR: ARTHUR J. MILLER
// Module Name: Slower_Clock
// Create Date: 01/29/2015 07:51:53 PM
// ECE425L LAB #4 Problem 1
// Purpose: Slower the Nexy's 4 clock down to 2Sec period 
//////////////////////////////////////////////////////////////////////////////////


module Slower_Clock(
    input clk_100Mhz,
    output reg clk_1Hz
    );
    
    reg [26:0] counter; 
    always @ (posedge clk_100Mhz) 
    begin 
        counter = counter +1; // Increment counter 
        if (counter == 100_000_000) // check if it reaches 50,000,000 
        begin 
            clk_1Hz=~clk_1Hz; // if so, then flip the logic state of the 
            counter =0; // output and reset the counte 
        end 
    end
endmodule
