module reversing_bits #(parameter DATA_WIDTH=8) (
  input logic [DATA_WIDTH-1:0] data_in, 
  output logic [DATA_WIDTH-1:0] data_out);
  
  always_comb begin
    for (int i=0;i<DATA_WIDTH;i++) begin
      data_out[i]=data_in[DATA_WIDTH-1-i];
    end
  end
endmodule
