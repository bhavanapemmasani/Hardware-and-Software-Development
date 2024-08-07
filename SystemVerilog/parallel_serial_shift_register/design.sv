module parallel_serial_sr #(parameter INPUT_WIDTH=8)
  (input logic clk,
   input logic enable,
   input logic reset,
   input logic [INPUT_WIDTH-1:0] data_in,
   output logic data_out);
  
  reg [INPUT_WIDTH-1:0] shift_reg;
  reg [4:0] shift_counter;
  
  always @(posedge clk or negedge reset) begin
    if(!reset) begin
      shift_reg<=0;
      data_out<=0;
      shift_counter<=0;
    end
    else begin 
      if(enable) begin
        shift_reg<=data_in;
        shift_counter<=0;
      end
      else if (shift_counter < INPUT_WIDTH) begin
        data_out<=shift_reg[shift_counter];
        shift_counter<=shift_counter+1;
      end
      else begin
        data_out<=0;
      end
    end
  end
endmodule

   