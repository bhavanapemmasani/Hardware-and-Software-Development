module Mux2to1 (
    input wire a,
    input wire b,
    input wire sel,
    output reg out
);

assign out = (sel == 1) ? b : a;

endmodule