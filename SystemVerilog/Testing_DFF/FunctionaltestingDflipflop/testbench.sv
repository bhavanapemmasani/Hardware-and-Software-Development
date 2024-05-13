// testing d-flipflop
module tb;
  logic d,clk,reset;
  logic q, qbar;
  
  d_ff dff_tb(.d(d),.clk(clk),.reset(reset),.q(q),.qbar(qbar));
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(1);
  end
  
  //Functional Testing
  //Verifying the basic functionality of D flip flop
  
  //clock generation
  initial begin
    clk=1;
    forever #5 clk=~clk;
  end
  
  //Reset
  initial begin
    reset=1;
    #10 reset=0;
  
  
  //Stimulus
  //Applying low-to-high transition for a D flip flop
  
    d=0;
    #10 d=1;
  
  
  //Applying high-to-low transition for a D flip flop
  
    #10 d=0;
  
  
  //Holding input at a constant value
  
    #10 d=1;
    #10 d=1;
    
    //Assert and deassert reset
    #10 reset=1;
    #10 reset=0;
    
    //Finish Simulation
    #10 $finish;
  end
endmodule
