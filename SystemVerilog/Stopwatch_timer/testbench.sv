module tb_timer;
  logic clk;
  logic rst;
  logic start;
  logic stop;
  logic [15:0] count;
  
  stopwatch_timer uut(.clk(clk),.rst(rst),.start(start),.stop(stop),.count(count));
  
  initial begin
    clk=0;
    forever #5 clk=~clk;
  end
  initial begin
    rst=1;
    #10
    rst=0;
    
    start=1'b1;
    #10; start=0;
    #100;
    
    stop=1'b1;
    #10;stop=0;
    #50;
    
    start=1;
    #10 start=0;
    #100;
    
    rst=1; #10 rst=0;
    #50;
    $finish;
  end
  
  //monitoring
  initial begin
    $monitor("Time: %0t, start: %b, stop: %b, count: %h, rst: %b", $time, start,stop,count,rst);
  end
endmodule

  
    
    
    
 