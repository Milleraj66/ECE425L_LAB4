`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// AUTHOR: ARTHUR J. MILLER & Bibek B.
// Module Name: Memory_16bAddr
// Create Date: 11/10/2015 03:32:39 PM
// ECE425L LAB #4 Problem 1
// Purpose: Behavior Module to simulate memory for 16 address access
//          Will give read/write access to memory
//          16b x 2^15 
//          Will be used for shared instruction and data memory for Data Flow
//          Credits: http://www.asic-world.com/verilog/memory_fsm1.html

//          Paramaters: 
//              Inputs:
//                      Addr: indexing address 
//                      Write: Write Signal-> will write to memory if 1
//                      Data_In: Data to be written into my_memory[Addr]
//              Outputs:
//                      Data_Out: horizontal line of datas
//              NOTE:
//                      I believe that when a write is enabled, the output Data_Out
//                      Will still hold the previous value
//////////////////////////////////////////////////////////////////////////////////

// (Data I/O Address[16b], Write to memory if 1[1b], Data to write[16b], Data to read[16b])                  
module Memory_16bAddr(Addr,Read,Write,Data_In,Data_Out);
    input [15:0] Addr;
    input Read;
    input Write;
    input [15:0] Data_In;
    output [15:0] Data_Out;
    reg [15:0] Data_Out;
    reg [15:0] my_memory [0:63]; // Memory Width: 16bits, Memory Depth: 0 to 2^15-1?
    
    parameter [15:0] D0 = 0; 
    parameter [15:0] D1 = 0;
    parameter [15:0] D2 = 0;
    
    initial
        begin
            my_memory[0] = D0;
            my_memory[1] = D1;
            my_memory[2] = D2; 
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
