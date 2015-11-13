`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// AUTHOR: ARTHUR J. MILLER
// Module Name: TB_SignExtend_4to16
// Create Date: 11/12/2015 07:40:32 PM
// ECE425L LAB #4
// Purpose: Testbench for Sign extend 4bit number to 16 bit number
//////////////////////////////////////////////////////////////////////////////////


module TB_SignExtend_4to16();
    // Inputs
    reg [3:0] Data_In;
    // Outputs
    wire [15:0] Data_Out;
    
    //*** Instantiate Unit Under Test
    //                                  (Rd[4b] , SignExtendedRd[16b])
    SignExtend_4to16        UUT         (Data_In, Data_Out);
    
    //*** Testbench stimulus
    initial
        begin
        Data_In = 4'b0001;
        #5 Data_In = 4'b1001;
        #5 Data_In = 4'b0011;
        #5 Data_In = 4'b1011;
        end
endmodule
