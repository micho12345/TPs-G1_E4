

module Comparator
          (
           sen, 
           triang, 
           Signal, 
		   Signal_n
          );


  input   signed [7:0] sen;  
  input   signed [7:0] triang;  
  output  Signal;
  output  Signal_n;


  wire comp;


  assign comp = (sen > triang ? 1'b1 : 1'b0);



  assign Signal = comp;
  assign Signal_n = !comp;


endmodule  // Comparator