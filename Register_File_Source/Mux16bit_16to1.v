`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// AUTHOR: ARTHUR J. MILLER & Bibek B.
// Module Name: Mux16bit_16to1
// Create Date: 10/20/2015 05:48:42 PM
// ECE425L LAB #3
// Purpose: Develope a Verilog structural model for a 16-bit 16-to-1 MUX

// Variables:
//          E : Enable Input
//          S : Selecting Input
//          X1 X0 : X0 is first 16-bit input
//                  X1 is second 16bit input
//          Z : 16-bit selected output

//////////////////////////////////////////////////////////////////////////////////

    //(Enable,Select(3b),Input0[16b_all],Input1,Input2,Input3,Input4,Input5,Input6,Input7,Input8,Input9,Input10,Input11,Input12,Input13,Input14,input15, Output)
module Mux16bit_16to1(E,S,X0,X1,X2,X3,X4,X5,X6,X7,X8,X9,X10,X11,X12,X13,X14,X15,Z);
    input E;
    input [3:0] S;
    input [15:0] X0,X1,X2,X3,X4,X5,X6,X7,X8,X9,X10,X11,X12,X13,X14,X15;
    output [15:0] Z;
    wire [15:0] Z1, Z2;
    
    // Enable,Select(3b),Input1(16b_allIO,Input2,Input3,Input4,Input5,Input6,Input7,input8, Output
    Mux16bit_8to1       MUX1        (E,S[2:0],X0,X1,X2,X3,X4,X5,X6,X7,Z1);
    // Enable,Select(3b),Input1(16b_allIO,Input2,Input3,Input4,Input5,Input6,Input7,input8, Output
    Mux16bit_8to1       MUX2        (E,S[2:0],X8,X9,X10,X11,X12,X13,X14,X15,Z2);
    //                               Enable,Select,Input1,Input0,Output
    Mux16bit_2to1       MUX3        (E     ,   S[3]  ,  Z2  , Z1   , Z);    
endmodule

