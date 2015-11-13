`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// AUTHOR: ARTHUR J. MILLER
// Module Name: TB_Mux16bit_8to1
// Create Date: 10/15/2015 06:32:34 PM
// ECE425L LAB #2
// Purpose: Develope a Verilog structural model for a 16-bit 8-to-1 MUX
//          Test Bench
//////////////////////////////////////////////////////////////////////////////////

module TB_Mux16bit_8to1();
    // inputs
    reg E;
    reg [2:0] S;
    reg [15:0] X0,X1,X2,X3,X4,X5,X6,X7;
    // outputs
    wire [15:0] Z;
    
    // 1. Instatiate Mux module
    //                               Enable,Select(3b),Input0(16b_allIO),Input1,Input2,Input3,Input4,Input5,Input6,Input7, Output
    Mux16bit_8to1       MUX1        (E     ,   S  , X0,X1,X2,X3,X4,X5,X6,X7, Z);
    
    // 2. Stimulus for test bench
    initial 
        begin
        E=1; S=0; X0=1; X1=2; X2=4; X3=8; X4=16; X5=32; X6=64; X7=128;
        #5 E=1; S=1; X0=1; X1=2; X2=4; X3=8; X4=16; X5=32; X6=64; X7=128;
        #5 E=1; S=2; X0=1; X1=2; X2=4; X3=8; X4=16; X5=32; X6=64; X7=128;
        #5 E=1; S=3; X0=1; X1=2; X2=4; X3=8; X4=16; X5=32; X6=64; X7=128;
        #5 E=1; S=4; X0=1; X1=2; X2=4; X3=8; X4=16; X5=32; X6=64; X7=128;
        #5 E=1; S=5; X0=1; X1=2; X2=4; X3=8; X4=16; X5=32; X6=64; X7=128;
        #5 E=1; S=6; X0=1; X1=2; X2=4; X3=8; X4=16; X5=32; X6=64; X7=128;
        #5 E=1; S=7; X0=1; X1=2; X2=4; X3=8; X4=16; X5=32; X6=64; X7=128;
        end
endmodule
