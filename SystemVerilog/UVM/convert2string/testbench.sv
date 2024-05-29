`include "uvm_macros.svh"
import uvm_pkg::*;

class obj extends uvm_object;
  `uvm_object_utils(obj);
  
  bit [3:0] a;
  string b="UVM";
  real c=12.34;
  
  function new(string path="OBJ");
    super.new(path);
  endfunction
  
  virtual function string convert2string();
    string s=super.convert2string();
    
    s={s, $sformatf("a: %0d ",a)};
    s={s, $sformatf("b: %0s ",b)};
    s={s, $sformatf("c: %0f ",c)};
    
    return s;
    
  endfunction
  
endclass

module tb;
  obj o;
  initial begin
    o=obj::type_id::create("o");
    o.convert2string();
    `uvm_info("TB_TPOP", $sformatf("%0s", o.convert2string()), UVM_NONE);
  end
endmodule