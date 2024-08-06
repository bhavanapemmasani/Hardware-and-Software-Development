module rising_edge_detector (
  input logic clk,
  input logic resetn,
  input logic data_in,
  output logic data_out);
  
  logic prev_data_in;
  
  always_ff @(posedge clk or negedge resetn) begin
    if(!resetn) begin
      prev_data_in<=0; 
    end else begin
      prev_data_in<=data_in;
    end
    
  end
  always_ff @(posedge clk or negedge resetn)
    begin
      if(!resetn) begin
        data_out<=0;
      end
      else begin
        if (data_in && !prev_data_in) begin
          data_out=1;
        end
        else begin
          data_out=0;
        end
      end
    end
endmodule

  
      