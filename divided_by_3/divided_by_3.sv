module divided_by_3_tb();
   logic   i_clk;
   logic   i_rst;
   typedef enum logic [2:0] {
      mod0= 3'h1,
      mod1= 3'h2,
      mod2= 3'h3,
      mod3= 3'h4,
      modr= 3'h0 } state_t;
   state_t state;
   logic   in;
   logic   out;

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
         in    <= 0;
      end else begin
         in <= $urandom_range(0, 1);
         case(state)
            modr : state <= in ? mod1 : mod0;
            mod0 : state <= in ? mod1 : mod0;
            mod1 : state <= in ? mod3 : mod2;
            mod2 : state <= in ? mod2 : mod1;
            mod3 : state <= in ? mod1 : mod0;
         endcase
      end 
   end 
   
   assign out = state == mod3  ? 1 : 0;
      
endmodule