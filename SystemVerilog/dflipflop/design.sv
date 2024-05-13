module risingedgedflipflop(input logic d, clk, reset,
                           output logic q, qbar);
  always @(posedge clk) begin
    if(reset) 
      q<=0; 
  	else 
      q<=d;
      
    
  end
  
  assign qbar= ~q;
  
    
endmodule
