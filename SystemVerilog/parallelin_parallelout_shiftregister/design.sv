module parallel_in_parallel_out_shiftregister #(parameter DATA_WIDTH=8) (
  input logic [DATA_WIDTH-1:0] parallel_in,
  input logic clk,
  input logic reset,
  input logic load,
  output logic [DATA_WIDTH-1:0] parallel_out);
  
  always @ (posedge clk or negedge reset) begin
    if(!reset) begin
      parallel_out<=0;
    end 
    else begin
      if(load) begin
        parallel_out<=parallel_in;
      end
      else begin
        parallel_out<=0;
      end
    end
  end
endmodule

 
