module comparator (
    input logic [3:0] A, B,
    input logic reset,
    output logic greater, equal, lesser
);

    always @* begin
        // Reset outputs when reset signal is asserted
        if (reset) begin
            greater = 1'b0;  
            equal = 1'b0; 
            lesser = 1'b0;
        end
        else begin
            // Initialize outputs to default values
            greater = 1'b0;  
            equal = 1'b0; 
            lesser = 1'b0;
            
            // Determine the relationship between A and B
            if (A > B) begin
                greater = 1'b1;
            end
            else if (A == B) begin
                equal = 1'b1;
            end
            else begin
                lesser = 1'b1;
            end
        end
    end
endmodule
