`timescale 1ns / 1ps

module tb_structural_fail_test;
  // -------------------------------
  // 1. STRUCTURE FAIL 
  /*
  reg a;
  wire b;
  assign b = c;  
  */

  // -------------------------------
  // 2. UVM FATAL 
  
    /*
  import uvm_pkg::*;
  `include "uvm_macros.svh"

  class dummy_test extends uvm_test;
    `uvm_component_utils(dummy_test)

    function new(string name, uvm_component parent);
      super.new(name, parent);
    endfunction

    task run_phase(uvm_phase phase);
      `uvm_fatal("SIM", "This is a simulated UVM fatal error.")
    endtask
  endclass

  initial begin
    $display("Starting UVM test for SIM FAIL...");
    run_test("dummy_test");
  end
   */
  

  // -------------------------------
  // 3. CLEAN PATH 


  initial begin
    $display("SIM_START");
    #100;
    $display("SIM_DONE");
    $display("SIM DONE at time: %0t ns", $time);
    int fd = $fopen("sim_done.flag", "w");
    $fclose(fd);
    //#100000000000000;
    $finish;
  end


endmodule