`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// AUTHOR: ARTHUR J. MILLER & Bibek B.
// Module Name: DataPath16BitCpu
// Create Date: 11/03/2015 05:31:37 PM
// Edit Date: 11/10/2015 ARTHUR J. MILLER & Bibek B.
// ECE425L LAB #4 Problem 1
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

//          NOTE: Initialize PC??
//          NOTE: 
//                Ins[15:12] = OP
//                Ins[11:8] = Rs
//                Ins[7:4] = Rt
//                Ins[3:0] = Rd
//          xTODO: Testbench Sign Extend
//          xTODO: Caddr_Mux needs to be 4bit
//          xTODO: ALU Input bits???
//          NOTE: ALU Cin = 0
//          TODO: Fix Unsigned Adder
//          TODO: OPCODE for ALU? 
//          TODO: PC_MUX Control anded with zero flag
//          TODO: Implement JUmp
//          NOTE: PC or PC_PONE??

//          TODO: Control signal for Caddr_Mux 
//          TODO: Control signal LOAD/Clear for RegFile
//          TODO: Control Signal for B_MUX
//          TODO: Control signal Memroy write
//          TODO: Control Module
//////////////////////////////////////////////////////////////////////////////////

// Driver module for CPU
module DataPath16BitCpu(Clk);
    wire [15:0] Ins;
    wire [3:0] Caddr;
    wire [15:0] Offset;
    wire [15:0] B_MUX_Out;
    wire [15:0] ALU_Out;
    wire [15:0] Mem_Out;
    wire [15:0] PC_Next;
    //wire Cin    ,Cout    ,Lt      ,Eq     ,Gt         ,Ov ;
    input Clk;
    
    //*** 1. 16bit Program Counter(PC) Reg?
    //  input: New instruction address
    //  ouput: Instruction Address goes to Memory & Instruction Address Incrementer -> Jump
    //                 Clock,AsyncReset,RegInput,RegOutput               
    Register16b             PC          (Clk  ,     0,      PC_Next,PC);
    
    //*** 2. 16x(2^16) Memory Module?
    //  input: 16bit instruction address from PC
    //  procedure: Decode inst. addr. and ouput reg value
    //  output: 16bit instrcution register value [The Instructions]
    //          [OP:Rs:Rt:Rd] each 4bit
    // (Data I/O Address[16b], Write to memory if 1[1b], Data to write[16b], Data to read[16b])                  
    Memory_16bAddr          INST_MEMORY      (PC,1'b0,Data_In,Ins);
    
    //*** 3. 2-to-1(4bit) MUX
    //  input: I0 = Rt, I1 = Rd
    //  procdure: Selected from control depending on Instruction Type
    //  output: Caddr(4bit)
    //                                     Enable,Select,Input1[4b],Input0[4b],Output[4]
    Mux4bit_2to1            Caddr_MUX   (1'b1     ,   S  , Ins[3:0]   , Ins[7:4]   , Caddr);
    
    //*** 4. 16x16 Register File Module
    //  input: Addr = Rs, Baddr = Rt, Caddr = Rd/Rt, WriteData = C [Found Later]
    //  ouput: A(16bit),B(16bit)
    //                (RegOut1[16b],RegOut2[16b],RegIn[16b],RegAddressA,RegAddressB,RegAddressC,EnableLW,ClearAll,Clock) 
    Reg_File16b             REG_FILE     (A,B,C,Ins[11:8],Ins[7:4],Caddr,Load,Clear,Clk);
    
    //*** 5. Behavioral Control Module
    //  input: Opcode(4bit)
    //  ouput: Control Signals
    
    //*** 6. Sign Extending Module
    //  input: Rd(4bit) which will be offset for LW,SW,BEQ
    //  output: SignExtended Offset (16bit)
    //                      (Rd    , SignExtendedRd0
    SignExtend_4to16        SIGN_EXTEND     (Ins[3:0], Offset);
    
    //*** 7. 2-to-1(16bit) Mux Module
    //  input: B(16bit),SignExtteneded Offset(16bit)
    //  procedure: Control input selects depending on Instruction Type
    //  output: Input2 = Y(16bit) for ALU
    //                                   Enable,Select,Input1,Input0,Output
    Mux16bit_2to1           B_MUX   (1'b1     ,   S  , Offset   , B   , Y);
    
    //*** 8. ALU Module
    //  input: Input1 = X(16bit), Input2 = Y(16bit), Opcode(first 3 bits)
    //  output: ALUout =Out(16bit), ZeroFlag(1bit)
    //         input1(16b),input2(16b),Output(16b),CarryIn,CarryOut,LessThan,EqualTo,GreaterThan,Overflow,Opcode 
    ALU                     ALU1    (A          ,Y          ,ALU_Out        ,0'b0    ,Cout    ,Lt      ,Eq     ,Gt         ,Ov      ,Opcode);
    
    //*** 9. Data Memory Module
    //  input: DataMemoryAddress = ALUout = Out(16bit), DataMemoryValue = B(16bit)
    //  output: ReadData
    // (Data I/O Address[16b], Write to memory if 1[1b], Data to write[16b], Data to read[16b])                  
    Memory_16bAddr          DATA_MEMORY      (ALU_Out,Write,B,Mem_Out);
    
    //*** 10. 2-to1(16bit) Mux Module
    //  input: I0 = ReadData, I1 = ALUout
    //  procedure: Control input selects depending on instruction type
    //  output: connects to WriteData of RegFile = C(16bit)
    //                                   Enable,Select,Input1,Input0,Output
    Mux16bit_2to1           REGWRITE_MUX   (1'b1     ,   S  , Mem_Out   , ALU_Out   , C);
    
    // For Branch and Jump and Increment Counter
    //*** 11. 
    //  increment Program counter
    //                     input1(16b),input2(16b),CarryIn,CarryOut,Overflow,Output(16b)
    FullAdder_16bit         PC_PONE         (PC          , 1         ,0    ,Cout,    Ov      , PC_PONE);
    //  Add 12 bit offset from instruction 
    //                     input1(16b),input2(16b),CarryIn,CarryOut,Overflow,Output(16b)
    FullAdder_16bit         PC_OFFSET         (PC_PONE          ,    Offset      ,0    ,Cout,    Ov      , PC_POFF);
    //  Mux between different options depending on control signal from OPcode
    //                                   Enable,Select,Input1,Input0,Output
    Mux16bit_2to1           PC_MUX   (1'b1     ,   S  , PC_POFF   , PC_PONE   , PC_Next);
endmodule
