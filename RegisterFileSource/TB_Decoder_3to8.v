`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// AUTHOR: ARTHUR J. MILLER
// Create Date: 10/03/2015 08:58:39 PM
// ECE425L LAB #1, Problem 1
// Purpose: Develope a Verilog structural model for a 16-bit 2-to-1 MUX and a 3-to-8
//          decoder includeing ENABLE signals. Develop a testbench, perofrm a waveform
//          simulation, and demonstrate the output to the Instructor.

// Variables:
//          E : Enable Input
//          S : Selecting Input
//          X = X2X1X0 : 3 bit input  
//          Z : 8 possile outputs, so 8 bit output 

//////////////////////////////////////////////////////////////////////////////////


module TB_Decoder_3to8();
    reg E;
    reg [2:0] X;
    wire [7:0] Z;
    

    // instantiate decoder module
    //                                               Enable,Input(3b),Output(8b)                
    Decoder_3to8         DECODER1            (E     ,X        ,Z);

    
    //Behavioral code block generates stimulus to test circuit
    initial 
         begin
            // Enable zero, output should be zero
            E = 1'b0; X = 3'b111;
            #50;
            //*********************//
            // Enable 1
            // X = 000
            // Z should be 0
            E = 1'b1; X = 3'b000;
            #50;
            //*********************//
            //*********************//
            // Enable 1
            // X = 001
            // Z should be 1
            E = 1'b1; X = 3'b001;
            #50;
            //*********************//
            //*********************//
            // Enable 1
            // X = 010
            // Z should be 2
            E = 1'b1; X = 3'b010;
            #50;
            //*********************//
            //*********************//
            // Enable 1
            // X = 011
            // Z should be 3
            E = 1'b1; X = 3'b011;
            #50;
            //*********************//
            //*********************//
            // Enable 1
            // X = 100
            // Z should be 4
            E = 1'b1; X = 3'b100;
            #50;
            //*********************//
            //*********************//
            // Enable 1
            // X = 101
            // Z should be 5
            E = 1'b1; X = 3'b101;
            #50;
            //*********************//
            //*********************//
            // Enable 1
            // X = 110
            // Z should be 6
            E = 1'b1; X = 3'b110;
            #50;
            //*********************//
            //*********************//
            // Enable 1
            // X = 111
            // Z should be 7
            E = 1'b1; X = 3'b111;
            #50;
            //*********************//
 
          end

endmodule
