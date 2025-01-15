interface dff_if;
  logic clk;
  logic reset;
  logic din;
  logic dout;
endinterface

module dff (dff_if dif);
  always @(posedge dif.clk) begin
    
    if(dif.reset==1'b1) begin
      dif.dout<=0;
    end
    else dif.dout<=dif.din;
  
  end
endmodule  