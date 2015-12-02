`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// AUTHOR: ARTHUR J. MILLER
// Module Name: Driver_16BitCpu
// Create Date: 11/30/2015 11:33:01 PM
// Edit Date: Arthur Miller & Bibek B. 12/01/2015
// EDIT: Arthur Miller: 12/1/2015
// ECE425L LAB #4 Problem 1
// Purpose: Driver module for 16 bit Cpu datapath
////////////////////////////////////////////////////////////////////////////////////
module Driver_16BitCpu(Clk_100MHz,Reset,Restart,PC_4bit,Ins_4bit,ALU_Out_4bit,Mem_Out_4bit);
    // **** Inputs
    input Clk_100MHz;                   // Nexy's 4 100Mhz Clock
    input Reset;                        // Register File Reset Switch
    input Restart;                      // Program Reset button
    // **** Outputs
    output wire [3:0] PC_4bit;          // First four bits of PC                  
    output wire [3:0] Ins_4bit;         // Last four bits of Instruction (the opcode)               
    output wire [3:0] ALU_Out_4bit;     // First four bits of ALU_Out   
    output wire [3:0] Mem_Out_4bit;     // First four bits of Memory Output
    // **** Intermediate Wires
    wire Clk_2Hz;                       // Slowed down clock                      
    
    
    //*** 1. Slow clock from 100Mhz cycle to 2Hz cycle
    Slower_Clock                        SLOW_CLOCK          (Clk_100MHz,Clk_2Hz);
    
    //*** 2. Instantiate Datapath
    // (Clock[1b],RegisterReset,InstructionRestart,PC[3:0],Ins[15:12],ControlSig[11b],A[16b],B[3:0],ALU_Out[3:0],RegFileInAddr[4b],DataMemOut[3:0])
    DataPath16BitCpu_Clean              UUT                 (Clk_2Hz,Reset,Restart,PC_4bit,Ins_4bit,,,,ALU_Out_4bit,,Mem_Out_4bit);    
endmodule
