



module main (  
	input wire clk,	 
    output reg [11:0] tri_wave
);

   
	
	TriangularWave tw_gen (
		.clk(clk),		
        .triangular_wave(tri_wave)
    );




endmodule