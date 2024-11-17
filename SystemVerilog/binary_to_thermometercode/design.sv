module binary_to_thermometer (
  input logic [7:0] binary_in,
  output logic [255:0] thermometer_code);
  
  always @ (*) begin
    thermometer_code=0;
    for(int i=0; i<binary_in; i++) begin
      thermometer_code[i]=1'b1;
    end
  end
endmodule