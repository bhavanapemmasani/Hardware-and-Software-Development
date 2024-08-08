module tb_one_hot;
  parameter WIDTH=8;
  logic [WIDTH-1:0] data_input;
  logic one_hot;
  
  one_hot_detector DUT(.data_in(data_input),.is_one_hot(one_hot));
  
  initial begin
    data_input=8'b00010000;
    #10; data_input=8'b00101000;
    #10; data_input=8'b00000010;
    #10; $finish;
  end
  
  initial begin
    $monitor("Time: %0t, Input: %b, Detected:%b", $time, data_input, one_hot);
  end
endmodule
