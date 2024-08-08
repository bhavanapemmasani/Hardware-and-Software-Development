module tb_fibanocci;
  parameter DATA_WIDTH=32;
  logic clk;
  logic reset;
  logic [DATA_WIDTH-1:0] out;
  
  fibanocci_generator DUT(.clk(clk),.reset(reset),.out(out));
  
  initial begin 
    clk=0;
    forever #5 clk=~clk;
  end
  
  initial 
    begin
      reset=0;
      #10; reset=1;
      #150 $finish;
    end
  initial begin
    $monitor("Time: %0t, Reset: %b, Output: %d", $time, reset, out);
  end
endmodule
