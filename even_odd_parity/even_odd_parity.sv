// Code your testbench here
// or browse Examples
module parity_tb();
  logic clock;
  logic reset;
  logic [31:0] data = $urandom;
  logic        parity_check;
  logic        even_parity;
  logic        odd_parity;
  initial begin
    clock = 0;
    reset = 1;
    @(posedge clock);
    @(posedge clock);
    reset = 0;
  end

  always #2 clock = ~clock;


  //parity check
  //parity means number of ones in a data
  //Number of 1's is even, even parity
  //Number of 1's is odd, odd parity
  always_ff @(posedge clock) begin
    parity_check <= ^data;
    even_parity  <= ~(parity_check);
    odd_parity   <= parity_check;
    $display("%b %d,%d",data,even_parity,odd_parity);
  end


endmodule