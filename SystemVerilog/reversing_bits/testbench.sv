module tb_reversing_bits;
  
  parameter DATA_WIDTH=8;
  
  logic [DATA_WIDTH-1:0] in;
  logic [DATA_WIDTH-1:0] out;
  
  
  
  reversing_bits DUT(.data_in(in),.data_out(out));
  
  initial begin
    #10; in=8'b00100111;
    #5; in=8'b00000001;
    #10; in=8'b10010100;
    #30; in=8'b00000101;
    
    
    #10;
    
    $finish;
  end
  
  
  initial begin
    $monitor("Time: %0t, Input is: %b, Reversed the input: %b", $time, in, out);
  end
endmodule
