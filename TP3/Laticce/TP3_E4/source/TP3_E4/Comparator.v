

module Comparator
          (
           In1, 
           In2, 
           Out1, 
		   Out2
          );


  input   signed [15:0] In1;  
  input   signed [15:0] In2;  
  output  Out1;
  output  Out2;


  wire comp;


  assign comp = (In1 > In2 ? 1'b1 : 1'b0);



  assign Out1 = comp;
  assign Out2 = !comp;


endmodule  // Comparator