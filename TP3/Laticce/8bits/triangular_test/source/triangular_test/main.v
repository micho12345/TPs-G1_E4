module main (  
	input wire clk,	 
    output wire [11:0] tri_wave
);

   
	
	TriangularWave tw_gen (
		.clk(clk),		
        .count(tri_wave)
    );




endmodule