module trailing_zeros #(parameter DATA_WIDTH=8) (
  input logic [DATA_WIDTH-1:0] data_input,
  output logic [$clog2(DATA_WIDTH+1)-1:0] trailing_count);
  always_comb begin
    trailing_count=0;
    if(data_input==0) begin
      trailing_count=32;
    end else begin
      for(int i=0;i<DATA_WIDTH; i++) begin
        if(data_input[i]==1) begin
          trailing_count=i;
          break;
        end
      end
    end
  end
endmodule