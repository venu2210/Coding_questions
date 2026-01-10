module palindrome_dectector_tb();
   localparam PALINDROME_LEN = 4;
   logic      i_clk;
   logic      i_rst;
   logic      [PALINDROME_LEN-1:0] data_in = 4'b1001;
   logic      [PALINDROME_LEN-1:0] data_rev;
   logic      out;

   initial begin
      i_clk = 0;
      #0 i_rst = 1;
      @(posedge i_clk);
      @(posedge i_clk);
      @(posedge i_clk);
      #0 i_rst = 0;

   end
   
   always #2 i_clk = ~i_clk;
   
   assign data_rev = {<<{data_in}};
   always_ff @(posedge i_clk) begin
      if(data_rev == data_in) begin
         out <= 1'b1;
      end else begin
         out <= 1'b0;
      end
   end 
      
endmodule