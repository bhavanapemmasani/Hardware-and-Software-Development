module fibanocci_generator #(parameter DATA_WIDTH=32) (
  input logic clk,
  input logic reset,
  output logic [DATA_WIDTH-1:0] out);
  
  logic [DATA_WIDTH-1:0] prev1;
  logic [DATA_WIDTH-1:0] prev2;
  
  always @(posedge clk or negedge reset) begin
    if(!reset) begin
      prev1<=1;
      prev2<=1;
      out<=1;
    end else begin
      prev2<=prev1;
      prev1<=prev1+prev2;
      out<=prev1;
    end
  end
endmodule
  