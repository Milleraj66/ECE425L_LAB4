`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// AUTHOR: ARTHUR J. MILLER & Bibek B.
// Module Name: Mux16bit_8to1
// Create Date: 10/13/2015 05:32:55 PM
// ECE425L LAB #2
// Purpose: Develope a Verilog structural model for a 16-bit 8-to-1 MUX

// Variables:
//          E : Enable Input
//          S : Selecting Input
//          X1 X0 : X0 is first 16-bit input
//                  X1 is second 16bit input
//          Z : 16-bit selected output

//////////////////////////////////////////////////////////////////////////////////

//                   Enable,Select(3b),Input1(16b_allIO,Input2,Input3,Input4,Input5,Input6,Input7,input8, Output
module Mux16bit_8to1(E     ,   S  , X0,X1,X2,X3,X4,X5,X6,X7, Z);
    input E;
    input [2:0] S;
    input [15:0] X0,X1,X2,X3,X4,X5,X6,X7;
    output [15:0] Z;
    wire [15:0] Z0,Z1, Z2, Z3, Z4,Z5;
    
    //******************************************************************//BEGIN two 4-to-1 Mux's
    //                               Enable,Select   ,Input1,Input0,Output
    Mux16bit_2to1       MUX4        (E     ,   S[0]  , X1   , X0   , Z0); 
    //                               Enable,Select   ,Input1,Input0,Output
    Mux16bit_2to1       MUX3        (E     ,   S[0]  , X3   , X2   , Z1);
    //                               Enable,Select   ,Input1,Input0,Output
    Mux16bit_2to1       MUX2        (E     ,   S[0]  , X5   , X4   , Z2);     
    //                               Enable,Select   ,Input1,Input0,Output
    Mux16bit_2to1       MUX1        (E     ,   S[0]  , X7   , X6   , Z3);
    //******************************************************************//END two 4-to-1 Mux's
    
    
    //******************************************************************//BEGIN two 2-to-1 Mux's
    //                               Enable,Select   ,Input1,Input0,Output
    Mux16bit_2to1       MUX6        (E     ,   S[1]  , Z1   , Z0   , Z4);
    //                               Enable,Select   ,Input1,Input0,Output
    Mux16bit_2to1       MUX5        (E     ,   S[1]  , Z3   , Z2   , Z5);
    //******************************************************************//END two 2-to-1 Mux's
    
    
    //                               Enable,Select   ,Input1,Input0,Output
    Mux16bit_2to1       MUX7        (E     ,   S[2]  , Z5   , Z4   , Z);        
endmodule

