//Random testing
module tb;
  logic d, clk, reset;
  logic q, qbar;
  
  //parameter NUM_TESTS=10;
  //parameter MAX_DELAY=10;
  
  d_ff dut(.d(d),.clk(clk),.reset(reset),.q(q),.qbar(qbar));
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(1);
  end
  
  //clock generation
  initial begin
    clk=1;
    forever #5 clk=~clk;
  end
  
  //Reset Assertion
  initial begin
    reset=1;
    #10 reset=0;
  end
  
  initial begin
  //Applying random stimulus
    repeat(5) begin
      //#(random()%MAX_DELAY);//Random delay: random()-system function generates a 32 bit integer value
      //random()%MAX_DELAY: Modulus operator:  generates random delay value from 0 to MAX_DELAY-1
      #10;
      d=$random;
      $display("D=%b,q=%b,qbar=%b", d,q,qbar);
    end
    //#(random()%MAX_DELAY);
    #10;
    $finish;
  end
endmodule

  
      