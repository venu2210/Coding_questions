module mux2x1_without_if_case ();
  logic [1:0] a = 2;
  logic [1:0] b = 3;
  logic       s = 1;
  logic [1:0] c;
  
  //mux 
  // s == 0, a is selected 
  // s == 1, b is selected
  assign c = (s&b) | (~s)&a;
  always_comb begin $display("%d",c); end 
  
  //4x1
  logic [3:0][1:0] av = {2'h1,2'h2,2'h3,2'h4};
  logic [1:0]      sv = 3;
  logic [1:0] c1;
  logic [1:0] c2;
  logic [1:0] c_final;
  
  //mux 
  // s == 0, a is selected 
  // s == 1, b is selected
  assign c1 = (sv[0]&av[1]) | (~sv[0])&av[0];
  assign c2 = (sv[0]&av[3]) | (~sv[0])&av[2];
  assign c_final = (sv[1]&c2) | (~sv[1])&c1;
  always_comb begin $display("%d",c_final); end 
  

endmodule