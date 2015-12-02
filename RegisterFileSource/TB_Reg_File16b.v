`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// AUTHOR: ARTHUR J. MILLER & Bibek B.
// Module Name: TB_Reg_File16b
// Create Date: 10/27/2015 06:37:50 PM
// Edit Date: 10/29/2015 : Arthur J. Miller
// ECE425L LAB #3
// Purpose: Testbench for 16x16bit Register File
//          Output should show A=5,B=6 then A=1,B=2 Every 3 clock cycles (WHEN LOAD IS ZERO)
//          All 16 registers are tested
//          There are portions of X in transitions when A,B display registers before
//////////////////////////////////////////////////////////////////////////////////

module TB_Reg_File16b();
    wire [15:0] A,B;
    reg [15:0] C;
    reg [3:0] Aaddr,Baddr,Caddr;
    reg Load,Clear,Clk;
    //                              (RegOut1(16b),RegOut2(16b),RegIn(16b),RegAddressA,RegAddressB,RegAddressC,EnableLW,ClearAll,Clock) 
    Reg_File16b         REGFILE     (A,B,C,Aaddr,Baddr,Caddr,Load,Clear,Clk);
    
    //Testbench Stimulus
    initial 
        begin
        Clk = 0; 
        
        //*** TEST REG's:0,1,2,3 ****//
        // Load 5 into A
        #10 C=5;Aaddr=0;Baddr=1;Caddr=0;Load=1;Clear=1;
        // Load 6 into B
        #10 C=6;Aaddr=0;Baddr=1;Caddr=1;Load=1;Clear=1;
        // A = 5, B = 6
        #10 C=7;Aaddr=0;Baddr=1;Caddr=1;Load=0;Clear=1;
        // Async Reset
        //#10 Clear=0;
        // Load 1 into A
        #10 C=1;Aaddr=0;Baddr=1;Caddr=2;Load=1;Clear=1;
        // Load 2 into B
        #10 C=2;Aaddr=2;Baddr=3;Caddr=3;Load=1;Clear=1;
        // A = 1, B = 2
        #10 C=3;Aaddr=2;Baddr=3;Caddr=3;Load=0;Clear=1;

        //*** TEST REG's:4,5,6,7 ****//
        // Load 5 into A
        #10 C=5;Aaddr=2;Baddr=3;Caddr=4;Load=1;Clear=1;
        // Load 6 into B
        #10 C=6;Aaddr=4;Baddr=5;Caddr=5;Load=1;Clear=1;
        // A = 5, B = 6
        #10 C=7;Aaddr=4;Baddr=5;Caddr=5;Load=0;Clear=1;
        // Async Reset
        #10 Clear=0;
        // Load 1 into A
        #10 C=1;Aaddr=6;Baddr=7;Caddr=6;Load=1;Clear=1;
        // Load 2 into B
        #10 C=2;Aaddr=6;Baddr=7;Caddr=7;Load=1;Clear=1;
        // A = 1, B = 2
        #10 C=3;Aaddr=6;Baddr=7;Caddr=7;Load=0;Clear=1;
        
        //*** TEST REG's:8,9,10,11 ****//
        // Load 5 into A
        #10 C=5;Aaddr=8;Baddr=9;Caddr=8;Load=1;Clear=1;
        // Load 6 into B
        #10 C=6;Aaddr=8;Baddr=9;Caddr=9;Load=1;Clear=1;
        // A = 5, B = 6
        #10 C=7;Aaddr=8;Baddr=9;Caddr=9;Load=0;Clear=1;
        // Async Reset
        //#10 Clear=0;
        // Load 1 into A
        #10 C=1;Aaddr=10;Baddr=11;Caddr=10;Load=1;Clear=1;
        // Load 2 into B
        #10 C=2;Aaddr=10;Baddr=11;Caddr=11;Load=1;Clear=1;
        // A = 1, B = 2
        #10 C=3;Aaddr=10;Baddr=11;Caddr=11;Load=0;Clear=1;
        
        //*** TEST REG's:12,13,14,15 ****//
        // Load 5 into A
        #10 C=5;Aaddr=12;Baddr=13;Caddr=12;Load=1;Clear=1;
        // Load 6 into B
        #10 C=6;Aaddr=12;Baddr=13;Caddr=13;Load=1;Clear=1;
        // A = 5, B = 6
        #10 C=7;Aaddr=12;Baddr=13;Caddr=13;Load=0;Clear=1;
        // Async Reset
        #10 Clear=0;
        // Load 1 into A
        #10 C=1;Aaddr=14;Baddr=15;Caddr=14;Load=1;Clear=1;
        // Load 2 into B
        #10 C=2;Aaddr=14;Baddr=15;Caddr=15;Load=1;Clear=1;
        // A = 1, B = 2
        #10 C=3;Aaddr=14;Baddr=15;Caddr=15;Load=0;Clear=1;
        end
        
    always
        #5 Clk = !Clk;
        
    initial 
        #400 $finish;
endmodule
