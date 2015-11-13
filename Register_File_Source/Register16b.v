`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// AUTHOR: ARTHUR J. MILLER & Bibek B.
// Module Name: Register16b
// Create Date: 10/20/2015 05:28:21 PM
// ECE425L LAB #3
// Purpose: Develope a 16bit register using d flip flops
//////////////////////////////////////////////////////////////////////////////////

//                 Clock,AsyncReset,RegInput,RegOutput               
module Register16b(Clk  ,     reset,      In,Out);
    input [15:0] In;
    input Clk, reset;
    output [15:0] Out;
    
    //***** 16 bit Parallel in, Parallel out register
    //                  Clock, Reset, Input, Output                                
    D_FF    DFF [15:0] (Clk  , reset, In    , Out);
    
endmodule
