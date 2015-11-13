`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// AUTHOR: ARTHUR J. MILLER & Bibek B.
// Module Name: SignExtend_4to16
// Create Date: 11/10/2015 04:57:25 PM
// ECE425L LAB #4
// Purpose: Sign extend 4bit number to 16 bit number
//////////////////////////////////////////////////////////////////////////////////

//                      (Rd    , SignExtendedRd0
module SignExtend_4to16(Data_In, Data_Out);
    input [3:0] Data_In;
    output [15:0] Data_Out;
    wire [15:0] SE1,SE2;
    
    and a1[15:3] (SE2, Data_In[3],1);
    and a2[2:0] (SE2,Data_In,1);
    and a3[15:0] (Data_Out,SE2,1);
endmodule
