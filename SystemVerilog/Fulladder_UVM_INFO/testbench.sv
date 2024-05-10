`include "uvm_macros.svh"
import uvm_pkg::*;


module tb;
  logic a, b, cin;
  logic fs, fc;
  
  // Instance of the full adder module
  full_adder fa(.a(a), .b(b), .cin(cin), .final_sum(fs), .final_carry(fc));
  
  // Initial block to start simulation and dump signals
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(1);
  end
  
  // Test vectors
  initial begin
    a = 0; b = 0; cin = 0; #10;
    a = 0; b = 0; cin = 1; #10;
    a = 0; b = 1; cin = 0; #10;
    a = 0; b = 1; cin = 1; #10;
    a = 1; b = 0; cin = 0; #10;
    a = 1; b = 0; cin = 1; #10;
    a = 1; b = 1; cin = 0; #10;
    a = 1; b = 1; cin = 1; #10;
    
    $display("Finished!...");
    `uvm_info("TB_TOP", $sformatf("Final outputs are: %b, %b",fs,fc), UVM_NONE);
    $finish; // Terminate simulation
  end
endmodule
