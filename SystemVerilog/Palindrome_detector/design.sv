module palindrome_detector #(parameter DATA_WIDTH=8) (
  input logic [DATA_WIDTH-1:0] data_in,
  output logic is_palindrome);
  
  always_comb begin
    is_palindrome=1;
    for(int i=0;i<DATA_WIDTH/2;i++) begin
      if(data_in[i]!=data_in[DATA_WIDTH-1-i]) begin
        is_palindrome=0;
      end
    end
  end
endmodule
      