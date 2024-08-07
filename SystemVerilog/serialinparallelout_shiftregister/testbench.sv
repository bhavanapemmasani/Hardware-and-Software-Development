module tb_serialtoparallel;
  parameter INPUT_WIDTH=8;
  logic clk;
  logic reset;
  logic data_in;
  logic [INPUT_WIDTH-1:0] data_out;
  
  serial_in_parallel_out DUT(.clk(clk),.reset(reset),.data_in(data_in),.data_out(data_out));
  
  initial begin
    clk=0;
    forever #5 clk=~clk;
  end
   initial begin
     //reset
     reset=1;
     reset=0;
     reset=1;
     #10; data_in=1;
     #10; data_in=0;
     #10; data_in=1;
     #10; data_in=0;
     #10; data_in=1;
     #10; data_in=1;
     #10; data_in=0;
     #10; data_in=1;
     #10;
     $finish;
   end
  
  initial begin
    $monitor("Time: %0t, Output: %b", $time, data_out);
  end
endmodule

    
     
    