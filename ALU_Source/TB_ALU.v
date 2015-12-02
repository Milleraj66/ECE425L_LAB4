`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// AUTHOR: ARTHUR J. MILLER
// Module Name: TB_ALU
// Create Date: 10/15/2015 01:39:25 PM
// Modified Date: 10/20/2015 ARTHUR J. MILLER
// ECE425L LAB #2
// Purpose: The objective of this lab is to develop structural and behavioral models for an ALU. 
//          Test Bench
//////////////////////////////////////////////////////////////////////////////////

module TB_ALU();
    //inputs
    reg [15:0] X,Y;
    reg Cin;
    reg [2:0] Opcode;
    //ouputs
    wire Cout,Lt,Eq,Gt,Ov;
    wire [15:0] Out;
    //                           input1(16b),input2(16b),Output(16b),CarryIn,CarryOut,LessThan,EqualTo,GreaterThan,Overflow,Opcode 
    ALU             ALU1        (X          ,Y          ,Out        ,Cin    ,Cout    ,Lt      ,Eq     ,Gt         ,Ov      ,Opcode);
      
    // Test Bench Stimulus
    initial
        begin
            //***** Test Opcode 000 -> Unsigned Addition
            // Expected Result: 500
            X = 200; Y = 300; Cin = 0; Opcode = 3'b000;
            // Expected Result: 501
            #5 X = 200; Y = 300; Cin = 1; Opcode = 3'b000;
            // Expected Result: Not 198
            #5  X = 200; Y = -2; Cin = 0; Opcode = 3'b000;
            
            //***** Test Opcode 001 -> Signed Addition
            // Expected Result: 500
            #5 X = 200; Y = 300; Cin = 0; Opcode = 3'b001;
            // Expected Result: -100
            #5 X = 200; Y = 300; Cin = 1; Opcode = 3'b001;
            // Expected Result: 100
            #5  X = 200; Y = -100; Cin = 0; Opcode = 3'b001;
            // Expected Result: 100
            #5  X = -200; Y = 300; Cin = 0; Opcode = 3'b001;
            // Expected Result: 300
            #5  X = 200; Y = -100; Cin = 1; Opcode = 3'b001;
            // Expected Result: -400
            #5  X = -100; Y = 300; Cin = 1; Opcode = 3'b001;
            
            //****** Test Opcode 010 -> Bitwise AND
            #5  X = 16'b1000_1000_1000_1000; Y = 16'b1111_1111_1111_1111; Cin = 0; Opcode = 3'b010;
            #5  X = 16'b0001_0001_0001_0001; Y = 16'b1111_1111_1111_1111; Cin = 0; Opcode = 3'b010;
            #5  X = 16'b0000_0000_0000_0000; Y = 16'b1111_1111_1111_1111; Cin = 0; Opcode = 3'b010;
            #5  X = 16'b1111_1111_1111_1111; Y = 16'b0000_0000_0000_0000; Cin = 0; Opcode = 3'b010;
            #5  X = 16'b1111_1111_1111_1111; Y = 16'b1111_1111_1111_1111; Cin = 0; Opcode = 3'b010;
            
            //***** Test Opcode 011 -> Bitwise OR
            #5  X = 16'b1000_1000_1000_1000; Y = 16'b1111_1111_1111_1111; Cin = 0; Opcode = 3'b011;
            #5  X = 16'b0001_0001_0001_0001; Y = 16'b1111_1111_1111_1111; Cin = 0; Opcode = 3'b011;
            #5  X = 16'b0000_0000_0000_0000; Y = 16'b1111_1111_1111_1111; Cin = 0; Opcode = 3'b011;
            #5  X = 16'b1111_1111_1111_1111; Y = 16'b0000_0000_0000_0000; Cin = 0; Opcode = 3'b011;
            #5  X = 16'b1111_1111_1111_1111; Y = 16'b1111_1111_1111_1111; Cin = 0; Opcode = 3'b011;
            
            //***** Test Opcode 100 -> Set on Less Than
            // Expected Result: Not LT -> zero
            #5 X = 200; Y = 200; Cin = 0; Opcode = 3'b100;
            // Expected Result:     LT -> non zero
            #5 X = 100; Y = 200; Cin = 0; Opcode = 3'b100;
            // Expected Result: Not LT -> zero
            #5  X = 200; Y = 100; Cin = 0; Opcode = 3'b100;
            // Expected Result:     LT -> non zero
            #5  X = -200; Y = 100; Cin = 0; Opcode = 3'b100;
            // Expected Result: Not LT -> zero
            #5  X = 1; Y = -1; Cin = 0; Opcode = 3'b100;
            // Expected Result:     LT -> non zero
            #5 X = -200; Y = -100; Cin = 0; Opcode = 3'b100;
            
            //****** Test Opcode 101 -> Branch if not Equal to
            // Expected Result: Not EQ -> non zero
            #5 X = 100; Y = 200; Cin = 0; Opcode = 3'b101;
            // Expected Result:     EQ ->     zero
            #5 X = 200; Y = 200; Cin = 0; Opcode = 3'b101;
            // Expected Result: Not EQ -> non zero
            #5  X = -200; Y = 100; Cin = 0; Opcode = 3'b101;
            // Expected Result:     EQ ->     zero
            #5  X = -200; Y = -200; Cin = 0; Opcode = 3'b101;
            // Expected Result: Not EQ -> non zero
            #5  X = 1; Y = -1; Cin = 0; Opcode = 3'b101;
          
            //****** Test Overflow
            #5 X = 32000; Y = 10000; Cin = 0; Opcode = 3'b001;
            #5 X = 10000; Y = -32768; Cin = 1; Opcode = 3'b001;
            #5 X = 1; Y = -1000000; Cin = 1; Opcode = 3'b001;
            #5 X = 1; Y = 32800; Cin = 1; Opcode = 3'b001;                     
        end
endmodule
