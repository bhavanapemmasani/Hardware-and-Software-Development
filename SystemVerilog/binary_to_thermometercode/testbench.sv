module tb_binart2thermometer;
  logic [7:0] binary_input;
  logic [255:0] thermometer_output;
  
  binary_to_thermometer DUT (.binary_in(binary_input),.thermometer_code(thermometer_output));
  
  initial begin 
    
    binary_input=8'b0000000;
    #10; binary_input=8'b00000011;
    #10; binary_input=8'b11111111;
    #10; binary_input=8'b00000001;
  end
    
  
  initial begin
    $monitor("Time: %0t, Binary input is: %b, Thermometer code: %b", $time, binary_input, thermometer_output);
  end
endmodule
