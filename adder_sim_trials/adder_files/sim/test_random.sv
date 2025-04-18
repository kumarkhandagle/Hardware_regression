
`include "uvm_macros.svh"
import uvm_pkg::*;

class test_random extends uvm_test;
  `uvm_component_utils(test_random)
 
  function new(input string name = "", uvm_component parent=null);
    super.new(name,parent);
endfunction
 
  env e;
  sequence_random seq_r;
 
virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
  e = env::type_id::create("ENV",this);
  seq_r = sequence_random::type_id::create("SEQ_RANDOM");
endfunction
 
virtual task run_phase(uvm_phase phase);
  phase.raise_objection(this);
    seq_r.start(e.a.seqr);
  //phase.phase_done.set_drain_time(this,50ns);
  phase.drop_objection(this);
endtask
endclass
