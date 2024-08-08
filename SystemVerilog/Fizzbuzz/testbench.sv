module tb_fizz_buzz_counter;

  // Parameters
  parameter MAX_CYCLES = 15;
  parameter FIZZ = 3;
  parameter BUZZ = 5;

  // Inputs
  logic clk;
  logic resetn;

  // Outputs
  logic fizz;
  logic buzz;
  logic fizzbuzz;

  // Instantiate the Device Under Test (DUT)
  fizz_buzz_counter #(
    .MAX_CYCLES(MAX_CYCLES),
    .FIZZ(FIZZ),
    .BUZZ(BUZZ)
  ) DUT (
    .clk(clk),
    .resetn(resetn),
    .fizz(fizz),
    .buzz(buzz),
    .fizzbuzz(fizzbuzz)
  );

  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk; // 10ns clock period
  end

  // Testbench logic
  initial begin
    // Initialize inputs
    resetn = 0;
    #10;
    resetn = 1; // Deassert reset

    // Run simulation for enough cycles
    #200;
    $finish;
  end

  // Monitor outputs
  initial begin
    $monitor("Time: %0t | Counter: %0d | Fizz: %b | Buzz: %b | FizzBuzz: %b", $time, DUT.counter, fizz, buzz, fizzbuzz);
  end

endmodule
