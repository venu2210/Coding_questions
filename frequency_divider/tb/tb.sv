module key_gen_tb();
   logic                   i_clk;
   logic                   i_rst;

   initial begin
      i_clk = 0;
      i_rst = 1;
      @(posedge i_clk);
      @(posedge i_clk);
      i_rst = 0;

   end
   
   always #2 i_clk = ~i_clk;

   frequency_divider  frequency_divider1 (
      .i_clk              (i_clk),
      .i_rst              (i_rst),
      .o_freq_by_even        (),
      .o_freq_by_odd        ()
      );
      
endmodule