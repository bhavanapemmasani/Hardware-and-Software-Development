module tb_palindrome;
  parameter DATA_WIDTH=8;
  logic [DATA_WIDTH-1:0] data_in;
  logic is_palindrome;
  
  palindrome_detector DUT(.data_in(data_in),.is_palindrome(is_palindrome));
  
  initial begin
    #10; data_in=8'b10100101;
    #10; data_in=8'b00010000;
    #10; data_in=8'b10000001;
    
    #10;
    $finish;
  end
  
  initial begin
    $monitor("Time: %0t, Input: %b, Is Palindrome? %b", $time, data_in, is_palindrome);
  end
endmodule
