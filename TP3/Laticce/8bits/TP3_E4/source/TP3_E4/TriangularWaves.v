



module TriangularWave (
    input wire clk, // Reloj de entrada a 12 MHz
    output reg [11:0] count // Salida de 12 bits	
);

    reg direction = 1; // Direcci?n del contador (1 para incrementar, 0 para decrementar)
    
    // Divisor de frecuencia
    reg clk_divider = 0; // Contador para dividir la frecuencia del reloj
    reg slow_clk = 0; // Reloj dividido a 6.76 MHz

    // Divisor de frecuencia
    always @(posedge clk) begin
        if (clk_divider == 0) begin
            clk_divider <= 1;
            slow_clk <= ~slow_clk; // Cambiar el estado de slow_clk cada ciclo
        end else begin
            clk_divider <= 0;
        end
    end

    // Contador triangular
    always @(posedge slow_clk) begin
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

endmodule
