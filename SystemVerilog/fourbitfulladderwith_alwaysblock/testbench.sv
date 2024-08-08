module tb_fourbit_fulladder;
  parameter WIDTH = 4;

  // Inputs
  logic [WIDTH-1:0] a;
  logic [WIDTH-1:0] b;
  logic c_in;

  // Outputs
  logic [WIDTH-1:0] sum;
  logic c_out;

  // Instantiate the Device Under Test (DUT)
  fourbit_fulladder #(WIDTH) DUT (
    .a(a),
    .b(b),
    .c_in(c_in),
    .sum(sum),
    .c_out(c_out)
  );

  // Apply test vectors
  initial begin
    // Initialize inputs
    a = 0;
    b = 0;
    c_in = 0;

    // Apply test vectors with delays
    #10; a = 4'b0001; b = 4'b0010; c_in = 0;
    #10; a = 4'b0001; b = 4'b0010; c_in = 1;
    #10; a = 4'b0001; b = 4'b0011; c_in = 1;
    
    // End simulation
    #10; $finish;
  end

  // Monitor signal changes
  initial begin
    $monitor("Time: %0t, a=%b, b=%b, c_in=%b, sum=%b, c_out=%b", $time, a, b, c_in, sum, c_out);
  end

endmodule
