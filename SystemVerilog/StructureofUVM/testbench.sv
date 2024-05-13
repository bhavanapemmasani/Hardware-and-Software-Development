`include "uvm_macros.svh"
import uvm_pkg::*;

//Defining new class
//Inherits properties and methods from 'uvm_driver' class
//Base class or super class: uvm_driver
class driver extends uvm_driver;
  `uvm_component_utils(driver);//macro for the 'driver' class
  //automatically registers 'driver' class within uvm factory-allows instances of driver class to be created dynamically
  
  
  //Constructor function to initialize the 'driver' object when it is created
  function new(string path, uvm_component parent);
    //Ensures-'driver' object is properly initialized with specific hierarchical path, and parent component, and any necessary initialization logic from the base class is also executed
    //Ensures 'driver' object is ready to use within UVM verification environment
    super.new(path,parent);
  endfunction
  
  task run();//represents the main functionality of the driver
    `uvm_info("DRV1", "Executed Driver1 code", UVM_HIGH);
    `uvm_info("DRV2", "Executed Driver2 code", UVM_HIGH);
  endtask
endclass

module tb;
  driver drv;//created an instance of driver
  
  initial begin
    drv=new("DRV", null);//Instantiates an onject drv with instance name 'DRV' and no parent component
    drv.set_report_id_verbosity("DRV1", UVM_HIGH);
    //sets the verbosity level of report ID "DRV1" to UVM_HIGH
    drv.set_report_id_verbosity("DRV2", UVM_HIGH);
    drv.run; //calls the 'run()'task of the 'driver' class which prints the informational message
  end
endmodule

    
    