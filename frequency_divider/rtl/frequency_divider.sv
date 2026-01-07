`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/07/2026 11:08:54 PM
// Design Name: 
// Module Name: frequency_divider
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module frequency_divider (
   input  logic i_clk,
   input  logic i_rst,
   output logic o_freq_by_even,
   output logic o_freq_by_odd
    );
    
   localparam int        N  = 7;
   localparam int        N1 = (N-1)/2;
   localparam int        M  = 12;
   logic [$clog2(M)+2:0] count;
   logic [$clog2(N)+2:0] count1;
   logic                 n1;
   logic                 n2;
   
   
   //for frequency divided by 2,4,6,8,10
   // This logic is for frequency divided by M
   //Here M is parameteric and should be even starts from 2.
   always_ff @(posedge i_clk) begin
      if(i_rst) begin
         count       <= 0;
         o_freq_by_even <= 0;
      end else begin
         count <= count + 1;
         if(count == M/2-1) begin  //count always runs for M/2 times
            count <= 0;
         end  
         
         if(count == 0) begin
            o_freq_by_even <= ~o_freq_by_even;
         end 
      end 
   end 
   
   
   //for frequency divided by 3,5,7.... follow this logic 
   //this logic is for frequency divided by N
   //Here N is odd and N starts from 3
   always_ff @(posedge i_clk) begin
      if(i_rst) begin
         n1     <= 0;
         count1 <= 0;
      end else begin
         if(count1 < N1) begin
            n1    <= 1;
         end else begin
            n1 = 0;
         end         
         
         count1 <= count1 + 1;
         if(count1 == N-1) begin
            count1 <= 0;
         end 
      end 
   end 
   
   always_ff @(negedge i_clk) begin
      if(i_rst) begin
         n2    <= 0;
      end else begin
        if(count1 == N1) begin
            n2    <= 1;
         end else begin
            n2 = 0;
         end 
      end 
   end 
   
   assign o_freq_by_odd = n1|n2;
   
endmodule
