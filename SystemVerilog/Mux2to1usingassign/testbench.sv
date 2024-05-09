module tb_Mux2to1;
  logic a, b, sel;
  logic out;
  
  Mux2to1 mux_inst(
    .a(a), .b(b), .sel(sel), .out(out));
  
  initial begin 
    $dumpfile("dump.vcd");
    $dumpvars(1);
  end
  
  initial begin
    a = 0; b = 1; sel = 0;
    #10ns;
    //$display("Input: a=%b, b=%b, sel=%b, Output: out=%b", a, b, sel, out);
    #10ns a = 0; b = 1; sel = 1;
   	#20ns; // Wait for the output to update
    //$display("Input: a=%b, b=%b, sel=%b, Output: out=%b", a, b, sel, out);
    #10ns a = 1; b = 0; sel = 0;
    #20ns; // Wait for the output to update
    //$display("Input: a=%b, b=%b, sel=%b, Output: out=%b", a, b, sel, out);
    #10ns a = 1; b = 0; sel = 1;
    #20ns; // Wait for the output to update
    //$display("Input: a=%b, b=%b, sel=%b, Output: out=%b", a, b, sel, out);
    $display("Finished!..");
    $finish;
  end
endmodule
