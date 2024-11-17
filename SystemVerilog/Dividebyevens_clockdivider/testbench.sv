module tb_clockdivider;
  logic clk;
  logic reset;
  logic div2;
  logic div4;
  logic div6;
  
  divide_byevens_clockdivider DUT (.clk(clk),.resetn(reset),.div2(div2),.div4(div4),.div6(div6));
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(1);
  end
  
  
  initial begin
    clk=0;
    forever #5 clk=~clk;
  end
  
  initial begin
          reset = 0;
        #20; // Wait for a while
        reset = 1;
        #100; // Wait and observe outputs

        // Apply reset and check outputs
        reset = 0;
        #20; // Assert reset
        reset = 1;
        #100; // Wait and observe outputs

        // Apply another reset and check outputs
        reset = 0;
        #20; // Assert reset
        reset = 1;
        #100; // Wait and observe outputs
    
     $finish;
    
    
  end
  
  
  initial begin
    $monitor("Time: %0t, Reset:%b, Input: %b, DIV2: %b, DIV4: %b: DIV6: %b", $time, reset, clk, div2, div4, div6);
  end
endmodule
