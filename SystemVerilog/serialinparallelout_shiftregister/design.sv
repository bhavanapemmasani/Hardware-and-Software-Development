module serial_in_parallel_out #(parameter DATA_WIDTH=8) (
  input logic data_in,
  input logic clk,
  input logic reset,
  output logic [DATA_WIDTH-1:0] data_out);
  
  always @ (posedge clk or negedge reset) begin
    if (!reset) begin
      data_out<=0;
    end else begin
      data_out<={data_out[DATA_WIDTH-2:0], data_in};
    end
  end
endmodule

        
    