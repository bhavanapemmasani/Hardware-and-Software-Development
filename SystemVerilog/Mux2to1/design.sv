// Code your design here
module Mux2to1(
  input logic a,b, sel,
  output logic out);
  always_comb 
    begin
      if (sel==0)
        out=a;
       else 
         out=b;
    end
endmodule
