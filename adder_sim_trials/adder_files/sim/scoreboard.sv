
`include "uvm_macros.svh"
import uvm_pkg::*;

class scoreboard extends uvm_scoreboard;
`uvm_component_utils(scoreboard)
 
uvm_analysis_imp #(transaction,scoreboard) recv;
transaction data;
 
  function new(input string name = "SCO", uvm_component parent=null);
    super.new(name,parent);
recv = new("Read", this);
endfunction
 
virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
data = transaction::type_id::create("TRANS");
endfunction
 
virtual function void write(input transaction t);
data = t;
  `uvm_info("SCO",$sformatf("\t\t Data rcvd from Monitor a=%0d, b=%0d, y=%0d",t.a,t.b,t.y), UVM_NONE);
if(data.y == data.a + data.b)
  `uvm_info("SCO","\t TEST PASSED", UVM_NONE)
else
  `uvm_info("SCO","\t TEST FAILED", UVM_NONE);
endfunction
endclass
