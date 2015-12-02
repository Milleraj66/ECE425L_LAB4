`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////: 
// Author: Bibek B.
// Create Date: 10/07/2015 09:26:53 AM
// Module Name: FullAdder_1Bit
// ECE425L LAB #1, Problem 2
// Purpose: Develop a Verilog structural model for a two's complement adder. Develop 
//          a testbench, perform a waveform simulation, and demonstrate the output 
//          to the Instructor.


//      Base Full adder module to be instantiated later for a 16 bit 2s comp adder
//////////////////////////////////////////////////////////////////////////////////


//                    input1,input2,CarryIn,CarryOut,Output
module FullAdder_1Bit(x     ,y     ,Cin    ,Cout    ,s);
    input x,y,Cin;
    output Cout, s;
    wire s1,c1,c2;
    
    xor(s1,x,y);
    and(c1,x,y);
    xor(s,s1,Cin);
    and(c2,s1,Cin);
    or(Cout,c1,c2);

endmodule
