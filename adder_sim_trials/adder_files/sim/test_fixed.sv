
`include "uvm_macros.svh"
import uvm_pkg::*;

class test_fixed extends uvm_test;
  `uvm_component_utils(test_fixed)
 
  function new(input string name = "", uvm_component parent=null);
    super.new(name,parent);
endfunction
 
  env e;
  sequence_fixed seq_f;
 
virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
  e = env::type_id::create("ENV",this);  
  seq_f = sequence_fixed::type_id::create("SEQ_FIXED");
endfunction
 
virtual task run_phase(uvm_phase phase);
  phase.raise_objection(this);    
    seq_f.start(e.a.seqr);  
  //phase.phase_done.set_drain_time(this,50ns);
  phase.drop_objection(this);
endtask
endclass
