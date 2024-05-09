// Code your testbench here
// or browse Examples
module tb_halfadder;
  logic a,b;
  logic sum, carry;
  
  half_adder halfadder_inst(.a(a),.b(b),.sum(sum),.carry(carry));
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(1);
  end
  
  initial begin
    a=0; b=0;
    
    #10ns a=0; b=1;
    
    #10ns a=1; b=0;
    
    #10ns a=1; b=1;
    
    #5ns;
    $display("Finished!...");
  end
endmodule
