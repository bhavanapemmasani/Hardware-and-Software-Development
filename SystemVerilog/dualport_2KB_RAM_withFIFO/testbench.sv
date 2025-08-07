module dualport_2_KB_RAM_FIFO_tb;
  logic clk;
  logic reset;
  
  //Port A
  logic wr_en_a;
  logic rd_en_a;
  logic [7:0] data_in_a;
  logic [10:0] address_in_a;
  logic [7:0] rd_data_a;
  logic wr_ack_a;
  
  //Port B
  logic wr_en_b;
  logic rd_en_b;
  logic [7:0] data_in_b;
  logic [10:0] address_in_b;
  logic [7:0] rd_data_b;
  logic wr_ack_b;
  
  //Instantiation
  dualport_2KB_RAM_FIFO dut (.clk(clk),
                             .reset(reset),
                             
                             .wr_en_a(wr_en_a),
                             .rd_en_a(rd_en_a),
                             .data_in_a(data_in_a),
                             .address_in_a(address_in_a),
                             .rd_data_a(rd_data_a),
                             .wr_ack_a(wr_ack_a),
                             
                             .wr_en_b(wr_en_b),
                             .rd_en_b(rd_en_b),
                             .data_in_b(data_in_b),
                             .address_in_b(address_in_b),
                             .rd_data_b(rd_data_b),
                             .wr_ack_b(wr_ack_b));
  //clock
  initial begin
    clk=0;
    forever #5 clk=~clk;
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
    
    
    //Normal writes to Port A
    @(posedge clk);
    wr_en_a=1;
    address_in_a=11'd20;
    data_in_a=8'hAA;//writing 170 to address 20 from Port A
    
    @(posedge clk);
    wr_en_a=0;
    
    //Normal write to Port B
    @(posedge clk);
    wr_en_b=1;
    address_in_b=11'd10;
    data_in_b=8'h2D; //writing 45 to address 10 from Port B
    
    @(posedge clk);
    wr_en_b=0;
    
    //Normal read from port A
    @(posedge clk);
    rd_en_a=1;
    address_in_a=11'd10;
    #2 $display ("Reading from Port A: at %d: %d", address_in_a, rd_data_a);
    
    @(posedge clk);
    rd_en_a=0;
    
    @(posedge clk);
    rd_en_b=1;
    address_in_b=11'd20;
    #2 $display("Reading from Port B: at %d: %d", address_in_b, rd_data_b);
    
    @(posedge clk);
    rd_en_b=0;
    
    //Simultaneous writes to same address from both the ports
    @(posedge clk);
    wr_en_a=1; wr_en_b=1;
    address_in_a=11'd40; address_in_b=11'd40;
    data_in_a=8'hB5;//writing 181 to address 40 from Port A
    data_in_b=8'hC5;//writing 197 to address 40 from Port B
    
    @(posedge clk);
    wr_en_a=1;
    wr_en_b=0;
    
    repeat(2) @ (posedge clk); //waiting for 2 clock cycles for FIFO to process
    
    //Reading from that address
    @(posedge clk);
    rd_en_a=1;
    address_in_a=11'd40;
    @(posedge clk);
    $display("Simultaneous writes to same address: reading from port A: at %d: %d", address_in_a, rd_data_a);
    rd_en_a=0;
    
  end
  
  initial begin
    #500;
    $finish;  
  end
endmodule