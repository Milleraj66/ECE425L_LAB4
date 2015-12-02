`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/24/2015 02:00:49 PM
// Design Name: 
// Module Name: Instr_Mem
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

// (Data I/O Address[16b], Write to memory if 1[1b], Data to write[16b], Data to read[16b])                  
module Instr_Mem(Addr,Read,Write,Data_In,Data_Out);
    input [15:0] Addr;
    input Read;
    input Write;
    input [15:0] Data_In;
    output [15:0] Data_Out;
    reg [15:0] Data_Out;
    reg [15:0] my_memory [0:63]; // Memory Width: 16bits, Memory Depth: 0 to 2^15-1?

    initial
        begin
            my_memory[0] = 16'b1000_0000_0000_0000;     // LW   $R0,0($R0)              # $R0 initally 0:   $R0 <= 8
            my_memory[1] = 16'b1000_0001_0001_0001;     // LW   $R1,1($R1)              # $R1 initally 0:   $R1 <= 2
            my_memory[2] = 16'b0010_0000_0001_0010;     // ADD  $R0,$R1,$R2             # $R2 = $R1 + $R2:  $R2 <= 10
            my_memory[3] = 16'b1000_0011_0011_0001;     // LW   $R3,1($R3)              # $R3 initially 0:  $R3 <= 2
            my_memory[4] = 16'b1110_0001_0011_0111;     // BNE  $R1,$R3,0               # $R1 = $R3 -> Dont Branch
            my_memory[5] = 16'b0000_0000_0010_0100;     // AND  $R0,$R2,$R4             #                   $R4 <= 8 
            my_memory[6] = 16'b0001_0000_0010_0101;     // OR   $R0,$R2,$R5             #                   $R5 <= 10
            // Loop 5 times
            my_memory[7] = 16'b0010_0001_0011_0011;     // ADD  $R1,$R3,$R3             # +2 until 10
            my_memory[8] = 16'b1110_0011_0010_1110;     // BNE  $R3,$R2,my_memory[7]    # $R1 = $R3 -> Dont Branch
            my_memory[9] = 16'hA616;                     // SW   $R2,6($R6)            # $R3 initially 0:  Mem[6+0] <= 10
            my_memory[10] = 16'hA737;                    // SW   $R3,7($R7)            # $R3 initially 0:  Mem[7+0] <= 10
            
            //my_memory[9] = 16'b1111_1111_1111_1100;     // JMP  1111_1111_1100 
            
        end
    
    // Read/Write Memory depending on Write value
    // Write: 1 -> Write into memory && Read memory at Addr
    // Write: 0 -> Read memory at Addr
    always @* 
    begin 
        // Write Data
        if(Write)
            begin
            my_memory [Addr] = Data_In;
            end
        // Read Data
        if(Read)
            begin
            // Read Value From Memory
            Data_Out = my_memory [Addr];
            end
    end
    
    
endmodule
