`timescale 1ns/1ps
module tb();
  reg clk=0;
  reg clk50=0;
  always #5 clk=~clk;
  
  task clkgen(input real phase,
              input real ton,
              input real toff);
    #phase;
    while(1) begin
      clk50=1;
      #ton;
      clk50=0;
      #toff;
    end
  endtask
  
  initial begin
    clkgen(7,5,5);
  end
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end
   
  initial begin
    #200;
    $finish();
  end
  
endmodule
