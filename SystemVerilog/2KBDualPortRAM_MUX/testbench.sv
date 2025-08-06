// Code your testbench here
// or browse Examples
module dualport_2KB_RAM_tb;
  logic clk;
  logic reset;
  logic sel;
  
  //Port A
  logic wr_en_a;
  logic rd_en_a;
  logic wr_ack_a;
  logic [7:0] data_in_a;
  logic [10:0] address_in_a;
  logic [7:0] rd_data_a;
  
  //port B
  logic wr_en_b;
  logic rd_en_b;
  logic wr_ack_b;
  logic [7:0] data_in_b;
  logic [10:0] address_in_b;
  logic [7:0] rd_data_b;
  
  //Instantiation
  dualport_2KB_RAM dut(.clk(clk),
                       .reset(reset),
                       .sel(sel),
                       .wr_en_a(wr_en_a),
                       .rd_en_a(rd_en_a),
                       .wr_ack_a(wr_ack_a),
                       .data_in_a(data_in_a),
                       .address_in_a(address_in_a),
                       .rd_data_a(rd_data_a),
                       .wr_en_b(wr_en_b),
                       .rd_en_b(rd_en_b),
                       .wr_ack_b(wr_ack_b),
                       .data_in_b(data_in_b),
                       .address_in_b(address_in_b),
                       .rd_data_b(rd_data_b));
  //clock
  initial begin
    clk=0;
    forever #5 clk=~clk;
  end
  
  
  initial begin
    //initialization
    reset=1;
    sel=0;
    wr_en_a=0;
    wr_en_b=0;
    rd_en_a=0;
    rd_en_b=0;
    data_in_a=0;
    data_in_b=0;
    address_in_a=0;
    address_in_b=0;
    
    #10; reset=0;
    
    //Writing and reading from Port A
    
    @(posedge clk);
    wr_en_a=1;
    address_in_a=11'd10;
    data_in_a=8'h4B;//writing 75 to address 10 from Port A
    
    @(posedge clk);
    wr_en_a=0;
    
    @(posedge clk);
    rd_en_a=1;
    address_in_a=11'd10;
    #2 $display("Reading from Port A: at address %d: %d", address_in_a, rd_data_a);
    
    
    @(posedge clk);
    rd_en_a=0;
    
    //Writing and reading from Port B
    @(posedge clk);
    wr_en_b=1;
    address_in_b=11'd30;
    data_in_b=8'hA5; //writing 165 to address 30 from Port B
    
    @(posedge clk);
    wr_en_b=0;
    
    @(posedge clk);
    rd_en_b=1;
    address_in_b=11'd30;
    #2 $display("Reading from Port B: at address %d: %d", address_in_b, rd_data_b);
    
    @(posedge clk);
    rd_en_b=0;
    
    
    //cross port reads
    
    //writing from port A and reading from port B
    @(posedge clk);
    wr_en_a=1;
    address_in_a=11'd20;
    data_in_a=8'h3C; //Writing 60 to address 20 from Port A
    
    @(posedge clk);
    wr_en_a=0;
    
    
    @(posedge clk);
    rd_en_b=1;
    address_in_b=11'd20;
    #2 $display("Cross port reading: Reading from Port B: at address %d: %d", address_in_b, rd_data_b);
    
    @(posedge clk);
    rd_en_b=0;
    
    //writing from port B and reading from port A
    @(posedge clk);
    wr_en_b=1;
    address_in_b=11'd60;
    data_in_b=8'h33;//writing 51 to address 60 from Port B
    
    @(posedge clk);
    wr_en_b=0;
    
    @(posedge clk);
    rd_en_a=1;
    address_in_a=11'd60;
    #2 $display("Cross port reading: Reading from Port A: at address %d: %d", address_in_a, rd_data_a);
    
    @(posedge clk);
    rd_en_a=0;
    
    
    
    //simultaneous reads from the same address from both ports
    @(posedge clk);
    wr_en_a=1;
    address_in_a=11'd35;
    data_in_a=8'h32; //writing 50 to address 35 from Port A
    
    @(posedge clk);
    wr_en_a=0;
    
    @(posedge clk);
    rd_en_a=1;
    rd_en_b=1;
    
    address_in_a=11'd35;
    address_in_b=11'd35;
    
    #2 $display("Simultaneous reads from both ports: Port A- address: %d, data: %d", address_in_a, rd_data_a);
    
    #2 $display("Simultaneous reads from both ports: Port B- address: %d, data: %d", address_in_b, rd_data_b);
    
    @(posedge clk);
    rd_en_a=0;
    rd_en_b=0;
    
    
    //Simultaneous writes to same address with sel = 0 (A wins) 
    @(posedge clk);
    sel = 0;
    wr_en_a = 1;
    wr_en_b = 1;
    address_in_a = 11'd100;
    address_in_b = 11'd100;
    data_in_a = 8'hAA;
    data_in_b = 8'hBB;
    @(posedge clk);
    wr_en_a = 0;
    wr_en_b = 0;
    @(posedge clk);
    rd_en_a = 1;
    address_in_a = 11'd100;
    #2 $display("Simul Write sel=0 -> A wins, Read A: addr = %0d, data = %0d", address_in_a, rd_data_a);
    @(posedge clk);
    rd_en_a = 0;

    //Simultaneous writes to same address with sel = 1 (B wins)
    @(posedge clk);
    sel = 1;
    wr_en_a = 1;
    wr_en_b = 1;
    address_in_a = 11'd101;
    address_in_b = 11'd101;
    data_in_a = 8'hCC;
    data_in_b = 8'hDD;
    @(posedge clk);
    wr_en_a = 0;
    wr_en_b = 0;
    @(posedge clk);
    rd_en_b = 1;
    address_in_b = 11'd101;
    #2 $display("Simul Write sel=1 -> B wins, Read B: addr = %0d, data = %0d", address_in_b, rd_data_b);
    @(posedge clk);
    rd_en_b = 0;

  end
  
  initial begin
    #300;
    $finish;
  end
endmodule
  
                       
                       