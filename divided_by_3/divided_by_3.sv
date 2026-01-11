module divided_by_3_tb();
   logic   i_clk;
   logic   i_rst;
   logic   mod0= 0;
   logic   mod1= 1;
   logic   mod2= 2;
   logic   mod3= 3;
   logic   modr= 0;
   logic   state;

   initial begin
      i_clk = 0;
      #0 i_rst = 1;
      @(posedge i_clk);
      @(posedge i_clk);
      @(posedge i_clk);
      #0 i_rst = 0;

   end
   
   always #2 i_clk = ~i_clk;
   
   
   //divided_by_3..
   always_ff @(posedge i_clk) begin
      if(i_rst == 1) begin
         state <= modr;
      end else begin
         
      end 
   end 
      
endmodule