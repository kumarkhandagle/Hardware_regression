
`include "uvm_macros.svh"
import uvm_pkg::*;

class env extends uvm_env;
`uvm_component_utils(env)
 
 
  function new(input string name = "ENV", uvm_component parent=null);
    super.new(name,parent);
endfunction
 
scoreboard s;
agent a;
 
virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
s = scoreboard::type_id::create("SCO",this);
a = agent::type_id::create("AGENT",this);
endfunction
 
 
virtual function void connect_phase(uvm_phase phase);
super.connect_phase(phase);
a.m.send.connect(s.recv);
endfunction
 
endclass
