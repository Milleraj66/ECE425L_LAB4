`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// AUTHOR: ARTHUR J. MILLER & Bibek B.
// Module Name: Lt
// Create Date: 10/15/2015 08:51:58 PM
// ECE425L LAB #2
// Purpose: Send flage if X is less than Y
//          Skeleton -> just send flag 
//////////////////////////////////////////////////////////////////////////////////

//         input1(16b),input2(16b),Flag(16b) 16 bit flag. 0 == FALSE, not zero == TRUE
module Lt(X          ,Y          ,Z);
    //inputs 
    input [15:0] X,Y;
    //ouputs
    output [15:0] Z;
    wire TmpLt, nEq, TmpZ,CoutLt,OvLt;
    wire [15:0] Zeq,ZLt;
   
    //**** 1. Set Less than flag: Check sign bit of 2's comp (of X-Y) 1==NEG,0==POS
    // a. If X is Less Than Y then X-Y == NEG
    //                                       input1(16b),input2(16b),CarryIn,CarryOut, Overflow  ,Output(16b)
    FullAdder2s_16bit       FA_Lt           (X          ,Y          ,1'b1    ,CoutLt     , OvLt        ,ZLt);    
    // Check sign bit. If 1 then X<Y because Z is Negative. Else if 0 X==Y or X>Y
    or(TmpLt,1'b0,ZLt[15]);
    // b. 16 bit masked flag. 16'b0 == FALSE, 16'b1 == TRUE
    ///and AND_16flag[15:0] (Z,1,TmpZ);
    and AND_16flag[15:0] (Z,1'b1,TmpLt);
endmodule
