`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// AUTHOR: ARTHUR J. MILLER & Bibek B.
// Module Name: AND_Bitwise
// Create Date: 10/13/2015 05:53:05 PM
// ECE425L LAB #2
// Purpose: Develope a Verilog structural model for a 16bit bitwise AND
//////////////////////////////////////////////////////////////////////////////////
//                 input1(16b),input2(16b),output(16b) 
module AND_Bitwise(X          ,Y          ,Z);
    input [15:0] X, Y;
    output [15:0] Z;
    
    and     and1[15:0]      (Z,X,Y);
endmodule
