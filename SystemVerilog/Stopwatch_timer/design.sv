module stopwatch_timer(
  input logic clk,
  input logic rst,
  input logic start,
  input logic stop,
  output logic[15:0] count
  
);
  
  localparam max=16'hFFFF;
  logic counting;
  
  always_ff @(posedge clk) begin
    if(rst) begin
      count<=0;
      counting<=0;
    end
    else if(stop) begin
      count<=0;
    end else if(start && !counting) begin
      counting<=1;
    end
    
    if(counting) begin
      if(count==max) begin
        count<=0;
      end
      else begin
        count<=count+1;
      end
    end
  end
endmodule
  
  