`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/24/2015 04:07:45 PM
// Design Name: 
// Module Name: TB_ProgramCounter
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


module TB_ProgramCounter();
    reg Clk;
    reg [15:0] PC_Next;
    wire [15:0] PC,PC_PlusONE_Out,PC_PlusOnePlusOFFSET_Out;
    // (Clock,AsyncReset[ActiveLowLogic],RegInput,RegOutput)              
    Register16b             ProgramCounter          (Clk,1'b1,PC_Next,PC);

    
    initial
        begin
        Clk = 0;
        PC_Next = 0;
        end
    always
        begin
        #5 Clk = !Clk; 
        end
    initial 
        #100 $finish;
    

endmodule
