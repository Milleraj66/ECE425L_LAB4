`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// AUTHOR: ARTHUR J. MILLER
// Module Name: Driver_16BitCpu
// Create Date: 11/30/2015 11:33:01 PM
// ECE425L LAB #4 Problem 1
// Purpose: Driver module for 16 bit Cpu datapath
////////////////////////////////////////////////////////////////////////////////////
module Driver_16BitCpu(Clk_100Hz,Reset,Restart,Clk_1Hz,PC,Ins);
    input Clk_100Hz;
    input Reset;                        // Register File Reset Switch
    input Restart;                      // Program Reset button
    output Clk_1Hz;
    output [3:0] PC;                   // Program Counter
    output [15:12] Ins;                  // Instruction
    //,Control,A,B,ALU_Out,Caddr
    //output [10:0] Control;              // Control signals
    //output [15:0] A;                    // Rs contents
    //output [15:0] B;                    // Rt/Rd contents
    //output [15:0] ALU_Out;              // ALU_Out = A op B
    //output [3:0] Caddr;                 // Write Address into Register File
    wire [15:0] Ins;
    wire [10:0] Control;              // Control signals
    wire [15:0] A;                    // Rs contents
    wire [15:0] B;                    // Rt/Rd contents
    wire [15:0] ALU_Out;              // ALU_Out = A op B
    wire [3:0] Caddr;                 // Write Address into Register File
    
    
    //*** 1. Slow clock from 100Mhz cycle to 1hz cycle
    Slower_Clock                        SLOW_CLOCK          (Clk_100Hz,Clk_1Hz);
    
    //*** 2. Instantiate Datapath
    //                                                       (In[1b],In[1b],In[1],Out[16b],Out[16b],Out[11b],Out[16b],Out[16b],Out[16b],Output[4b])
    DataPath16BitCpu_Clean              DATA_PATH           (Clk_1Hz,Reset,Restart,PC,Ins,Control,A,B,ALU_Out,Caddr);
    
    
    
    
    
endmodule
