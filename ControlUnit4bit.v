`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// AUTHOR: ARTHUR J. MILLER
// Create Date: 11/12/2015 08:32:29 PM
// Module Name: ControlUnit4bit
// Purpose: ECE425L Exp4
//          4bit control unit for single cycle 16bit processor

//          Control bits:
//          0: RegDst
//          1: Branch
//          2: MemRead
//          3: MemtoReg
//          4,5,6: ALUop
//          7: MemWrite
//          8: AluSrc
//          9: RegWrite
//          10: Jump

//          {RegWrite,AluSrc,MemWrite,ALUop[3b],MemtoReg,MemRead,Branch,RegDst}[10b]
//          NOTE: Can have up to 16 OPCODES or instructions
//          NOTE: Control signals that can be X(dont care) signals are placed to 1
//////////////////////////////////////////////////////////////////////////////////

//                    (4bit  , 11bit)
module ControlUnit4bit(OPCODE, Control);
    input [3:0] OPCODE;
    output reg [10:0] Control;
    always @(*)
    case(OPCODE)
        //         Control = {Jump,RegWrite,AluSrc,MemWrite,ALUop[3b],MemtoReg,MemRead,Branch,RegDst}[11b]
        // AND
        0 : assign Control = 11'b010_0010_0101;
        // OR
        1 : assign Control = 11'b010_0011_0101;
        // ADD 2's comp.
        2 : assign Control = 11'b010_0000_0101;
        // SUB 2's comp.
        6 : assign Control = 11'b010_0001_0101;
        // SLT
        7 : assign Control = 11'b010_0100_0101;
        // LW
        8 : assign Control = 11'b011_0001_1101;
        // SW       
        10 : assign Control = 11'b001_1001_1101;
        // BNE
        14 : assign Control = 11'b001_0001_1111;
        // JMP
        15 : assign Control = 11'b101_0001_1111;
            //default : $display  ("Need to complete");
      endcase
endmodule
