module tb_risingedge_detector;
  logic clk;
  logic reset_n;
  logic data_in;
  logic data_out;
  
  rising_edge_detector UUT(.clk(clk),.resetn(reset_n),.data_in(data_in),.data_out(data_out));
  
  initial begin
    clk=0;
    forever #5 clk=~clk;
  end
  
  initial begin
    reset_n=0;
    #10; data_in=1;
    #15;
    reset_n=1;
    #10;
    data_in=1;
    #10;
    data_in=0;
    #10;
    data_in=1;
    #10;
    data_in=0;
    #10;
    data_in=1;
    #10; data_in=0;
    
    
    
    #10;
    $finish;
    
  end
  
  
  initial begin
    $monitor("Time: %0t, Reset: %b, Input: %b, Output: %b", $time, reset_n, data_in, data_out);
  end
endmodule
