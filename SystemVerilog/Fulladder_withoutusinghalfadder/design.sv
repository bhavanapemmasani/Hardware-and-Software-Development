module full_adder (
  input logic a,
  input logic b,
  input logic c_in,
  output logic sum,
  output logic c_out);
  
  assign sum=a^b^c_in;
  assign c_out=(a&b)|(b&c_in)|(c_in&a);
  
endmodule