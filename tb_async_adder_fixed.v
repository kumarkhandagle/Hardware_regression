`timescale 1ns/1ps
module tb_async_adder_fixed;
    reg [3:0] A;
    reg [3:0] B;
    wire [4:0] SUM;
    
    async_adder dut (
        .A(A),
        .B(B),
        .SUM(SUM)
    );
    
    //Inject critical warning
    //reg uninit_signal; initial $display("Uninitialized signal = %b", uninit_signal);

    //reg race_signal;always @(A) race_signal = A[0];always @(B) race_signal = B[0];
    //initial $display("CRITICAL WARNING: Simulated race condition detected.");

    initial begin
    $display("I AM FIXED VERSION BETA @ %0t ns", $time);

        $display("Starting fixed testbench...");

        A = 4'b0001; B = 4'b0010; #10;
        assert (SUM == 5'd3) else $fatal(1, "Test1 Failed: 1+2 != %0d", SUM);
        
        A = 4'b0101; B = 4'b0011; #10;
        assert (SUM == 5'd8) else $fatal(1, "Test2 Failed: 5+3 != %0d", SUM);

        A = 4'b1010; B = 4'b0101; #10;
        assert (SUM == 5'd15) else $fatal(1, "Test3 Failed: 10+5 != %0d", SUM);

        A = 4'b1111; B = 4'b0001; #10;
        assert (SUM == 5'd16) else $fatal(1, "Test4 Failed: 15+1 != %0d", SUM);
        
        // WARNING
        //$display("WARNING: This is a simulated warning message");
        
        // FATAL
        //$fatal(1, "This is a simulated FATAL error");

        //  TIMEOUT 
        //#100000;
        
        $display("Test Passed");
        $display("SIM DONE at time: %0t ns", $time);
        $finish; 
    end
    
    

endmodule