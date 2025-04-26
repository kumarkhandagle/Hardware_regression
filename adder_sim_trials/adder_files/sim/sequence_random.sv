
`include "uvm_macros.svh"
import uvm_pkg::*;

class sequence_random extends uvm_sequence #(transaction);
  `uvm_object_utils(sequence_random)
 
transaction t;
integer i;
 
  function new(input string name = "sequence_random");
  super.new(name);
endfunction
 
virtual task body();
  t = transaction::type_id::create("txn");
  for(i =0; i< 5; i++) begin
start_item(t);
t.randomize();
    `uvm_info("SEQ_RANDOM", $sformatf("\t Data send to Driver a=%0d, b=%0d",t.a,t.b), UVM_NONE);
//t.print(uvm_default_line_printer);
finish_item(t);
    #10;
end
endtask
endclass
