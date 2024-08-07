/*module tb_parallel_serial_sr;
  parameter INPUT_WIDTH=8;
  logic [INPUT_WIDTH-1:0] data_in;
  logic data_out;
  logic clk;
  logic reset;
  logic enable;
  
  parallel_serial_sr UUT(.data_in(data_in),.data_out(data_out),.clk(clk),.reset(reset),.enable(enable));
  
  initial begin
    clk=0;
    forever #5 clk=~clk;
  end
  
  initial begin
    reset=0;
    enable=0;
    data_in=0;
    
    #10; reset=1;
    #10; enable=1;
    #10; data_in=8'b10101010;
    #10; enable=0;
    //#10; data_in=8'b10101010;
    
  end
    
  
  
  
  initial begin
    for(int i=0; i<INPUT_WIDTH; i++) begin
      #10;
      $monitor("Time: %0t, Input: %b, Output: %b", $time, data_in, data_out);
      
  	end
    #40; $finish;
  end
  
endmodule */
             
module tb_parallel_serial_sr;
  parameter INPUT_WIDTH=8;
  logic [INPUT_WIDTH-1:0] data_in;
  logic data_out;
  logic clk;
  logic reset;
  logic enable;
  
  // Instantiate the module
  parallel_serial_sr #(.INPUT_WIDTH(INPUT_WIDTH)) UUT(
    .data_in(data_in),
    .data_out(data_out),
    .clk(clk),
    .reset(reset),
    .enable(enable)
  );

  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end
  
  // Testbench procedure
  initial begin
    // Initialize signals
    reset = 0;
    enable = 0;
    data_in = 0;

    // Apply reset
    #10 reset = 1;
    #10 reset = 0;
    #10 reset = 1;

    // Test Case: Load data and shift out
    enable = 1;
    data_in = 8'b10101010;
    #10 enable = 0;
    
    // Monitor the output
    for (int i = 0; i <INPUT_WIDTH; i++) begin
      #10;
      $monitor("Time: %0t, Input: %b, Output: %b", $time, data_in, data_out);
    end

    // Finish simulation
    #10 $finish;
  end
  
endmodule
