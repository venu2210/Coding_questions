/*******************************************************************************
FILENAME: data_2_word_conv_3.sv
Copyright (C) 2025 Qbit Labs Pvt. Ltd.
THIS FILE CONTAINS INFORMATION PROPRIETARY TO QBIT LABS PRIVATE LIMITED AND MUST BE RETURNED TO QBIT UPON TERMINATION OF PURPOSE FOR
WHICH IT WAS FURNISHED. DISCLOSURE TO OTHER PARTIES, COPYING OR IMPROPER USE IS EXPRESSLY PROHIBITED.
DESCRIPTION :-
             The discription of this module is as follows

HISTORY:
 22/12/2025 : Created (ch. venu)
*******************************************************************************/

module data_2_word #(
   parameter int N = 399) 
   (
   input  logic            i_clk,
   input  logic            i_rst,
   input  logic [N*32-1:0] i_data,
   input  logic            i_valid,
   output logic [31:0]     o_data,
   output logic            o_valid,
   output logic            o_last,
   output logic [1:0]      o_last_bytes
   );
   
   logic [8:0]         count;
   logic [5:0]         count1;
   logic [5:0]         count1_d;
   logic               valid_flag;
   logic [N:0][31:0]   data_in;
   logic [N+1:0][31:0] data_in1;
   logic [N+1:0][31:0] data_in1_d;
   logic [N+1:0][31:0] data_in1_2d;
   logic               valid_d;
   
   always_ff @(posedge i_clk) begin
      valid_d   <= i_valid;
      count1_d  <= count1;
   end 
   
   always_comb begin
      data_in1[N+1] = 32'b0;
      data_in[N]    = {32'h0};
      data_in1[N]   = {32'h0};
      for(int i = 0; i < N; i++) begin
         data_in[i]  = i_data[i*32 +: 32];
         data_in1[i] = {<<8{data_in[i]}};
      end
   end
   
   always_ff @(posedge i_clk) begin
      if(i_rst) begin
         count1     <= 6'b0;
      end else begin
         if(i_valid) begin
            count1     <= 6'b0;
         end else if(count1 < 60)begin
            count1 <= count1 + 1;
         end else if(count1 == 60) begin
            count1 <= 0;
         end 
      end 
   end
   
   
   always_ff @(posedge i_clk) begin
      if(i_rst) begin
         count      <= 8'b0;
         valid_flag <= 1'b0;
      end else begin
         if(valid_d == 1 && count1 < 34) begin
            count      <= 8'b0;
            valid_flag <= 1'b1;
         end else if(count < N && count1 < 34)begin
            count <= count + 1;
         end else if(count == N && count1 < 34) begin
            count <= count + 1;
            valid_flag <= 1'b0;
         end 
      end 
   end
   
   always_ff @(posedge i_clk) begin
      data_in1_d        <= data_in1;
      data_in1_2d       <= data_in1_d;
      o_data            <= data_in1_2d[count];
      o_valid           <= count1_d < 34 ? valid_flag  : 1'b0;
      o_last            <= count == N  ? valid_flag  : 1'b0;
      o_last_bytes      <= count == N  ? 2'b0        : 2'b11;
   end 
   
   
endmodule

