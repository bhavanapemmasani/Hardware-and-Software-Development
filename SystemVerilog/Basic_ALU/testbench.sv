module tb_basicalu;
  parameter DATA_WIDTH=4;
  logic [DATA_WIDTH-1:0] a;
  logic [DATA_WIDTH-1:0] b;
  logic [2:0] op_code;
  logic [DATA_WIDTH-1:0] out;
  
  basic_alu tb(.a(a),.b(b),.op_code(op_code),.out(out));
  
  initial begin
    a=4'b0000; b=4'b0000; op_code=0;
    #10; a=4'b0010; b=4'b0110; op_code=0;
    #10; a=4'b1101; b=4'b0001; op_code=1;
    #10; a=4'b0011; b=4'b0001; op_code=2;
    #10; a=4'b0011; b=4'b1010; op_code=3;
    #10; a=4'b0010; b=4'b1010; op_code=4;
    #10; a=4'b0101; b=4'b0101; op_code=5;
    
    #10; $finish;
    
    
  end
  
  
  initial begin
    $monitor("Time: %0t, a: %b, b: %b, Selected opcode is: %d, Output is: %b", $time, a, b, op_code, out);
  end
endmodule

  
  