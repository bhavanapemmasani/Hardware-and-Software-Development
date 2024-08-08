module one_hot_detector #(parameter DATA_WIDTH=8) (
  input logic [DATA_WIDTH-1:0] data_in,
  output logic detected);
  
  logic [DATA_WIDTH-1:0] mask;
  
  assign mask=data_in & (~data_in+1'b1);
  assign detected= (data_in!=0) && (mask==data_in);
  
endmodule

  