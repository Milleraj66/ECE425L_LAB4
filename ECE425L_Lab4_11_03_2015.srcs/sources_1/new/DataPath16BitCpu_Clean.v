`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// AUTHOR: ARTHUR J. MILLER
// Module Name: DataPath16BitCpu_Clean
// Create Date: 11/30/2015 11:40:11 PM
// Edit Date  : 12/01/2015 Arthur J. Miller
// ECE425L LAB #4
// Purpose: 
//            Design and implement a structural model for the processor data path. 
//            Use your structural register file and ALU models from previous laboratories 
//            to implement your system. No behavioral Verilog modeling is allowed. 
//            The only exception is that you may design components to calculate offset 
//            values for BNE, LW, SW and the JMP operation. Your data path should 
//            combine instruction and data memory fetch and store into a single memory 
//            access subsystem. Use multiplexers to select and route data to the 
//            memory access subsystem and route retrieved data appropriately.Your data 
//            path should be implemented as a single entity with a structural architecture
//            using as many structural components as necessary. Document all control 
//            settings and outputs from the data path. Remember that you must include
//            the system clock to trigger data storage elements. Note that, in the design 
//            of the data path, you should use structural models for both the register 
//            file and the ALU. You may modify your structural models as necessary to suite 
//            your particular design. It is unlikely that your register file will require
//            modification, but the control signals to the ALU may be reconfigured to more
//            effectively interpret instructions.

//          NOTE: Control Unit Bits:
//                Control = {Jump,RegWrite,AluSrc,MemWrite,ALUop2,ALUop1,ALUop0,MemtoReg,MemRead,Branch,RegDst}[11b]
//          NOTE: Instruction Break Down R-Type
//                Ins[15:12] = OP
//                Ins[11:8] = Rs
//                Ins[7:4] = Rt
//                Ins[3:0] = Rd
//          NOTE: Instruction Break Down I-Type
//                Ins[15:12] = OP
//                Ins[11:8] = Rs
//                Ins[7:4] = Rt
//                Ins[3:0] = Offset
//////////////////////////////////////////////////////////////////////////////////

// (Clock[1b],RegisterReset,InstructionRestart,PC[3:0],Ins[15:12],ControlSig[11b],A[16b],B[3:0],ALU_Out[3:0],RegFileInAddr[4b],DataMemOut[3:0])
module DataPath16BitCpu_Clean(Clk,Reset,Restart,PC_4bit,Ins_4bit,Control,A,B_4bit,ALU_Out_4bit,Caddr,Mem_Out_4bit);
    // **** Inputs
    input Clk;                          // System Clock
    input Reset;                        // Reset File Registers
    input Restart;                      // Reset Program Counter to zero
    // **** Outputs
    output [10:0] Control;              // 11 bit Control signals
    output [15:0] A;                    // Rs contents
    output [3:0] Caddr;                 // Write Address into Register File
    // **** Outputs to be used as LED's
    output wire [3:0] PC_4bit;          // First four bits of PC
    assign PC_4bit = PC[3:0];
    output wire [3:0] Ins_4bit;         // Last four bits of Instruction (the opcode)
    assign Ins_4bit = Ins[15:12];
    output wire [3:0] ALU_Out_4bit;     // First four bits of ALU_Out
    assign ALU_Out_4bit = ALU_Out[3:0];
    output wire [3:0] B_4bit;           // First four bits of B
    assign B_4bit = B[3:0]; 
    output wire [3:0] Mem_Out_4bit;     // First four bits of Memory Output
    assign Mem_Out_4bit = Mem_Out[3:0]; 
    // **** Intermidiate Wires
    wire [15:0] PC;                         // Program Counter
    wire [15:0] Ins;                        // Instruction from Instruction Memory
    wire [3:0] Caddr;                       // Register Write Address (Rt or Rd)
    wire [15:0] A, B;                       // File Register output's
    wire [15:0] Offset;                     // Sign Extended Offset                 
    wire [15:0] ALUsrc_Out;                 // ALU Source mux output. Selects input 2 for ALU
    wire [15:0] ALU_Out;                    // ALU Output
    wire [15:0] Mem_Out;                    // Data Memory Output
    wire [15:0] MemToReg_Out;               // Reegister File Write input. Memory Data or ALU_Out data
    wire [15:0] PC_PlusONE_Out;             // PC + 1 
    wire [15:0] PC_PlusOnePlusOFFSET_Out;   // (PC + 1) + Offset
    wire [15:0] PC_Branch_Out;              // Mux output either PC+1 or PC+1+Offset
    wire [15:0] PC_Next;                    // Mux output either PC_Branch ouput of JumpAddress
    wire [10:0] Control;                    // Control Signals
    wire BranchSelect;                      // BranchControlSignal AND ZeroFlag(Eq)
    wire nEq;                               // Zero Flag from ALU
    wire PlusONE_Cout,PlusONE_Ov,OFFSET_Cout,OFFSET_Ov,ALU_Cout,ALU_Lt,ALU_Gt,ALU_Ov; // Flags
    
    
    //*** 1. 16bit Program Counter(PC)
    //  inputs: Clock, Async Reset, New instruction address
    //  ouput: Instruction Address goes to Instruction Memory & Instruction Address Incrementer -> Jump
    //                                              (Clock[1b],AsyncReset[ActiveLowLogic][1b],NextAddr[16b],CurrectAddr[16b])              
    Register16b             ProgramCounter          (Clk,Restart,PC_Next,PC);


    //*** 2. Instruction Memory Module: 16bit X 64
    //  input: 16bit instruction address from PC
    //  procedure: Decode inst. addr. and ouput reg value
    //  output: 16bit instrcution register value [The Instructions]
    //          [OP:Rs:Rt:Rd] each 4bit
    // (Data I/O Address[16b], read,Write to memory if 1[1b], Data to write[16b], Data to read[16b])              
    Instr_Mem   Instruction_mem (PC,1'b1,1'b0,16'b0000_0000_0000_0000,Ins);
    
    //*** 3. 2-to-1(4bit) RegDst MUX
    //  input: I0 = Rt, I1 = Rd
    //  procedure: Select = RegDst. selects the register destination when writing to Reg File
    //  output: Caddr(4bit)
    //                                   (Enable,Select,Input1[4b],Input0[4b],Output[4])
    Mux4bit_2to1            RegDst_MUX   (1'b1,Control[0],Ins[3:0],Ins[7:4],Caddr);
    
    //*** 4. 16x16 Register File Module
    //  input: Reset = Async Reset, Addr = Rs, Baddr = Rt, Caddr = Rd/Rt, WriteData = MemToReg_Out [Found Later]
    //  ouput: A(16bit),B(16bit)
    //                (RegOut1[16b],RegOut2[16b],RegIn[16b],RegAddressA,RegAddressB,RegAddressC,EnableLW,ClearAll,Clock) 
    Reg_File16b             REG_FILE     (A,B,MemToReg_Out,Ins[11:8],Ins[7:4],Caddr,Control[9],Reset,Clk);
    
    //*** 5. Behavioral Control Module
    //  input: Opcode(4bit)
    //  ouput: Control Signals
    //                                     (4bit  , 11bit)
    ControlUnit4bit         ControlUnit    (Ins[15:12], Control);
    
    //*** 6. Sign Extending Module
    //  input: Rd(4bit) which will be offset for LW,SW,BEQ
    //  output: SignExtended Offset (16bit)
    //                      (Rd    , SignExtendedRd0
    SignExtend_4to16        SIGN_EXTEND     (Ins[3:0], Offset);
    
    //*** 7. 2-to-1(16bit) ALUSrc Mux Module
    //  input: B(16bit),SignExtteneded Offset(16bit)
    //  procedure: Control input selects depending on Instruction Type
    //  output: Input2 = Y(16bit) for ALU
    //                                   (Enable,Select,Input1[16b],Input0[16b],Output[16b])
    Mux16bit_2to1           ALUsrc_MUX   (1'b1,Control[8],Offset,B,ALUsrc_Out);
    
    //*** 8. ALU Module
    //  input: Input1 = A(16bit), Input2 = ALUsrc_Out(16bit), Opcode = ALUop Control Signals
    //  output: ALUout =Out(16bit), ZeroFlag(1bit)
    //                              (input1(16b),input2(16b),Output(16b),CarryOut,LessThan,EqualTo,GreaterThan,Overflow,Opcode) 
    ALU                     ALU1    (A ,ALUsrc_Out,ALU_Out,ALU_Cout,ALU_Lt ,nEq ,ALU_Gt ,ALU_Ov ,Control[6:4]);
    
    //*** 9. Data Memory Module
    //  input: DataMemoryAddress = ALUout = Out(16bit), DataMemoryValue = B(16bit)
    //  output: ReadData = Mem_Out
    //                               (Clk,Data I/O Address[16b],Read,Write to memory if 1[1b], Data to write[16b], Data read[16b])
    Data_mem        DATA_MEMORY      (Clk,ALU_Out,Control[2],Control[7],B,Mem_Out);
    
    //*** 10. 2-to1(16bit) MemToReg Mux Module
    //  input: I0 = ReadData = Mem_Out, I1 = ALUout
    //  procedure: Select = MemToReg Control Signal
    //  output: connects to WriteData of RegFile = C(16bit)
    //                                     (Enable,Select,Input1[16b],Input0[16b],Output[16b])
    Mux16bit_2to1           MemToReg_MUX   (1'b1,Control[3],Mem_Out,ALU_Out,MemToReg_Out);
    
    //***** For Branch and Jump and Increment Counter
    //*** 11. increment Program counter
    //                                           (input1(16b),input2(16b),CarryIn,CarryOut,Overflow,Output(16b))
    FullAdder2s_16bit         PC_PlusONE         (PC  , 16'b0000_0000_0000_0001   ,1'b0  ,PlusONE_Cout,PlusONE_Ov , PC_PlusONE_Out);
    
    //*** 12. Branch
    //  Add 16 bit sing extended offset from instruction 
    //                     input1(16b),input2(16b),CarryIn,CarryOut,Overflow,Output(16b)
    FullAdder2s_16bit         PC_OFFSET         (PC_PlusONE_Out  , Offset ,1'b0    ,OFFSET_Cout,OFFSET_Ov , PC_PlusOnePlusOFFSET_Out);
    //  Mux between PC+1 and Branch Address depending Branch Control signal AND zero flag
    // And zero flag from ALU with branch control signal
    and(BranchSelect,Control[1],nEq);
    //                                   (Enable,Select,Input1[16b],Input0[16b],Output[16b])
    Mux16bit_2to1           Branch_MUX   (1'b1,BranchSelect,PC_PlusOnePlusOFFSET_Out,PC_PlusONE_Out,PC_Branch_Out);
    
    //*** 13. Jump
    // Mux output of PC_MUX and Jump address. Select control 1: jump & 0:PC_MUX output 
    //                                 (Enable,Select,Input1[16],Input0[16],Output[16]
    Mux16bit_2to1           Jump_MUX   (1'b1,Control[10],Ins,PC_Branch_Out,PC_Next);
     
endmodule

