module tb_router;
  parameter DATA_WIDTH=8;
  logic clk;
  logic rst;
  logic [DATA_WIDTH-1:0] input_data[3:0];
  logic [DATA_WIDTH-1:0] output_data[3:0];
  logic[1:0] address[3:0];
  logic valid[3:0];
  
  router UUT(.clk(clk),.rst(rst),.data_in(input_data),.data_out(output_data),.destination(address),.valid(valid));
  
  //clock generation
  initial begin
    clk=0;
    forever #5 clk=~clk; //100MHz 
  end
  initial begin
    rst=0;
    #10;
    rst=1;
  	input_data[0]=8'hA1; address[0]=2'b00;
  	input_data[1]=8'hB2; address[1]=2'b01;
  	input_data[2]=8'hC3; address[2]=2'b10;
  	input_data[3]=8'hD4; address[3]=2'b11;
  
  	#10;
  
  	input_data[0]=8'h55; address[0]=2'b10;
  	input_data[1]=8'hAA; address[1]=2'b11;
  	input_data[2]=8'h33; address[2]=2'b00;
  	input_data[3]=8'h77; address[3]=2'b01;
  
  	#10;
    $finish;
  end
  
  //Monitoring
  initial begin
    $monitor("Time: %0t, output_data[0]=%h, output_data[1]=%h, output_data[2]=%h, output_data[3]=%h", $time, output_data[0], output_data[1], output_data[2], output_data[3]);
  end
  
endmodule

  
  
  
  
  