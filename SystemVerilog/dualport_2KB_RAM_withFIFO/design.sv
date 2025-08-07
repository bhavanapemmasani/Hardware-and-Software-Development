//Dual-Port 2KB RAM with Conflict-Resolution FIFO 
/* Supports simultaneous read and write operations from two independent ports (Port A and Port B).
Uses a shared single clock.
Performs asynchronous read access.
Provides synchronous write access with synchronous reset.
Handles write conflicts to the same memory address using a FIFO queue.
*/

/*Memory Size: 2KB (2048 bytes), 8-bit wide
Address Width: 11 bits
Data Width: 8 bits (1 byte)
Dual-Port Access: Both ports can independently read/write from/to memory.
Simultaneous Write Conflict Handling: If both ports try to write to the same address at the same time, the design->Enqueues the write requests in a FIFO->Commits them sequentially in first-come-first-served (FCFS) order.
Read is combinational, meaning values are available immediately after address is set and rd_en is high.

*/

module dualport_2KB_RAM_FIFO (
  input logic clk,
  input logic reset,

  // Port A
  input logic wr_en_a,
  input logic rd_en_a,
  input logic [7:0] data_in_a,
  input logic [10:0] address_in_a,
  output logic [7:0] rd_data_a,
  output logic wr_ack_a,

  // Port B
  input logic wr_en_b,
  input logic rd_en_b,
  input logic [7:0] data_in_b,
  input logic [10:0] address_in_b,
  output logic [7:0] rd_data_b,
  output logic wr_ack_b
);

  // 2KB Memory: 2048x8-bit
  logic [7:0] mem [0:2047];

  // FIFO write request type
  typedef struct packed {
    logic [10:0] addr;
    logic [7:0] data;
    logic port_id;  // 0 for A, 1 for B
  } write_req_t;

  // FIFO Queue
  write_req_t write_queue[$];

  // Sequential logic for writes and FIFO
  always_ff @(posedge clk) begin
    if (reset) begin
      wr_ack_a <= 0;
      wr_ack_b <= 0;
      write_queue = {};  // clear queue
    end else begin
      wr_ack_a <= 0;
      wr_ack_b <= 0;

      // Case 1: Simultaneous write to same address
      if (wr_en_a && wr_en_b && (address_in_a == address_in_b)) begin
        write_queue.push_back('{addr: address_in_a, data: data_in_a, port_id: 0});
        write_queue.push_back('{addr: address_in_b, data: data_in_b, port_id: 1});
      end else begin
        // Case 2: Port A write
        if (wr_en_a) begin
          mem[address_in_a] <= data_in_a;
          wr_ack_a <= 1;
        end
        // Case 3: Port B write
        if (wr_en_b) begin
          mem[address_in_b] <= data_in_b;
          wr_ack_b <= 1;
        end
      end

      // Case 4: Handle one queued write per cycle
      if (write_queue.size() > 0) begin
        write_req_t req = write_queue.pop_front();
        mem[req.addr] <= req.data;
        if (req.port_id == 0)
          wr_ack_a <= 1;
        else
          wr_ack_b <= 1;
      end
    end
  end

  // Read logic (asynchronous)
  always_comb begin
    rd_data_a = rd_en_a ? mem[address_in_a] : 8'h00;
    rd_data_b = rd_en_b ? mem[address_in_b] : 8'h00;
  end

endmodule


/*Example Use Cases
This design is ideal for: Multi-core processor memory access, Shared memory controllers, Embedded systems where two agents (DMA & CPU) access RAM, Verification environments simulating concurrent accesses */