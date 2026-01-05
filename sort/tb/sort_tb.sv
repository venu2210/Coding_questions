module sort_tb();
   localparam         N = 8;
   logic              i_clk;
   logic              i_rst;
   logic [N-1:0][7:0] data;
   logic              data_valid;
   logic              data_valid_d;
   
   initial begin
      i_clk = 0;
      i_rst = 1;
      data_valid = 0;
      @(posedge i_clk);
      @(posedge i_clk);
      i_rst = 0;
      @(posedge i_clk );
      @(posedge i_clk );
      @(posedge i_clk );
      data_valid = 1;
      @(posedge i_clk);
      data_valid = 0;
   end 
   
   always #2 i_clk = ~i_clk;

   //data input
   always_ff @(posedge i_clk) begin
      data_valid_d <= data_valid;
      for(int i =0 ; i < N; i++ ) begin
         if(data_valid) begin
            data[i] <= $urandom;
         end
      end 
   end
   
   sort #(
      .N(N)
   ) sort_inst (
      .i_clk      (i_clk       ),
      .i_data     (data        ),
      .i_valid    (data_valid_d),
      .o_sort_data(            ),
      .o_valid    (            )
   );

endmodule