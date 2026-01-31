module tb();
   logic                   src_clk;
   logic                   dst_clk;
   logic                   src_rst;
   logic                   dst_rst;
   logic  [4:0]            counter;
   logic                   pulse_in;

   
   initial begin
      src_clk = 0;
      src_rst = 1;
      @(posedge src_clk);
      @(posedge src_clk);
      src_rst = 0;
   end

   always #2 src_clk = ~src_clk;
   
   initial begin
      dst_clk = 0;
      dst_rst = 1;
      @(posedge dst_clk);
      @(posedge dst_clk);
      dst_rst = 0;
   end
   
   always #8 dst_clk = ~dst_clk;
   
   always_ff @(posedge src_clk) begin 
      if(src_rst) begin
         counter <= 5'b0;
         pulse_in <= 1'b0;
      end else begin
         pulse_in <= 1'b0;
         if(counter < 8) begin
            counter <= counter + 1;
         end else if( counter == 8) begin
            counter <= counter + 1;
            pulse_in <= 1'b1;
         end 
      end   
   end 
   
   safe_pulse_transfer dut (
      .src_clock(src_clk),
      .src_reset(src_rst),
      .dst_clock(dst_clk),
      .dst_reset(dst_rst),
      .pulse_in (pulse_in),
      .pulse_out( )
   );

endmodule