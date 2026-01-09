module fibonacci_generator_tb();
   logic   i_clk;
   logic   i_rst;
   logic   [1023:0] init_seq1;
   logic   [1023:0] init_seq2;

   initial begin
      i_clk = 0;
      #0 i_rst = 1;
      @(posedge i_clk);
      @(posedge i_clk);
      @(posedge i_clk);
      #0 i_rst = 0;

   end
   
   always #2 i_clk = ~i_clk;
   
   
   //fifonacci series
   // 1 1 2 3 5 8 13 21 ...
   always_ff @(posedge i_clk) begin
      if(i_rst == 1) begin
         init_seq1   <= 1024'h1;
         init_seq2   <= 1024'h0;
      end else begin
         init_seq1   <= init_seq1 + init_seq2;
         init_seq2   <= init_seq1;
      end 
   end 
      
endmodule