`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// AUTHOR: ARTHUR J. MILLER
// Module Name: Data_mem
// Create Date: 11/24/2015 02:01:01 PM
// ECE425L LAB #4 Problem 1
// Purpose: Initalized data memory 
//////////////////////////////////////////////////////////////////////////////////

// (Clock,Data I/O Address[16b], Write to memory if 1[1b], Data to write[16b], Data to read[16b])                  
module Data_mem(Clk,Addr,Read,Write,Data_In,Data_Out);
    input Clk;
    input [15:0] Addr;
    input Read;
    input Write;
    input [15:0] Data_In;
    output [15:0] Data_Out;
    reg [15:0] Data_Out;
    reg [15:0] my_memory [0:63]; // Memory Width: 16bits, Memory Depth: 0 to 63?
    
    // Intial Data Memory Values for Program
    initial
        begin
            my_memory[0] = 16'h0008;
            my_memory[1] = 16'h0002;
            my_memory[2] = 16'h0003;
            my_memory[3] = 16'h0006;
            my_memory[4] = 16'h0008;
            my_memory[5] = 16'h000A;   
        end
    
    always @(negedge Clk)
    begin 
        // Write Data
        if(Write)
            begin
            my_memory[Addr] = Data_In;
            end
        // Always read data (wont hurt)
        Data_Out = my_memory[Addr];
    end
    
    
endmodule