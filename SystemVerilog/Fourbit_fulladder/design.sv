module fourbit_fulladder #(parameter DATA_WIDTH=4) (
  input logic [DATA_WIDTH-1:0] a,
  input logic [DATA_WIDTH-1:0] b,
  input logic c_in,
  output logic [DATA_WIDTH-1:0] sum,
  output logic c_out
);

  // Compute the sum and carry-out
  assign {c_out, sum} = a + b + c_in;

endmodule
