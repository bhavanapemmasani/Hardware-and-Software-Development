module dualport_2KB_RAM_partitioned_memory_tb;
  logic clk_a;
  logic clk_b;
  logic reset;
  logic wr_en_a;
  logic rd_en_a;
  logic [7:0] data_in_a;
  logic [10:0] address_in_a;
  logic wr_ack_a;
  logic [7:0] rd_data_a;
  logic wr_en_b;
  logic rd_en_b;
  logic [7:0] data_in_b;
  logic [10:0] address_in_b;
  logic wr_ack_b;
  logic [7:0] rd_data_b;
  
  //Instantiation
  dualport_2KB_RAM_partitioned_memory dut(
    .clk_a(clk_a),
    .clk_b(clk_b),
    .reset(reset),
    .wr_en_a(wr_en_a),
    .rd_en_a(rd_en_a),
    .data_in_a(data_in_a),
    .address_in_a(address_in_a),
    .wr_ack_a(wr_ack_a),
    .rd_data_a(rd_data_a),
    .wr_en_b(wr_en_b),
    .rd_en_b(rd_en_b),
    .data_in_b(data_in_b),
    .address_in_b(address_in_b),
    .wr_ack_b(wr_ack_b),
    .rd_data_b(rd_data_b));
                                         
  
  //clock
  initial begin
    clk_a=0;
    forever #5 clk_a=~clk_a;
  end
  
  initial begin
    clk_b=0;
    forever #7 clk_b=~clk_b;
  end
  
  initial begin
    //Initialization
    reset=1;
    wr_en_a=0;
    rd_en_a=0;
    wr_en_b=0;
    rd_en_b=0;
    data_in_a=0;
    data_in_b=0;
    address_in_a=0;
    address_in_b=0;
    
    #15 reset=0;
    
    //Writing and reading from Port A
    @(posedge clk_a);
    wr_en_a=1;
    address_in_a=11'd115;
    data_in_a=8'hC3;//Writing 195 to address 115
    
    @(posedge clk_a);
    wr_en_a=0;
    
    @(posedge clk_a);
    rd_en_a=1;
    address_in_a=11'd115;
    #2 $display("Reading from Port A at address %d: %d", address_in_a, rd_data_a);
    
    @(posedge clk_a);
    rd_en_a=0;
    
    //Writing and reading from Port B
    @(posedge clk_b);
    wr_en_b=1;
    address_in_b=11'd1025;
    data_in_b=8'h3C;//writing 60 to address 1025
    
    @(posedge clk_b);
    wr_en_b=0;
    
    @(posedge clk_b);
    rd_en_b=1;
    address_in_b=11'd1025;
    #2 $display("Reading from Port B at address %d: %d", address_in_b, rd_data_b);
    
    @(posedge clk_b);
    rd_en_b=0;
    
    //Trying out of bounds address
    //Port A
    @(posedge clk_a);
    wr_en_a=1;
    address_in_a=11'd1025;
    data_in_a=8'h01;
    
    @(posedge clk_a);
    wr_en_a=0;
    
    @(posedge clk_a);
    rd_en_a=1;
    address_in_a=11'd1025;
    #2 $display("Reading from Port A at address: %d: %d", address_in_a, rd_data_a);
    
    @(posedge clk_a);
    rd_en_a=0;
    
    //Port B
    @(posedge clk_b);
    wr_en_b=1;
    address_in_b=11'd1023;
    data_in_b=8'h11;
    
    @(posedge clk_b);
    wr_en_b=0;
    
    @(posedge clk_b);
    rd_en_b=1;
    address_in_b=11'd1023;
    #2 $display("Reading from Port B at address: %d: %d", address_in_b, rd_data_b);
    
    @(posedge clk_b);
    rd_en_b=0;
    
  end
  
  
  
  initial begin
    #500
    $finish;
  end
endmodule

  