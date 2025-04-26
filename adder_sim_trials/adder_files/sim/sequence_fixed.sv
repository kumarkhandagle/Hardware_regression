
`include "uvm_macros.svh"
import uvm_pkg::*;

class sequence_fixed extends uvm_sequence#(transaction);
  `uvm_object_utils(sequence_fixed)
  
  int fixed_a[4] = '{2,4,8,15};
  int fixed_b[4] = '{2,4,8,15};
  
  function new(input string name = "sequence_random");
  super.new(name);
endfunction
  
  virtual task body;
    transaction t;
    t = transaction::type_id::create("txn");
    
    for(int i=0;i<4;i++) begin
      start_item(t);
      t.a=fixed_a[i];
      t.b=fixed_b[i];
      `uvm_info("SEQ_FIXED",$sformatf("\t Fixed data sent to driver a=%0d, b=%0d",t.a,t.b),UVM_LOW);
      finish_item(t);
      #10;
    end
  endtask
endclass
    
    
  

