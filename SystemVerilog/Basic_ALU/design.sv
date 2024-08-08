module basic_alu #(parameter DATA_WIDTH=4) (
  input logic [DATA_WIDTH-1:0] a,
  input logic [DATA_WIDTH-1:0] b,
  input logic [2:0] op_code,
  output logic [DATA_WIDTH-1:0] out);
  
  always_comb begin
    case (op_code)
    	0: out=a+b;
    	1: out=a-b;
    	2: out=~a;
    	3: out=a&b;
    	4: out=a|b;
    	5: out=a^b;
    	default: ;
  	endcase
  end
  
endmodule
      