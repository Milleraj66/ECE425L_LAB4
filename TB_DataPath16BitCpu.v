`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// AUTHOR: ARTHUR J. MILLER & Bibek B.
// Module Name: TB_DataPath16BitCpu
// Create Date: 11/17/2015 07:16:31 PM
// ECE425L LAB #4 
//                  TestBench for Single cycle 16bit processor dataflow
//////////////////////////////////////////////////////////////////////////////////


module TB_DataPath16BitCpu();
    // inputs
    reg Clk;
    wire [15:0] A,B,ALU_Out,PC,Ins,PC_Next,MemToReg_Out,ALUsrc_Out;
    wire [10:0] Con;
    wire [3:0] Caddr;
    // Driver module for CPU
    DataPath16BitCpu            UUT         (Clk,A,B,ALU_Out,PC,Ins,Con,PC_Next,MemToReg_Out,ALUsrc_Out,Caddr);
   
    initial
        Clk = 0;
    always
        #5 Clk = !Clk;
    initial 
        #100 $finish;
endmodule
