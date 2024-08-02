module router #(parameter DATA_WIDTH = 8) (
    input logic clk,
    input logic rst,
    input logic [DATA_WIDTH-1:0] data_in[3:0],
    input logic [1:0] destination[3:0],
    output logic [DATA_WIDTH-1:0] data_out[3:0],
    output logic valid[3:0]
);
    
    // Internal signals to buffer the incoming data
    logic [DATA_WIDTH-1:0] buffer_data[3:0];
    logic [1:0] buffer_address[3:0];
    logic buffer_valid[3:0];
    
    // Data buffering
    always_ff @(posedge clk or negedge rst) begin
        if (!rst) begin
            for (int i = 0; i < 4; i++) begin
                buffer_data[i] <= 0;
                buffer_address[i] <= 0;
                buffer_valid[i] <= 0;
            end
        end else begin
            for (int i = 0; i < 4; i++) begin
                buffer_data[i] <= data_in[i];
                buffer_address[i] <= destination[i];
                buffer_valid[i] <= 1'b1;
            end
        end
    end
    
    // Routing Logic
    always_ff @(posedge clk or negedge rst) begin
        if (!rst) begin
            for (int i = 0; i < 4; i++) begin
                data_out[i] <= 0;
                valid[i] <= 0;
            end
        end else begin
            for (int i = 0; i < 4; i++) begin
                data_out[i] <= 0;
                valid[i] <= 0;
            end
            for (int i = 0; i < 4; i++) begin
                if (buffer_valid[i]) begin
                    case (buffer_address[i])
                        2'b00: begin
                            data_out[0] <= buffer_data[i];
                            valid[0] <= 1'b1;
                        end
                        2'b01: begin
                            data_out[1] <= buffer_data[i];
                            valid[1] <= 1'b1;
                        end
                        2'b10: begin
                            data_out[2] <= buffer_data[i];
                            valid[2] <= 1'b1;
                        end
                        2'b11: begin
                            data_out[3] <= buffer_data[i];
                            valid[3] <= 1'b1;
                        end
                        default: ;
                    endcase
                end
            end
        end
    end
    
endmodule
