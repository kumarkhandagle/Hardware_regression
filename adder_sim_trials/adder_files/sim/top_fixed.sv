`include "uvm_macros.svh"
import uvm_pkg::*;

`include "interface.sv"
`include "transaction.sv"
`include "sequence_fixed.sv"
`include "driver.sv"
`include "monitor.sv"
`include "scoreboard.sv"
`include "agent.sv"
`include "env.sv"
`include "test_fixed.sv"

module top_fixed;
  test_fixed t_fixed;
add_if aif();
 
add dut (.a(aif.a), .b(aif.b), .y(aif.y));
 
initial begin
  t_fixed = new("test_fixed",null);
uvm_config_db #(virtual add_if)::set(null, "*", "aif", aif);
run_test();
end
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end
endmodule
