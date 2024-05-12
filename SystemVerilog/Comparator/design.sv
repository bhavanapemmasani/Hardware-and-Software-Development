module comparator(input logic [3:0] A, B,
                  output logic greater, equal, lesser);
  
  always @(*) begin
    greater=0;
    equal=0;
    lesser=0;
    if (A>B) begin
      greater=1;
    end
    else if (A==B) begin
      equal=1;
    end
    else begin
      lesser=1;
    end
  end
endmodule

    
                  