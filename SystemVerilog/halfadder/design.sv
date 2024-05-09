// Code your design here
module half_adder(
  input logic a,b,
  output logic carry, sum);
  
  assign sum=a^b;
  assign carry=a&b;
  
endmodule