module full_adder(
  input logic a,b,cin,
  output logic final_sum, final_carry);
  
  wire x,y,z;
  
  half_adder ha1(.a(a),.b(b),.sum(x),.carry(y));
  half_adder ha2(.a(x),.b(cin),.sum(final_sum),.carry(z));
  
  assign final_carry=y|z;
  
endmodule

module half_adder(input logic a, b,
                  output logic sum, carry);
  
  assign sum=a^b;
  assign carry=a&b;
  
endmodule
  