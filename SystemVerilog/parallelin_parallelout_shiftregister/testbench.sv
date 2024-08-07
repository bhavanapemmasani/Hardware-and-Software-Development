module tb_pipo;
  parameter INPUT_WIDTH=8;
  logic clk;
  logic reset;
  logic [INPUT_WIDTH-1:0] parallel_in;
  logic [INPUT_WIDTH-1:0] parallel_out;
  logic load_enable;
  
  parallel_in_parallel_out_shiftregister DUT(.clk(clk),.reset(reset),.parallel_in(parallel_in),.parallel_out(parallel_out),.load(load_enable));
  
  initial begin
    clk=0;
    forever #5 clk=~clk;
  end
  
  initial begin
    reset=1;
    reset=0;
    reset=1;
    
    #10; parallel_in=8'b10101101; load_enable=1;
    #10; parallel_in=8'b01011010; load_enable=1;
    #10; parallel_in=8'b11110000; load_enable=0;
    
    #10;
    $finish;
  end
  initial begin
    $monitor("Time: %0t, Output: %b", $time, parallel_out);
  end
endmodule

    