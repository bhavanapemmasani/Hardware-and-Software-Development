// 2KB RAM: Stores data in bytes, synchronous reset, Data Width: 8-bit (1 Byte)
// Address Width: 2KB = 2^11 = 2048 addresses (11 bits), single clock
// Dual-port with conflict resolution using select line (sel)

module dualport_2KB_RAM (
  input  logic clk,
  input  logic reset,
  input  logic sel,  // MUX select for write conflict resolution

  // Port A
  input  logic wr_en_a,
  input  logic rd_en_a,
  input  logic [10:0] address_in_a,
  input  logic [7:0]  data_in_a,
  output logic wr_ack_a,
  output logic [7:0]  rd_data_a,

  // Port B
  input  logic wr_en_b,
  input  logic rd_en_b,
  input  logic [10:0] address_in_b,
  input  logic [7:0]  data_in_b,
  output logic wr_ack_b,
  output logic [7:0]  rd_data_b
);

  // 2KB Memory: 2048 x 8-bit
  logic [7:0] mem [0:2047];

  // Write logic with conflict resolution using sel
  always_ff @(posedge clk) begin
    if (reset) begin
      wr_ack_a <= 0;
      wr_ack_b <= 0;
      
    end else begin
      if (wr_en_a && wr_en_b && (address_in_a == address_in_b)) begin
        if (sel) begin
          mem[address_in_b] <= data_in_b;
          wr_ack_a <= 0;
          wr_ack_b <= 1;
        end else begin
          mem[address_in_a] <= data_in_a;
          wr_ack_a <= 1;
          wr_ack_b <= 0;
        end
      end else begin
        if (wr_en_a) begin
          mem[address_in_a] <= data_in_a;
          wr_ack_a <= 1;
        end else begin
          wr_ack_a <= 0;
        end

        if (wr_en_b) begin
          mem[address_in_b] <= data_in_b;
          wr_ack_b <= 1;
        end else begin
          wr_ack_b <= 0;
        end
      end
    end
  end

  // Asynchronous reads
  always_comb begin
    rd_data_a = (rd_en_a) ? mem[address_in_a] : 8'b0;
    rd_data_b = (rd_en_b) ? mem[address_in_b] : 8'b0;
  end

endmodule
