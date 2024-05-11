`include "uvm_macros.svh"
import uvm_pkg::*;

module tb;
  logic [2:0] in;
  logic [7:0] out;
  
  threexeight_decoder threexeight_tb(.in(in),.y(out));
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(1);
  end
  
  initial begin
    in=000; #10;
    $display("Output: %b",out);
    `uvm_info("TB_TOP", $sformatf("Output: %b", out), UVM_NONE);
    `uvm_info("TB_TOP", $sformatf("Output: %b", out), UVM_MEDIUM);
    
    in=001; #10;
    $display("Output: %b",out);
    `uvm_info("TB_TOP", $sformatf("Output: %b", out), UVM_NONE);
    in=010; #10;
    $display("Output: %b",out);
    `uvm_info("TB_TOP", $sformatf("Output: %b", out), UVM_NONE);
    in=011; #10;
    $display("Output: %b",out);
    `uvm_info("TB_TOP", $sformatf("Output: %b", out), UVM_NONE);
    in=100; #10;
    $display("Output: %b",out);
    `uvm_info("TB_TOP", $sformatf("Output: %b", out), UVM_NONE);
    in=101; #10;
    $display("Output: %b",out);
    `uvm_info("TB_TOP", $sformatf("Output: %b", out), UVM_NONE);
    in=110; #10;
    $display("Output: %b",out);
    `uvm_info("TB_TOP", $sformatf("Output: %b", out), UVM_NONE);
    in=111; #10;
    $display("Output: %b",out);
    `uvm_info("TB_TOP", $sformatf("Output: %b", out), UVM_NONE);
    $display("Finished!...");
    $finish;
  end
endmodule
