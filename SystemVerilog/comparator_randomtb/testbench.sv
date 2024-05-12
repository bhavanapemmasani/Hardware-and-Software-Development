

module tb;
  logic [3:0] A, B;
  logic great, equal, less;
  comparator comparator_tb(.A(A), .B(B), .greater(great), .equal(equal), .lesser(less));
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(1);
  end
  
  initial begin
    $monitor("A=%b, B=%b, great=%b, equal=%b, less=%b", A, B, great, equal, less);
    
    repeat(5) begin
      A = $random; B = $random; #10;
      //$display("A=%b, B=%b, great=%b, equal=%b, less=%b", A, B, great, equal, less);
    end
    
    #10; $finish;
  end
endmodule
