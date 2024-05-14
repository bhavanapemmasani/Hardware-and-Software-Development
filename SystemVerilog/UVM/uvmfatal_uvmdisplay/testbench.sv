`include "uvm_macros.svh"
import uvm_pkg::*;

class driver extends uvm_driver;
  `uvm_component_utils(driver);
  
  function new(string path, uvm_component parent);
    super.new(path, parent);
  endfunction
  
  task run();
    `uvm_info("DRV", "Informational Message", UVM_NONE);
    `uvm_warning("DRV", "Potential Error");
    `uvm_error("DRV", "Reak Error");
    #10;
    `uvm_fatal("DRV", "Simulation cannot be continued");
  endtask
  
endclass

/////////////////////////////////////////////////////
module tb;
  driver d;
  
  initial begin
    d=new("DRV", null);
    //d.set_report_severity_action(UVM_INFO, UVM_NO_ACTION);
    d.set_report_severity_action(UVM_FATAL, UVM_DISPLAY);
    d.run();
  end
endmodule
  