`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// AUTHOR: ARTHUR J. MILLER & Bibek B.
// Module Name: TB_Memory_16bAddr
// Create Date: 11/10/2015 04:00:17 PM
// ECE425L LAB #4 Problem 1
// Purpose: TestBench for,
//          Behavior Module to simulate memory for 16 address access
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


module TB_Memory_16bAddr();
    reg [15:0] Addr;
    reg Write;
    reg [15:0] Data_In;
    wire [15:0] Data_Out;
    
    // Instantiate working module Unit Under Test (UUT)
    // (Data I/O Address[16b], Write to memory if 1[1b], Data to write[16b], Data to read[16b])                  
    Memory_16bAddr      UUT       (Addr,Write,Data_In,Data_Out);
    
    //Testbench Stimulus
    initial 
        begin
        //Clk = 0; 
        // Write Data into memory
        #5  Addr = 0; Write = 1; Data_In = 2;
        #10 Addr = 1; Write = 1; Data_In = 4;
        #10 Addr = 2; Write = 1; Data_In = 8;
        #10 Addr = 3; Write = 1; Data_In = 16;
        #10 Addr = 4; Write = 1; Data_In = 32;
        // Read Data from memory
        #10 Addr = 1; Write = 0; Data_In = 0;
        #10 Addr = 2; Write = 0; Data_In = 0;
        #10 Addr = 3; Write = 0; Data_In = 0;
        #10 Addr = 4; Write = 0; Data_In = 0;
        end
    
//    always
//        #5 Clk = !Clk;
        
//    initial 
//        #400 $finish;
endmodule
