
`include "uvm_macros.svh"
import uvm_pkg::*;

class monitor extends uvm_monitor;
`uvm_component_utils(monitor)
 
uvm_analysis_port #(transaction) send;
 
  function new(input string name = "MON", uvm_component parent=null);
    super.new(name,parent);
send = new("Write", this);
endfunction
 
transaction t;
virtual add_if aif;
 
virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
t = transaction::type_id::create("TRANS");
if(!uvm_config_db #(virtual add_if)::get(this,"","aif",aif)) 
`uvm_info("MON","Unable to access uvm_config_db",UVM_NONE);
endfunction
 
virtual task run_phase(uvm_phase phase);
forever begin
#10;
t.a = aif.a;
t.b = aif.b;
t.y = aif.y;
  `uvm_info("MON", $sformatf("\t\t Data send to Scoreboard a=%0d, b=%0d, y=%0d",t.a,t.b,t.y), UVM_NONE);
send.write(t);
end
endtask
endclass
