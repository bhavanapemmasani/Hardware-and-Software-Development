module tb_trailingzeros;
  
  parameter DATA_WIDTH=8;
  
  logic [DATA_WIDTH-1:0] din;
  logic[$clog2(DATA_WIDTH+1)-1:0] t_count;
  
  trailing_zeros uut(.data_input(din),.trailing_count(t_count));
        
  initial begin
    din=00000000;
    #10;
    din=00010001;
    #10;
    din=10100100;
    #10;
    din=10010000;
    #10;
    din=00000001;
    #10;
    $finish;
  end
  
  initial begin
    $monitor("Time: %0t, Input: %0b, Trailing Zeros Count: %0d", $time, din, t_count);
  end
endmodule