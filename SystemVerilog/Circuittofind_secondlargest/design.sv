module circuit_second_largest #(parameter DATA_WIDTH=2) (
  input logic clk,
  input logic rst,
  input logic [DATA_WIDTH-1:0] data_in,
  output logic [DATA_WIDTH-1:0] data_out);
  
  //internal signals
  logic [DATA_WIDTH-1:0] max1;
  logic [DATA_WIDTH-1:0] max2;
  
  always_ff @(posedge clk or negedge rst) begin
    if(!rst) begin
      max1<=0;
      max2<=0;
      data_out<=0;
    end
    else begin
      if(data_in>max1) begin
        max2<=max1;
        max1<=data_in;
      end
      else if(data_in<max1 && data_in>max2) begin
        max2<=data_in;
      end
      data_out<=max2;
    end
  end
endmodule
