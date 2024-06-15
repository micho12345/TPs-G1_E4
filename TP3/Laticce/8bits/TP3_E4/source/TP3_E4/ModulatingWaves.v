


module SineWaveGenerator (
    input wire clk,
    output reg [11:0] Out1,
    output reg [11:0] Out2,
    output reg [11:0] Out3
);

    reg [12:0] sine_wave_lut1 [0:9999]; // Memoria para la LUT
    initial $readmemb("sine_wave.mem", sine_wave_lut1); // Leer datos desde el archivo .mem
	reg [12:0] sine_wave_lut2 [0:9999]; // Memoria para la LUT
    initial $readmemb("sine_wave.mem", sine_wave_lut2); // Leer datos desde el archivo .mem
	reg [12:0] sine_wave_lut3 [0:9999]; // Memoria para la LUT
    initial $readmemb("sine_wave.mem", sine_wave_lut3); // Leer datos desde el archivo .mem
	
	reg [3:0] state = 0; // Estado para controlar el comportamiento de los índices

    reg [11:0] address1 = 0;
    reg [11:0] address2 = 6666;  	// 120 grados desfasado (1/3 de 20000 muestras)
    reg [11:0] address3 = 3333; 	// -120 grados desfasado (2/3 de 20000 muestras)
	
	reg direction1 = 0;
	reg direction2 = 0;
	reg direction3 = 1;
	
	reg [3:0] clk_divider = 0; 	// Divisor de reloj para reducir la frecuencia a 1 MHz
    reg slow_clk = 0; 			// Reloj dividido a 1 MHz				
								// Frecuencia de la senoide = 50Hz -> 0.02seg
								// 0.02seg / 20.000 muestras -> 1useg -> 1MHz
    
	// Divisor de frecuencia
    always @(posedge clk) begin
        if (clk_divider == 11) begin // 12 MHz / 12 ˜ 1 MHz
            clk_divider <= 0;
            slow_clk <= ~slow_clk;
        end else begin
            clk_divider <= clk_divider + 1;
        end
    end


//revisar cuestiones de direcciones
    always @(posedge slow_clk) begin
		if (address1 == 9999)
			direction1 <= 1;
		else if (address1 == 0)
			direction1 <= 0;
		
		if (address2 == 9999)
			direction2 <= 1;
		else if (address2 == 0)
			direction2 <= 0;

		if (address3 == 9999)
			direction3 <= 1;
		else if (address3 == 0)
			direction3 <= 0;
		

		address1 <= (direction1 == 0) ? address1 + 1 : address1 - 1;
		address2 <= (direction2 == 0) ? address2 + 1 : address2 - 1;
		address3 <= (direction3 == 0) ? address3 + 1 : address3 - 1;
		
		// Leer los valores de la LUT para cada direccion
		Out1 <= (direction1 == 0) ? sine_wave_lut1[address1] : -(sine_wave_lut1[address1]);
		Out2 <= (direction2 == 0) ? sine_wave_lut2[address2] : -(sine_wave_lut2[address2]);
		Out3 <= (direction3 == 0) ? sine_wave_lut3[address3] : -(sine_wave_lut3[address3]);
    end
	
endmodule

