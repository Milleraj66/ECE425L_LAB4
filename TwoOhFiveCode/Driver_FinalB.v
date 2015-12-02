`timescale 1ns / 1ps
/*
    Author: Arthur Miller
    Due Date: 03-12-15
    ECE 205L Final
    Purpose: Combination lock module driver function
*/

// REV1: 03-06-15
// REV2: 03-12-15

module Driver_FinalB(clk_100Mhz, iSW, an, seg, state);
    input clk_100Mhz;
    input [5:1] iSW;
    output [7:0] an;
    output [6:0] seg;
    output [6:0] state;
    wire INC;
    or(INC, iSW[5], SW[7]);

    wire clk_400Hz, clk_5Hz, clk_1Hz;
    // BLOCK 3
    parameter UP_DWN = 0; 
    
    //BLOCK4 
        //COUNTER_DATA
        wire [4:0] CNT0;
        wire [4:0] CNT1;
        wire [4:0] CNT2;
        wire [4:0] CNT3;
        //CARRY_OUT
        wire [3:0] COUT; // right most blocks carry out
        //wire [1:0] COUTl;// Left most blocks carry out
        //DATA_IN
        parameter DATA_IN3 = 4'b0000;
        parameter DATA_IN2 = 4'b0000;
        parameter DATA_IN1 = 4'b0101;
        parameter DATA_IN0 = 4'b1001;
        // UP_DWN
        parameter UP_DWN3 = 1;
        parameter UP_DWN2 = 1;
        parameter UP_DWN1 = 0;
        parameter UP_DWN0 = 0;
        // LD
        parameter LD3 = 0;
        parameter LD2 = 0;
        // RST
        parameter RST1 = 0;
        parameter RST0 = 0;
    
    // BLOCK5
        wire [4:0] DATA3;
        wire [4:0] DATA2;
        wire [4:0] DATA1;
        wire [4:0] DATA0;
    // BLOCK5a
        parameter IN0a = 5'b10000; // 16 = 'P' 
        parameter IN1a = 5'b01011; // 11 = 'F'
        parameter IN2a = 5'b01100; // 12 = 'G'
        parameter IN3a = 5'b10010; // 18 = '-'

    // BLOCK5b
        parameter IN0b = 5'b01010; // 10 = 'A'
        parameter IN1b = 5'b01010; // 10 = 'A'
        parameter IN2b = 5'b01111; // 15 = 'o'
        parameter IN3b = 5'b10010; // 18 = '-'
    // BLOCK5c
        parameter IN0c = 5'b10001; // 17 = 'S'
        parameter IN1c = 5'b01101; // 13 = 'I'
        parameter IN2c = 5'b10011; // 19 = ' '
        parameter IN3c = 5'b10010; // 18 = '-'
   // BLOCK5d
        parameter IN0d = 5'b10001; // 17 = 'S'
        parameter IN1d = 5'b01110; // 14 = 'L'
        parameter IN2d = 5'b10011; // 19 = ' '
        parameter IN3d = 5'b10010; // 18 = '-'
   
   // BLOCK6
        wire [4:0] MUX_OUT;
   
   // BLOCK7
        wire [1:0] CNT;
    
    // STATEMACHINE
        wire [7:0] SW;

    //                                                        (clk_100Mhz, clk_400Hz)
    clk_100Mhz_400Hz                        BLOCK1            (clk_100Mhz, clk_400Hz);
    //                                                        (clk_400hz, clk_5Hz)
    clk_400Hz_5Hz                           BLOCK2            (clk_400Hz, clk_5Hz); 
    //                                                        (clk_5Hz,UP_DWN ,clk_1Hz)
    //Zero_to_Four_UpDwn_Counter              BLOCK3            (clk_5Hz,UP_DWN,clk_1Hz);
    
    Slower_Clock                            BLCK12           (clk_100Mhz, clk_1Hz);
    
    //                                                        (clk_5Hz, RST  , LD , DATA_IN ,CLK_EN, UP_DWN ,CARRY_OUT, COUNTER_DATA)
    //RST = CTRL[5] = SW[7] 
    //LD = 0
    // DATA_IN = 0000
    // CLK_EN = CTRL[3]
    // UP_DWN = 1
    Zero_to_Nine_UpDwn_Counter              BLOCK4a           (clk_5Hz, SW[5], LD3, DATA_IN3, SW[3], UP_DWN3, COUT[3], CNT3);
    // RST = CTRL[5] = SW[7] 
    // LD = 0
    // DATA_IN = 0000
    // CLK_EN = CTRL[7]
    // UP_DWN = 1
    Zero_to_Nine_UpDwn_Counter              BLOCK4b           (clk_5Hz, SW[5], LD3, DATA_IN2, INC, UP_DWN2, COUT[2], CNT2);
    // RST = 0
    // LD = CTRL[6] = SW[6]
    // DATA_IN = 0101
    // CLK_EN = CARRY_OUT
    // UP_DWN = 0
    Zero_to_Nine_UpDwn_Counter              BLOCK4c           (clk_1Hz, RST1, SW[6], DATA_IN1, COUT[0], UP_DWN1, COUT[1], CNT1);
    // RST = 0
    // LD = CTRL[6] = SW[6]
    // DATA_IN = 1001
    // CLK_EN = CTRL[4]
    // UP_DWN = 0
    Zero_to_Nine_UpDwn_Counter              BLOCK4d           (clk_1Hz, RST0, SW[6], DATA_IN0, SW[4], UP_DWN0, COUT[0], CNT0);
    
    //Five_to_One_Mux                                         (IN0 , IN1 , IN2 , IN3 , IN4 , SEL    , MUX_OUT)
    Five_to_One_Mux                         BLOCK5a           (CNT3, IN3a, IN2a, IN1a, IN0a, SW[2:0], DATA3);
    Five_to_One_Mux                         BLOCK5b           (CNT2, IN3b, IN2b, IN1b, IN0b, SW[2:0], DATA2);
    Five_to_One_Mux                         BLOCK5c           (CNT1, IN3c, IN2c, IN1c, IN0c, SW[2:0], DATA1);
    Five_to_One_Mux                         BLOCK5d           (CNT0, IN3d, IN2d, IN1d, IN0d, SW[2:0], DATA0);
    
    //Four_to_One_Mux                                         (IN0  , IN1  , IN2  , IN3  , SEL, MUX_OUT)
    Four_to_One_Mux                         BLOCK6            (DATA0, DATA1, DATA2, DATA3, CNT, MUX_OUT);
    //Two_Bit_Counter                                         (clk,Q)
    Two_Bit_Counter                         BLOCK7            (clk_400Hz,CNT);
    //decoder_2_4                                             (IN,OUT)
    decoder_2_4                             BLOCK8            (CNT,an);
    //Seven_Seg_Decoder_Special                               (SEL,seg)
    Seven_Seg_Decoder_Special               BLOCK9            (MUX_OUT,seg);
    
    //StateMachine                                            (clk_5Hz,COUT      , CNT2, Ent_SW , Go_SW , Restart_SW , RST_SW ,  ctl, state)
    StateMachine                           STATEMACHINE       (clk_5Hz, COUT[1:0], CNT2, iSW[1] , iSW[2], iSW[3]     , iSW[4] ,  SW , state);
    
endmodule