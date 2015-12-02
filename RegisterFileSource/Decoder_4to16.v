`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// AUTHOR: ARTHUR J. MILLER
// Create Date: 10/20/2015 05:23:12 PM
// Module Name: Decoder_4to16
// ECE425L LAB #3
// Purpose: 4to16 decoder using 3

// TODO : Either reverse output logic to be logic low
//        or make current circuit all ouput low when disabled
//        rather than output high
//////////////////////////////////////////////////////////////////////////////////

module Decoder_4to16(E,X,Z);
    input E;
    input [3:0] X;
    output [15:0] Z;  
    //wire    [15:0] Z;  
    
    not(X3not,X[3]);
    and(E1,X3not,E);
    and(E2,X[3],E);
    //                               Enable,Input(3b),Output(8b)                
    Decoder_3to8        DEC1        (E1     ,X[2:0]        ,Z[7:0]);
    //                               Enable,Input(3b),Output(8b)                
    Decoder_3to8        DEC2        (E2      ,X[2:0]        ,Z[15:8]);
    // ouput low logic
    //not n1[15:0] (Zn,Z);
endmodule
