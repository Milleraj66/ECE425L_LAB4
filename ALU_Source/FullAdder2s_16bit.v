`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////: 
// Author: Bibek B.
// Create Date: 10/07/2015 09:26:53 AM
// Edit1: Added Overflow flag: 10-15-2015 Arthur J. Miller
// Module Name: FullAdder2s_16bit
// ECE425L LAB #1, Problem 2
// Purpose: Develop a Verilog structural model for a two's complement adder. Develop 
//          a testbench, perform a waveform simulation, and demonstrate the output 
//          to the Instructor.


//     16 bit 2s comp adder using full adders and xor
//////////////////////////////////////////////////////////////////////////////////

//                       input1(16b),input2(16b),CarryIn,CarryOut, Overflow  ,Output(16b)
module FullAdder2s_16bit(x          , y         ,Cin    ,Cout    , Ov        , s);
    input [15:0] x,y;
    input Cin;
    output [15:0]s;
    output Ov;
    output Cout;
    
    wire [14:0]c;
    wire [15:0]a;
    
    // Two's complement for adder
    xor(a[0], y[0],Cin);
    xor(a[1], y[1],Cin);
    xor(a[2], y[2],Cin);
    xor(a[3], y[3],Cin);
    xor(a[4], y[4],Cin);
    xor(a[5], y[5],Cin);
    xor(a[6], y[6],Cin);
    xor(a[7], y[7],Cin);
    xor(a[8], y[8],Cin);
    xor(a[9], y[9],Cin);
    xor(a[10], y[10],Cin);
    xor(a[11], y[11],Cin);
    xor(a[12], y[12],Cin);
    xor(a[13], y[13],Cin);
    xor(a[14], y[14],Cin);
    xor(a[15], y[15],Cin);
    //xor (ov, c3, Cout);
    
    //instantiating the Full adder for 16 bits
    //               input1,input2,CarryIn,CarryOut,Output
    FullAdder_1Bit f1(x[0] , a[0] , Cin   , c[0]   , s[0]);
    FullAdder_1Bit f2(x[1], a[1], c[0], c[1], s[1]);
    FullAdder_1Bit f3(x[2], a[2], c[1], c[2], s[2]);
    FullAdder_1Bit f4(x[3], a[3], c[2], c[3], s[3]);
    FullAdder_1Bit f5(x[4], a[4], c[3], c[4], s[4]);
    FullAdder_1Bit f6(x[5], a[5], c[4], c[5], s[5]);
    FullAdder_1Bit f7(x[6], a[6], c[5], c[6], s[6]);
    FullAdder_1Bit f8(x[7],a[7], c[6], c[7], s[7]);
    FullAdder_1Bit f9(x[8], a[8], c[7], c[8], s[8]);
    FullAdder_1Bit f10(x[9], a[9], c[8], c[9], s[9]);
    FullAdder_1Bit f11(x[10], a[10], c[9], c[10], s[10]);
    FullAdder_1Bit f12(x[11], a[11], c[10], c[11], s[11]);
    FullAdder_1Bit f13(x[12],a[12], c[11], c[12], s[12]);
    FullAdder_1Bit f14(x[13], a[13], c[12], c[13], s[13]);
    FullAdder_1Bit f15(x[14], a[14], c[13], c[14], s[14]);
    FullAdder_1Bit f16(x[15],a[15], c[14], Cout, s[15]);

    // Overflow flag
    xor(Ov,c[14],Cout);

endmodule
