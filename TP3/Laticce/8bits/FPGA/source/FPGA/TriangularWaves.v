

module TriangularWave (
    input wire clk, // Reloj de entrada a 12 MHz
	input en,
	input rst_n,
    output reg [11:0] count // Salida de 12 bits	
);


    reg direction; // Direcci?n del contador (1 para incrementar, 0 para decrementar)
    
    // Divisor de frecuencia
	// Contador para dividir la frecuencia del reloj
    // Reloj dividido a 6.76 MHz


    // Contador triangular
    always @(posedge clk) begin
		
		if (~rst_n) begin
			count <= 12'b000000000000;
		end
		
		if (en) begin
			// Cambiar la direcci?n en los l?mites del contador de la onda
			if (count == 12'b011111111100) begin				// Mayor a 7FB
				direction <= 0; // Cambiar a decrecimiento
			end else if (count == 12'b100000000010) begin	// mayor a 802
				direction <= 1; // Cambiar a incremento
			end

			// Incrementar o decrementar el contador de la onda de a 2
			if (direction) begin
				count <= count + 2;
			end else begin
				count <= count - 2;
			end
		end
    end


endmodule