module tb_full_adder;
  logic a;
  logic b;
  logic c_in;
  logic sum;
  logic c_out;
  
  full_adder DUT(.a(a),.b(b),.c_in(c_in),.sum(sum),.c_out(c_out));
  
  initial begin 
    a=0; b=0; c_in=0;
    
    #10; a=0; b=1; c_in=0;
    #10; a=1; b=0; c_in=1;
    #10; a=1; b=1; c_in=0;
    #10; a=1; b=1; c_in=1;
    
    #50; $finish;
  end
  
  initial begin
    $monitor("Time: %0t, a:%b, b:%b, c:%b, Sum:%b, Carry:%b", $time, a, b,c_in, sum, c_out);
  end
endmodule
