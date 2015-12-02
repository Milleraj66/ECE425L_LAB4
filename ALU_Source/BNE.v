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
module BNE(X          ,Y          ,Z1, nEq);
    //inputs 
    input [15:0] X,Y;
    //ouputs
    output [15:0] Z1;
    output nEq;
    wire Cout, Ov_adders;
    //Ov_adders[1],Ov_adders[1]
    //                                       input1(16b),input2(16b),CarryIn,CarryOut , Overflow    ,Output(16b)
    FullAdder2s_16bit       Subtract_2s           (X          ,Y          ,1'b1    , Cout    ,Ov_adders ,Z1);

    //***** 3. BNE Flag
    // If A-B = 0 -> Flag == 0
    // Else A-B != 0 -> Flag == 1 -> BRANCH(Externally)
    or(nEq,Z1[0],Z1[1],Z1[2],Z1[3],Z1[4],Z1[5],Z1[6],Z1[7],Z1[8],Z1[9],Z1[10],Z1[11],Z1[12],Z1[13],Z1[14],Z1[15]);
endmodule
