`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// AUTHOR: ARTHUR J. MILLER & Bibek B.
// Module Name: TB_DataPath16BitCpu_Clean
// Create Date: 12/01/2015 01:09:09 PM
// ECE425L LAB #4 
//                  TestBench for Single cycle 16bit processor dataflow
//////////////////////////////////////////////////////////////////////////////////


module TB_DataPath16BitCpu_Clean();
    reg Clk;
    reg Reset;                        // Register File Reset Switch
    reg Restart;                      // Program Reset button
    wire [15:0] PC;
    wire [15:0] Ins;
    wire [10:0] Control;              // Control signals
    wire [15:0] A;                    // Rs contents
    wire [15:0] B;                    // Rt/Rd contents
    wire [15:0] ALU_Out;              // ALU_Out = A op B
    wire [3:0] Caddr;                 // Write Address into Register File
    
    //*** 1. Slow clock from 100Mhz cycle to 1hz cycle
    //Slower_Clock                        SLOW_CLOCK          (Clk,Clk_1Hz);
    
    //*** 2. Instantiate Datapath
    //                                                       (In[1b],In[1b],In[1],Out[16b],Out[16b],Out[11b],Out[16b],Out[16b],Out[16b],Output[4b])
    DataPath16BitCpu_Clean              DATA_PATH           (Clk,Reset,Restart,PC,Ins,Control,A,B,ALU_Out,Caddr);
   
   
   
    initial
        begin
        Clk = 0;
        Restart = 1'b0;
        Reset = 1'b0;
        #6 Reset = 1'b1; Restart = 1'b1;
        end
    always
        begin
        #5 Clk = !Clk; 
        end
    initial 
        #200 $finish;
endmodule

