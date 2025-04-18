
`include "uvm_macros.svh"
import uvm_pkg::*;

class agent extends uvm_agent;
`uvm_component_utils(agent)
 
 
  function new(input string name = "AGENT", uvm_component parent=null);
    super.new(name,parent);
endfunction
 
monitor m;
driver d;
  uvm_sequencer #(transaction) seqr;
 
 
virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
m = monitor::type_id::create("MON",this);
d = driver::type_id::create("DRV",this);
  seqr = uvm_sequencer #(transaction)::type_id::create("SEQR",this);
endfunction
 
 
virtual function void connect_phase(uvm_phase phase);
super.connect_phase(phase);
  d.seq_item_port.connect(seqr.seq_item_export);
endfunction
endclass
