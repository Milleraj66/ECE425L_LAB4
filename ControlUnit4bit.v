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
//          4: ALUop
//          5: MemWrite
//          6: AluSrc
//          7: RegWrite

//          NOTE: Can have up to 16 OPCODES or instructions

//////////////////////////////////////////////////////////////////////////////////

module ControlUnit4bit(OPCODE, Control);
    input [3:0] OPCODE;
    output [7:0] Control;
    
    case(OPCODE)
        0 : assign Control = 100Z_0100;
        1 : assign Control = 100Z_0100;
        2 : assign Control = 100Z_0100;
        3 : assign Control = 100Z_0100;
        4 : assign Control = 100Z_0100;
        5 : assign Control = 011Z_Z101;       
        6 : assign Control = 011Z_Z101;
        7 : assign Control = 011Z_Z101;
        8 : assign Control = ZZZZ_ZZZZ;
            default : $display  ("Need to complete");
      endcase
endmodule
