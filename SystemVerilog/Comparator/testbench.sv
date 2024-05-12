
module tb;
  logic [3:0] A, B;
  logic great, equal, less;
  
  comparator comparator_tb(.A(A), .B(B), .greater(great), .equal(equal), .lesser(less));
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(1);
  end
  
  initial begin
    A = 4'b0000; B = 4'b0000; #10; 
    //$monitor("A=%b, B=%b, great=%b, equal=%b, less=%b", A, B, great, equal, less);
    
    A = 4'b0010; B = 4'b1000; #10;
    //$monitor("A=%b, B=%b, great=%b, equal=%b, less=%b", A, B, great, equal, less);
    
    A = 4'b0011; B = 4'b0001; #10;
    //$monitor("A=%b, B=%b, great=%b, equal=%b, less=%b", A, B, great, equal, less);
    
    #10;
    $finish;
  end
endmodule
