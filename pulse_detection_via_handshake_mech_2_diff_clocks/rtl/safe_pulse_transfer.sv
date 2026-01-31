// -----------------------------------------------------------------------------
// Author      : Chintapalli Venu
// GitHub      : https://github.com/venu2210
// Created On  : 31-01-2026
//
// Description :
//   A pulse is safely synchronized from one clock domain to a second clock domain. 
//   Handshake mechanism is used for safe transfer of pulse from higher-speed clock to lower-speed clock
//   REQUEST-ACKNOWLEDGE mechanism
//
// License :
//   This source code is the intellectual property of the author.
//   Unauthorized copying, modification, or distribution is prohibited
//   without explicit permission.
//
// Usage :
//   Allowed for personal learning, evaluation, and interview discussion.
//   Commercial use requires written authorization from the author.
//
// -----------------------------------------------------------------------------
// © 2026 Chintapalli Venu. All rights reserved.
// -----------------------------------------------------------------------------

module safe_pulse_transfer (
   input  logic    src_clock,
   input  logic    src_reset,
   input  logic    dst_clock,
   input  logic    dst_reset,
   input  logic    pulse_in,
   output logic    pulse_out
   );
   
   logic request;
   logic request_d;
   logic request_sync;
   logic request_sync_d;
   logic ack;
   logic ack_d;
   logic ack_sync;
   
   
   //Generating request on source clock
   always_ff @(posedge src_clock) begin
      if(src_reset) begin
         request <= 1'b0;
      end else begin
         if(pulse_in) begin
            request <= 1'b1;
         end else if(ack_sync) begin
            request <= 1'b0;
         end 
      end 
   end
   
   //Syncronizing the request on destination clock
   always_ff @(posedge dst_clock) begin
      request_d  <= request;
      request_sync <= request_d;
   end
   
   //Edge detection of syncronized request on destination clock
   always_ff @(posedge dst_clock) begin
      if(dst_reset) begin
         request <= 1'b0;
      end else begin
         request_sync_d <= request_sync;
         pulse_out    <= (~request_sync_d) & request_sync;
      end 
   end
   
   //Generating acknowledgement on destination clock
   always_ff @(posedge dst_clock) begin
      if(dst_reset) begin
         ack <= 1'b0;
      end else begin
         if(request_sync) begin
            ack <= 1'b1;
         end else begin
            ack <= 1'b0;
         end 
      end 
   end
   
   //Syncronizing the acknowledge on source clock
   always_ff @(posedge src_clock) begin
      ack_d    <= ack;
      ack_sync <= ack_d;
   end
   
endmodule