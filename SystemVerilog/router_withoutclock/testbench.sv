module tb_router;
  //logic clk;
  logic din_en;
  logic [1:0] address;
  logic [31:0] din;
  logic [31:0] dout0;
  logic [31:0] dout1;
  logic [31:0] dout2;
  logic [31:0] dout3;
  
  router uut(.din_en(din_en), .addr(address),.din(din),.dout0(dout0),.dout1(dout1),.dout2(dout2),.dout3(dout3));
  
  initial begin
    din_en=0; din=32'b0; address=2'b01;
    #10 din_en=1; din=32'hA1B2C3D4;
    #10 din_en=0;
    #10 address=2'b10; #10 din_en=1;  din=32'h87654321;
    #10 din_en=0;
    #10;
    $finish;
  end
  
  initial begin
    $monitor("Time: %0t, din_en=%b, din=%h, address=%b, dout1=%h, dout2=%h, dout3=%h", $time, din_en, din, address, dout1, dout2, dout3);
  end
endmodule
  
  