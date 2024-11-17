module divide_byevens_clockdivider (
  input logic clk,
  input logic resetn,
  output logic div2,
  output logic div4,
  output logic div6);
  
  logic [1:0] count_2;
  logic [2:0] count_4;
  logic [3:0] count_6;
  
  
  //clock divider for 2x
  always_ff @ (posedge clk or negedge resetn) begin
    if(!resetn) begin
      count_2<=0;
      div2<=0;
    end
    else begin
      count_2<=count_2+1;
      if(count_2==2'b01) begin
        div2=~div2;
      end
    end
  end
  
  //clock divider for 4x
  always_ff @ (posedge clk or negedge resetn) begin
    if(!resetn) begin
      count_4<=0;
      div4<=0;
    end
    else begin
      count_4<=count_4+1;
      if(count_4==3'b011) begin
        div4=~div4;
      end
    end
  end
  
  //clock divider for 6x
  always_ff @ (posedge clk or negedge resetn) begin
    if(!resetn) begin
      count_6<=0;
      div6<=0;
    end
    else begin
      count_6<=count_6+1;
      if(count_6==4'b0101) begin
        div6=~div6;
      end
    end
  end
endmodule

  
      