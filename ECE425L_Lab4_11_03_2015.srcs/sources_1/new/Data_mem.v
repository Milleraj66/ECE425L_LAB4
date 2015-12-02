`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// AUTHOR: ARTHUR J. MILLER
// Module Name: Data_mem
// Create Date: 11/24/2015 02:01:01 PM
// ECE425L LAB #4 Problem 1
// Purpose: Initalized data memory 
//////////////////////////////////////////////////////////////////////////////////

// (Data I/O Address[16b], Write to memory if 1[1b], Data to write[16b], Data to read[16b])                  
module Data_mem(Addr,Read,Write,Data_In,Data_Out);
    input [15:0] Addr;
    input Read;
    input Write;
    input [15:0] Data_In;
    output [15:0] Data_Out;
    reg [15:0] Data_Out;
    reg [15:0] my_memory [0:63]; // Memory Width: 16bits, Memory Depth: 0 to 2^15-1?

    initial
        begin
            my_memory[0] = 4'h0008;
            my_memory[1] = 4'h0002;
            my_memory[2] = 4'h0003;
            my_memory[3] = 4'h0006;
            my_memory[4] = 4'h0008;
            my_memory[5] = 4'h000A;
            
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