`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// AUTHOR: ARTHUR J. MILLER & Bibek B.
// Module Name: Reg_File16b
// Create Date: 10/20/2015 04:37:58 PM
// Edit Date: 10/27/2015 Arthur J. Miller
// Edit Date: 10/29/2015 Arthur J. Miller
// ECE425L LAB #3
// Purpose: 16x16 register file
//////////////////////////////////////////////////////////////////////////////////

//                (RegOut1[16b],RegOut2[16b],RegIn[16b],RegAddressA,RegAddressB,RegAddressC,EnableLW,ClearAll,Clock) 
module Reg_File16b(A,B,C,Aaddr,Baddr,Caddr,Load,Clear,Clk);
    output [15:0] A,B;
    input [15:0] C;
    input [3:0] Aaddr,Baddr,Caddr;
    input Load,Clear,Clk;
    wire [255:0] In, Out; // 16,16bit MUX in/out
    wire [15:0] Zdec;    //output of decoder 
    
    
    //***** 1. Instantiate 16, 16 bit registers
    //                                    Clock,AsyncReset,RegInput,RegOutput               
    //Register16b         REG[15:0]      (Clk ,reset      ,In           ,Out);
    Register16b         REG0            (Clk  ,Clear      ,In[15:0]     ,Out[15:0]);
    Register16b         REG1            (Clk  ,Clear      ,In[31:16]    ,Out[31:16]);
    Register16b         REG2            (Clk  ,Clear      ,In[47:32]    ,Out[47:32]);
    Register16b         REG3            (Clk  ,Clear      ,In[63:48]    ,Out[63:48]);
    Register16b         REG4            (Clk  ,Clear      ,In[79:64]    ,Out[79:64]);
    Register16b         REG5            (Clk  ,Clear      ,In[95:80]    ,Out[95:80]);
    Register16b         REG6            (Clk  ,Clear      ,In[111:96]   ,Out[111:96]);
    Register16b         REG7            (Clk  ,Clear      ,In[127:112]  ,Out[127:112] );
    Register16b         REG8            (Clk  ,Clear      ,In[143:128]  ,Out[143:128]);
    Register16b         REG9            (Clk  ,Clear      ,In[159:144]  ,Out[159:144]);
    Register16b         REG10           (Clk  ,Clear      ,In[175:160]  ,Out[175:160]);
    Register16b         REG11           (Clk  ,Clear      ,In[191:176]  ,Out[191:176]);
    Register16b         REG12           (Clk  ,Clear      ,In[207:192]  ,Out[207:192]);
    Register16b         REG13           (Clk  ,Clear      ,In[223:208]  ,Out[223:208]);
    Register16b         REG14           (Clk  ,Clear      ,In[239:224]  ,Out[239:224]);
    Register16b         REG15           (Clk  ,Clear      ,In[255:240]  ,Out[255:240]);

    //***** 2. Select the two output registers (A,B) using Aaddr & Baddr
    // Wire each 16 bit reg into input of 1st 16bit mux. Using Aaddr as select. Output is 16bit out A
    //                               (Enable,Select(3b),Input0[16b_all],Input1,Input2,Input3,Input4,Input5,Input6,Input7,Input8,Input9,Input10,Input11,Input12,Input13,Input14,input15, Output)
    Mux16bit_16to1       MUX1        (1,Aaddr,Out[15:0],Out[31:16],Out[47:32],Out[63:48],Out[79:64],Out[95:80],Out[111:96],Out[127:112],Out[143:128],Out[159:144],Out[175:160],Out[191:176],Out[207:192],Out[223:208],Out[239:224],Out[255:240],A);
    // Wire each 16 bit reg into input of 2nd 16bit mux. Using Baddr as select. Output is 16bit out B
    //                               (Enable,Select(3b),Input0[16b_all],Input1,Input2,Input3,Input4,Input5,Input6,Input7,Input8,Input9,Input10,Input11,Input12,Input13,Input14,input15, Output)
    Mux16bit_16to1       MUX2        (1,Baddr,Out[15:0],Out[31:16],Out[47:32],Out[63:48],Out[79:64],Out[95:80],Out[111:96],Out[127:112],Out[143:128],Out[159:144],Out[175:160],Out[191:176],Out[207:192],Out[223:208],Out[239:224],Out[255:240],B);
    
    //***** 3. Decode and load register's input using Caddr and Load
    // Instatiate 4-to-16 Decoder using Caddr as input. Wire output to enable pin of each 16bit2to1mux
    // If decoder output is 0 keep current value at Q of register
    // If decoder output is 1 load C into register
    // If load is disabled no values will be loaded
    // If load is enabled 1 single register will be loaded with C, chosen by Caddr
    //                                         Enable,Input(4b),Output(16b)                
    Decoder_4to16         DECODER1            (Load     ,Caddr        ,Zdec);
    // The output of DECODER1 will be the load selecter
    // LOAD 1 - Load value of C into Reg
    // LOAD 0 - Hold the current values of Reg
    // Outputs of each mux will wire to input of one of 16 registers
    //                                                  ,LOAD     ,LoadC  ,Retain Q      , Store in Reg
    //                                            Enable   ,Select[1b],Input1[16b],Input0[16b], Output[16b]
    Mux16bit_2to1          MUX_0                (1'b1      ,Zdec[0]  ,C      , Out[15:0]    , In[15:0]);
    Mux16bit_2to1          MUX_1                (1'b1      ,Zdec[1]  ,C      , Out[31:16]   , In[31:16]);
    Mux16bit_2to1          MUX_2                (1'b1      ,Zdec[2]  ,C      , Out[47:32]   , In[47:32]);
    Mux16bit_2to1          MUX_3                (1'b1      ,Zdec[3]  ,C      , Out[63:48]   , In[63:48]);
    Mux16bit_2to1          MUX_4                (1'b1      ,Zdec[4]  ,C      , Out[79:64]   , In[79:64]);
    Mux16bit_2to1          MUX_5                (1'b1      ,Zdec[5]  ,C      , Out[95:80]   , In[95:80]);
    Mux16bit_2to1          MUX_6                (1'b1      ,Zdec[6]  ,C      , Out[111:96]  , In[111:96]);
    Mux16bit_2to1          MUX_7                (1'b1      ,Zdec[7]  ,C      , Out[127:112] , In[127:112]);
    Mux16bit_2to1          MUX_8                (1'b1      ,Zdec[8]  ,C      , Out[143:128] , In[143:128]);
    Mux16bit_2to1          MUX_9                (1'b1      ,Zdec[9]  ,C      , Out[159:144] , In[159:144]);
    Mux16bit_2to1          MUX_10               (1'b1     ,Zdec[10]  ,C      , Out[175:160] , In[175:160]);
    Mux16bit_2to1          MUX_11               (1'b1     ,Zdec[11]  ,C      , Out[191:176] , In[191:176]);
    Mux16bit_2to1          MUX_12               (1'b1     ,Zdec[12]  ,C      , Out[207:192] , In[207:192]);
    Mux16bit_2to1          MUX_13               (1'b1     ,Zdec[13]  ,C      , Out[223:208] , In[223:208]);
    Mux16bit_2to1          MUX_14               (1'b1     ,Zdec[14]  ,C      , Out[239:224] , In[239:224]);
    Mux16bit_2to1          MUX_15               (1'b1     ,Zdec[15]  ,C      , Out[255:240] , In[255:240]);
    
        
endmodule
