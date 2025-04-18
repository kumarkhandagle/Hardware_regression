`define XIL_TIMESCALE_VERILOG_VAMS
`timescale 1ns/1ps

`timescale 1ns/1ps
module async_adder(
    input  [3:0] A,
    input  [3:0] B,
    output [4:0] SUM
);
    assign SUM = A + B;
    initial begin
         $display(" FILE LOADED: async_adder.v");
    end
endmodule