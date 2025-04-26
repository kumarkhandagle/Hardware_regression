`include "uvm_macros.svh"
import uvm_pkg::*;

`include "interface.sv"
`include "transaction.sv"
`include "sequence_random.sv"
`include "driver.sv"
`include "monitor.sv"
`include "scoreboard.sv"
`include "agent.sv"
`include "env.sv"
`include "test_random.sv"

module top_random;
  test_random t_random;
add_if aif();
 
add dut (.a(aif.a), .b(aif.b), .y(aif.y));
 
initial begin
  t_random = new("test_random",null);
uvm_config_db #(virtual add_if)::set(null, "*", "aif", aif);
run_test();
end
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end
endmodule