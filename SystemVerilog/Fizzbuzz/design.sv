module fizz_buzz_counter #(
  parameter MAX_CYCLES = 15, // Change this for testing different cycle counts
  parameter FIZZ = 3,         // Fizz divisor
  parameter BUZZ = 5          // Buzz divisor
)(
  input logic clk,            // Clock signal
  input logic resetn,         // Active-low reset
  output logic fizz,          // Fizz output
  output logic buzz,          // Buzz output
  output logic fizzbuzz       // FizzBuzz output
);

  // Internal signal for the counter
  logic [$clog2(MAX_CYCLES)-1:0] counter;
  
  // Counter logic
  always @(posedge clk or negedge resetn) begin
    if (!resetn) begin
      // Reset: set counter to 0
      counter <= 0;
    end else begin
      // Increment counter
      if (counter == MAX_CYCLES - 1)
        counter <= 0;
      else
        counter <= counter + 1;
    end
  end

  // Output logic
  always @(*) begin
    fizz = (counter % FIZZ == 0);
    buzz = (counter % BUZZ == 0);
    fizzbuzz = fizz && buzz;
  end

endmodule
