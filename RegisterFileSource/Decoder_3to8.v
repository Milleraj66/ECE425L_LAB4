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
//          X = X2X1X0 : 3 bit input  
//          Z : 8 possile outputs, so 8 bit output 

//////////////////////////////////////////////////////////////////////////////////

//                  Enable,Input(3b),Output(8b)                
module Decoder_3to8(E     ,X        ,Z);
    input E;
    input [2:0] X;
    output [7:0] Z;
    
    // Structural gate logic
    //  outputs
    and A0(Z[0],E,~X[2],~X[1],~X[0]);
    and A1(Z[1],E,~X[2],~X[1], X[0]);
    and A2(Z[2],E,~X[2], X[1],~X[0]);
    and A3(Z[3],E,~X[2], X[1], X[0]);
    and A4(Z[4],E, X[2],~X[1],~X[0]);
    and A5(Z[5],E, X[2],~X[1], X[0]);
    and A6(Z[6],E, X[2], X[1],~X[0]);
    and A7(Z[7],E, X[2], X[1], X[0]);
endmodule
