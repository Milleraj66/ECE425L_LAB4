`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// AUTHOR: ARTHUR J. MILLER
// Create Date: 10/03/2015 08:58:39 PM
// ECE425L LAB #1, Problem 1
// Purpose: Develope a Verilog structural model for a 16-bit 2-to-1 MUX and a 3-to-8
//          decoder includeing ENABLE signals. Develop a testbench, perofrm a waveform
//          simulation, and demonstrate the output to the Instructor.

// Variables:
//          E : Enable Input
//          S : Selecting Input
//          X1 X0 : X0 is first 16-bit input
//                  X1 is second 16bit input
//          Z : 16-bit selected output

// FIXED, MUX LOGIC WAS BACKWARD

//////////////////////////////////////////////////////////////////////////////////

//                   Enable,Select,Input1,Input0,Output
module Mux16bit_2to1(E     ,   S  , X1   , X0   , Z);
    input E, S;
    input [15:0] X1;
    input [15:0] X0;
    output [15:0] Z;
    // INtermediate gate outputs     
    wire Snot; 
    wire [15:0] A1;
    wire [15:0] A2; 
    
    // Structural model for 2-to-1 MUX
    // Intermediate gates
    not            n1(Snot,S);
    and a2[15:0]  (A2,E,Snot,X0);
    and a1[15:0]  (A1,E,S,X1);
    // Output
    or  o1[15:0]  (Z, A1, A2);
    
    
    
endmodule
