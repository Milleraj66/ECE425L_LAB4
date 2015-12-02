`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// AUTHOR: ARTHUR J. MILLER
// Create Date: 10/15/2015 08:18:40 PM
// Module Name: Mux1bit_2to1
// ECE425L LAB #2
// Purpose: Develope a Verilog structural model for a 1bit 2-to-1 MUX and a 3-to-8
//          decoder includeing ENABLE signals. Develop a testbench, perofrm a waveform
//          simulation, and demonstrate the output to the Instructor.

// Variables:
//          E : Enable Input
//          S : Selecting Input
//          X1 X0 : X0 is first 1-bit input
//                  X1 is second 1-bit input
//          Z : 1-bit selected output

//////////////////////////////////////////////////////////////////////////////////

//                   Enable,Select,Input1,Input0,Output
module Mux1bit_2to1(E     ,   S  , X0   , X1   , Z);
    input E, S;
    input X1;
    input X0;
    output Z;
    // INtermediate gate outputs     
    wire Snot; 
    wire A1;
    wire A2; 
    
    // Structural model for 2-to-1 MUX
    // Intermediate gates
    not n1 (Snot,S);
    and a1 (A1,E,S,X0);
    and a2 (A2,E,Snot,X1);
    // Output
    or  o1 (Z, A1, A2);
    
    
    
endmodule
