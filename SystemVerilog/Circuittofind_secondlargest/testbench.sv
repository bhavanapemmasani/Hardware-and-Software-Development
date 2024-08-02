module tb_secondlargest;
  parameter DATA_WIDTH=2;
  logic clk;
  logic rst;
  logic [DATA_WIDTH-1:0] data_in;
  logic [DATA_WIDTH-1:0] data_out;
  
  circuit_second_largest uut(.clk(clk),.rst(rst),.data_in(data_in),.data_out(data_out));
  
  //clock generation
  initial begin
    clk=0;
    forever #5 clk=~clk;
  end
  
  initial begin
    rst=0;
    #10 rst=1;
    
    data_in=2'b10; #10; data_in=2'b11; #10; data_in=2'b01;
    #10;
    $finish;
  end
  
  initial begin
    $monitor("Time:%0t | data_out=%b", $time, data_out);
  end
endmodule

    