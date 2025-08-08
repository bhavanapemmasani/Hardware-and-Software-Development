module dualport_2KB_RAM_partitioned_memory(input logic reset,
                                           input logic clk_a,
                                           input logic clk_b,
                                           
                                           //Port A
                                           input logic wr_en_a,
                                           input logic rd_en_a,
                                           input logic [7:0] data_in_a,
                                           input logic [10:0] address_in_a,
                                           output logic [7:0] rd_data_a,
                                           output logic wr_ack_a,
                                           
                                           //Port B
                                           input logic wr_en_b,
                                           input logic rd_en_b,
                                           input logic [7:0] data_in_b,
                                           input logic [10:0] address_in_b,
                                           output logic [7:0] rd_data_b,
                                           output logic wr_ack_b);
  
  //2KB Memory: 2048 locations, 8 bits
  logic [7:0] mem_a [0:1023];
  logic [7:0] mem_b [1024:2047];
  
  //Port A write- 0 to 1023
  always_ff @(posedge clk_a) begin
    if(reset) wr_ack_a<=0; 
    else begin
      if(wr_en_a && address_in_a<1024) begin
        mem_a[address_in_a]<=data_in_a;
        wr_ack_a<=1;
      end
      else wr_ack_a<=0;
    end
  end

  //Port B write- 1024 t0 2047
  always_ff @(posedge clk_b) begin
    if(reset) wr_ack_b<=0;
    else begin
      if(wr_en_b && address_in_b>=1024 && address_in_b<2048) begin
        mem_b[address_in_b]<=data_in_b;
        wr_ack_b<=1;
      end
      else wr_ack_b<=0;
    end
  end

  //Asynchronous reads: Port A
  always_comb begin
    if(rd_en_a && address_in_a<1024) 
      rd_data_a=mem_a[address_in_a];
    else rd_data_a=8'h00;
  end

  //Asynchronous reads: Port B
  always_comb begin
    if(rd_en_b && address_in_b>=1024 && address_in_b<2048) 
      rd_data_b=mem_b[address_in_b];
    else rd_data_b=8'h00;
  end

endmodule
