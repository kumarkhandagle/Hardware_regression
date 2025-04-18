`timescale 1ns/1ps

module tb_async_adder_random;
    reg [3:0] A;
    reg [3:0] B;
    wire [4:0] SUM;
    
    async_adder dut (
        .A(A),
        .B(B),
        .SUM(SUM)
    );
    
    integer i;
    reg [4:0] exp_sum;

    initial begin
        $display("Starting random testbench...");
        
        for (i = 0; i < 10; i = i + 1) begin
            A = $random;
            B = $random;
            exp_sum = A + B;

            #10; 
            $display("A = %b, B = %b, SUM = %b, EXPECTED = %b", A, B, SUM, exp_sum);
            assert (SUM == exp_sum)
                else $fatal("Assertion failed at i=%0d: %0d + %0d != %0d", i, A, B, SUM);
        end

        // WARNING
        //$display("WARNING: This is a simulated warning message");
        
        //FATAL
        //$fatal(1, "This is a simulated FATAL error");

        //  TIMEOUT 
        //while (1) begin end
        //#10000; 
        
        $display("Test Passed");
        $display("SIM DONE at time: %0t ns", $time);
        $finish; 
    end
    
endmodule