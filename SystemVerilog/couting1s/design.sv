module bit_counter #(parameter DATA_WIDTH=32) (
  input logic [DATA_WIDTH-1:0] data_input,
  //output logic [DATA_WIDTH-1:0] count);
  output logic [$clog2(DATA_WIDTH+1)-1:0] count);
  
  always_comb begin
    count=0;
    for (int i=0; i<DATA_WIDTH; i++) begin
      if(data_input[i]==1'b1) begin
        count=count+1;
      end
    end
  end
endmodule

  
 