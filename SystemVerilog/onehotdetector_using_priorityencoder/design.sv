module priority_encoder #(parameter DATA_WIDTH=8) (
  input logic [DATA_WIDTH-1:0] data_in,
  output logic [$clog2(DATA_WIDTH)-1:0] pos,
  output logic valid);
  
  always_comb begin
    pos=0;
    valid=0;
    for(int i=DATA_WIDTH-1; i>=0; i--) begin
      if (data_in[i]==1'b1) begin
        pos=i;
        valid=1;
      end
    end
  end
endmodule

module one_hot_detector #(parameter DATA_WIDTH=8) (
  input logic [DATA_WIDTH-1:0] data_in,
  output logic is_one_hot);
  
  logic [$clog2(DATA_WIDTH)-1:0] pos;
  logic valid;
  
  priority_encoder #(DATA_WIDTH) pe(.data_in(data_in), .pos(pos),.valid(valid));
  
  always_comb begin
    if(valid==1 && (data_in==(1<<pos))) begin
      is_one_hot=1;
    end
    else begin is_one_hot=0;
    end
  end
endmodule
  