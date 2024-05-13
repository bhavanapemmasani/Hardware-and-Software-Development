`include "uvm_macros.svh"
import uvm_pkg::*;

module tb;

  logic clk;
  logic reset;
  logic d;

  logic q;
  logic qbar;

  risingedgedflipflop d_ff (
    .clk(clk),
    .reset(reset),
    .d(d),
    .q(q),
    .qbar(qbar)
  );

  initial begin
    clk = 1'b0;
    forever #5 begin
      clk = ~clk;
      
    end
  end

  initial begin
    reset = 1'b1;
    #10 reset = 1'b0;
  end

  initial begin
    d = 1'b0;
    $display("Time = %0t, d = %b, q = %b, qbar = %b", $time, d, q, qbar);
    `uvm_info("TB_TOP", $sformatf("Time = %0t, d = %b, q = %b, qbar = %b", $time, d, q, qbar), UVM_NONE);
    #5 d = 1'b1;
    $display("Time = %0t, d = %b, q = %b, qbar = %b", $time, d, q, qbar);
    `uvm_info("TB_TOP", $sformatf("Time = %0t, d = %b, q = %b, qbar = %b", $time, d, q, qbar), UVM_NONE);
    #5 d = 1'b0;
    $display("Time = %0t, d = %b, q = %b, qbar = %b", $time, d, q, qbar);
    `uvm_info("TB_TOP", $sformatf("Time = %0t, d = %b, q = %b, qbar = %b", $time, d, q, qbar), UVM_NONE);
    #5 d = 1'b0;
    $display("Time = %0t, d = %b, q = %b, qbar = %b", $time, d, q, qbar);
    `uvm_info("TB_TOP", $sformatf("Time = %0t, d = %b, q = %b, qbar = %b", $time, d, q, qbar), UVM_NONE);
    #5 d = 1'b1;

    #10 $finish;
  end

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(1);
  end
endmodule