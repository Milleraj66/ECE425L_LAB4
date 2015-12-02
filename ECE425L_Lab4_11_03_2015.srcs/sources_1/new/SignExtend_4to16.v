`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// AUTHOR: ARTHUR J. MILLER & Bibek B.
// Module Name: SignExtend_4to16
// Create Date: 11/10/2015 04:57:25 PM
// ECE425L LAB #4
// Purpose: Sign extend 4bit number to 16 bit number
//////////////////////////////////////////////////////////////////////////////////

//                      (Rd[4b] , SignExtendedRd[16b])
module SignExtend_4to16(Data_In, Data_Out);
    input signed [3:0] Data_In;
    output signed [15:0] Data_Out;
    
    // Implicitly sign extendeds
    assign Data_Out = Data_In;

endmodule
