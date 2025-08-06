module sequence_detector (
  input logic in,
  input logic clk,
  input logic rst,
  output logic seq);
  
  typedef enum logic [2:0] {S0, S1, S2, S3, S4, S5} state;
  
  state current_state, next_state;
  
  always_comb begin
    seq=0;
    case(current_state) 
      S0: begin
        if(in) next_state=S1;
        else next_state=S0;
      end
      S1: begin
        if(in) next_state=S1;
        else next_state=S2;
      end
      S2: begin
        if(in) next_state=S3;
        else next_state=S0;
      end
      S3: begin
        if(in) next_state=S4;
        else next_state=S2;
      end
      S4: begin
        if(in) next_state=S1;
        else next_state=S5;
      end
      S5: begin
        if(in) begin
          seq=1;
          next_state=S1;
        end
        else begin
          seq=0;
          next_state=S0;
        end
      end
      default: next_state=S0;
    endcase
  end
  
  always_ff @(posedge clk or posedge rst) begin
    if(rst) current_state<=S0;
    else current_state<=next_state;
  end
  
endmodule

interface sequence_if;
  logic clk;
  logic rst;
  logic in;
  logic seq;
endinterface