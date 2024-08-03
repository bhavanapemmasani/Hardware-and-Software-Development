module tb_bit_counter;
  parameter DATA_WIDTH=32;
  logic [DATA_WIDTH-1:0] din;
  logic [$clog2(DATA_WIDTH+1)-1:0] dout;
  
  bit_counter uut(.data_input(din),.count(dout));
  
  initial begin
    din=32'h00000000;
    #10;
    din=32'h00011001;
    #10;
    din=32'hAAAAAAAA;
    #10;
    din=32'hFFFFFFFF;
    #10
    $finish;
  end
  
  
  initial begin
    $monitor("Time: %0t, Input: %b, Count of 1's: %0d", $time, din, dout);
  end
endmodule
