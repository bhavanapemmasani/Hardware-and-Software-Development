module tb_one_hot_detector;
  parameter DATA_WIDTH=8;
  logic [DATA_WIDTH-1:0] data_in;
  logic is_one_hot;
  
  one_hot_detector DUT(.data_in(data_in),.detected(is_one_hot));
  
  initial begin
    data_in=8'b00000001;
    #10;
    data_in=8'b00001000;
    #10;
    data_in=8'b00010010;
    
    #10;
    $finish;
    
  end
  initial begin
    $monitor("Time: %0t, Input: %b, Detected? %b", $time, data_in, is_one_hot);
  end
endmodule
