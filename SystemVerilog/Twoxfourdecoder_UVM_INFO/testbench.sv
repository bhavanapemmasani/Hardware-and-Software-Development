`include "uvm_macros.svh"
import uvm_pkg::*;

module tb;
  logic [1:0] in;
  logic [3:0] out;
  
  twoxfour_decoder decoder_tb(.in(in),.y(out));
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(1);
  end
  
  initial begin
    in=00; #10ns;
    $display("outut: %b", out);
    `uvm_info("TB_TOP", $sformatf("outut: %b", out), UVM_NONE);
    in=01; #10ns;
    $display("outut: %b", out);
    `uvm_info("TB_TOP", $sformatf("outut: %b", out), UVM_NONE);
    in=10; #10ns;
    $display("outut: %b", out);
    `uvm_info("TB_TOP", $sformatf("outut: %b", out), UVM_NONE);
    in=11; #10ns;
    $display("outut: %b", out);
    `uvm_info("TB_TOP", $sformatf("outut: %b", out), UVM_NONE);
    $display("Finished!..");
    $finish;
  end
endmodule

             
             
             
             