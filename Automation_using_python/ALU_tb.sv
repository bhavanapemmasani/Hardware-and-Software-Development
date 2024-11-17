
    `timescale 1ns / 1ps

    module ALU_tb;

        // Declare inputs and outputs
        reg [31:0] A, B, Op;
        wire [31:0] Result;

        //Instantiate the DUT (Design Under Test)
        ALU DUT (
            .A(A),
            .B(B),
            .Op(Op),
            .Result(Result)
        );

        // Stimulus generation (test cases)
        initial begin
            A = 0; B = 0; Op = 0;
            
            // Apply different test cases
            #10;
            A = 10; B = 5; Op = 2;;
            #10;
            A = 15; B = 10; Op = 1;;
            #10;
            $finish;
        end

    endmodule
    