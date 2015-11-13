`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// AUTHOR: ARTHUR J. MILLER & Bibek B.
// Module Name: BNE
// Create Date: 10/15/2015 08:42:54 PM
// ECE425L LAB #2
// Purpose: Branch if Not Equal Operation
//          Skeleton -> just send flag 
//////////////////////////////////////////////////////////////////////////////////

// if ouput is zero -> they're equal[Flag == FALSE], else ouput is not equal[Flag == TRUE(non zero)]
//         input1(16b),input2(16b),Flag(16b)
module BNE(X          ,Y          ,Z);
    //inputs 
    input [15:0] X,Y;
    //ouputs
    output [15:0] Z;
    
    //***** 1. Set Equalto flag: flag == 1 if not equal. 0 if equal
    // if X XOR Y == 0 -> X = Y, else X != Y
    // if ouput is zero -> they're equal[Flag == FALSE], else ouput is not equal[Flag == TRUE(non zero)]
    xor XOR1 [15:0] (Z,X,Y);
endmodule
