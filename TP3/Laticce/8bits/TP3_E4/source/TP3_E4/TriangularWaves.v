

module TriangularWave (
    input wire clk, // Reloj de entrada a 12 MHz
    output reg [11:0] triangular_wave // Salida de 12 bits
);

    reg [11:0] count = 12'b100000000000; // Contador para la onda triangular
    reg direction = 1; // Direcci�n del contador (1 para incrementar, 0 para decrementar)
    
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
        // Cambiar la direcci�n en los l�mites del contador de la onda
        if (count == 12'b011111111110) begin
            direction <= 0; // Cambiar a decrecimiento
        end else if (count == 12'b100000000000) begin
            direction <= 1; // Cambiar a incremento
        end

        // Incrementar o decrementar el contador de la onda de a 2
        if (direction) begin
            count <= count + 2;
        end else begin
            count <= count - 2;
        end
    end

    always @(*) begin
        triangular_wave = count;
    end

endmodule
