/*
 DESCRIPTION :-
    THE SORTING IS IMPLEMENTED BASED ON BUBBLE SORTING
*/
module sort #(
   parameter N = 4,
   parameter P = 1   //0 - ascending order 1 - descending order
   ) (
   input  logic               i_clk,
   input  logic [N-1:0][7:0]  i_data,
   input  logic               i_valid,
   output logic [N-1:0][7:0]  o_sort_data,
   output logic               o_valid
   );
   
   int i,j;
   logic [N-1:0][7:0]         a;
   logic [N-2:0][N-1:0][7:0]  stage_data;  //show stage wise comparision results
   logic [7:0]                temp;
   
   //Bubble sort algorithm
   //example x1,x2,x3,x4
   //stage 1 comparision of indexes((0,1),(1,2),(2,3)
   //stage 2 comparision of indexes((1,2),(2,3)
   //stage 3 comparision of indexes((2,3)
   always_comb begin
      a = i_data;
      for(i = 0; i < N-1; i++) begin
         for(j = 0; j < N-1-i; j++) begin
            if((a[j] > a[j+1] && P == 0) || (a[j] < a[j+1] && P == 1)) begin
               temp   = a[j];
               a[j]   = a[j+1];
               a[j+1] = temp;
            end
         end
         stage_data[i] = a;
      end
   end
   
   always_ff @(posedge i_clk) begin
      o_sort_data <= a;
      o_valid     <= i_valid;
   end
   
endmodule

