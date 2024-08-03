module bit_counter #(parameter DATA_WIDTH=32) (
  input logic [DATA_WIDTH-1:0] data_input,
  //output logic [DATA_WIDTH-1:0] count);
  output logic [$clog2(DATA_WIDTH+1)-1:0] count);
  
  always_comb begin
    count=$countones(data_input);
  end
endmodule


  
 