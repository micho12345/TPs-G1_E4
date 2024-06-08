


module SineWaveGenerator (
    input wire clk,
    output reg [11:0] Out1,
    output reg [11:0] Out2,
    output reg [11:0] Out3
);

    reg [12:0] sine_wave_lut [0:9999]; // Memoria para la LUT
    initial $readmemh("sine_wave.mem", sine_wave_lut); // Leer datos desde el archivo .mem
	
	reg [3:0] state = 0; // Estado para controlar el comportamiento de los índices

    reg [11:0] address1 = 0;
    reg [11:0] address2 = 6666;  	// 120 grados desfasado (1/3 de 20000 muestras)
    reg [11:0] address3 = 3333; 	// -120 grados desfasado (2/3 de 20000 muestras)
	
	
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



    always @(posedge slow_clk) begin
		case(state) 
			4'b0000: begin
				// Incrementar las direcciones
				address1 <= address1 + 1;
				address2 <= address2 + 1;
				address3 <= address3 - 1;
				
				// Leer los valores de la LUT para cada direccion
				Out1 <= sine_wave_lut[address1];
				Out2 <= sine_wave_lut[address2];
				Out3 <= (sine_wave_lut[address3] | 12'b100000000000);
				
				if(address3 == 0) begin			//address1 = 6666
					state = state + 1;			//address2 = 9999
				end								//address3 = 0
			end
			4'b0001: begin
				// Incrementar las direcciones
				address1 <= address1 + 1;
				address2 <= address2 + 1;
				address3 <= address3 + 1;
				
				// Leer los valores de la LUT para cada direccion
				Out1 <= sine_wave_lut[address1];
				Out2 <= sine_wave_lut[address2];
				Out3 <= sine_wave_lut[address3];
				
				if(address2 == 10000) begin		//address1 = 6667
					state = state + 1;			//address2 = 10000
				end								//address3 = 1
			end
			4'b0010: begin
				// Incrementar las direcciones
				address1 <= address1 + 1;
				address2 <= address2 - 1;
				address3 <= address3 + 1;
				
				// Leer los valores de la LUT para cada direccion
				Out1 <= sine_wave_lut[address1];
				Out2 <= (sine_wave_lut[address2] | 12'b100000000000);
				Out3 <= sine_wave_lut[address3];
				
				if(address1 == 10000) begin		//address1 = 10000
					state = state + 1;			//address2 = 6667
				end								//address3 = 3334
			end
			4'b0011: begin
				// Incrementar las direcciones
				address1 <= address1 - 1;
				address2 <= address2 - 1;
				address3 <= address3 + 1;
				
				// Leer los valores de la LUT para cada direccion
				Out1 <= (sine_wave_lut[address1] | 12'b100000000000);
				Out2 <= (sine_wave_lut[address2] | 12'b100000000000);
				Out3 <= sine_wave_lut[address3];
				
				if(address3 == 10000) begin		//address1 = 3334
					state = state + 1;			//address2 = 1
				end								//address3 = 10000
			end
			4'b0100: begin
				// Incrementar las direcciones
				address1 <= address1 - 1;
				address2 <= address2 - 1;
				address3 <= address3 - 1;
				
				// Leer los valores de la LUT para cada direccion
				Out1 <= (sine_wave_lut[address1] | 12'b100000000000);
				Out2 <= (sine_wave_lut[address2] | 12'b100000000000);
				Out3 <= (sine_wave_lut[address3] | 12'b100000000000);
				
				if(address2 == 0) begin			//address1 = 3333
					state = state + 1;			//address2 = 0
				end								//address3 = 9999
			end
			4'b0101: begin
				// Incrementar las direcciones
				address1 <= address1 - 1;
				address2 <= address2 + 1;
				address3 <= address3 - 1;
				
				// Leer los valores de la LUT para cada direccion
				Out1 <= (sine_wave_lut[address1] | 12'b100000000000);
				Out2 <= sine_wave_lut[address2];
				Out3 <= (sine_wave_lut[address3] | 12'b100000000000);
				
				if(address1 == 0) begin			//address1 = 0
					state = state + 1;			//address2 = 3333
				end								//address3 = 6666
			end
			4'b0110: begin
				// Incrementar las direcciones
				address1 <= address1 + 1;
				address2 <= address2 + 1;
				address3 <= address3 - 1;
				
				// Leer los valores de la LUT para cada direccion
				Out1 <= sine_wave_lut[address1];
				Out2 <= sine_wave_lut[address2];
				Out3 <= (sine_wave_lut[address3] | 12'b100000000000);
				
				if(address3 == 0) begin			//address1 = 3333
					state = state + 1;			//address2 = 9999
				end								//address3 = 0
			end
			4'b0111: begin
				// Incrementar las direcciones
				address1 <= address1 + 1;
				address2 <= address2 + 1;
				address3 <= address3 + 1;
				
				// Leer los valores de la LUT para cada direccion
				Out1 <= sine_wave_lut[address1];
				Out2 <= sine_wave_lut[address2];
				Out3 <= sine_wave_lut[address3];
				
				if(address2 == 10000) begin		//address1 = 3334
					state = state + 1;			//address2 = 10000
				end								//address3 = 1
			end
			4'b1000: begin
				// Incrementar las direcciones
				address1 <= address1 + 1;
				address2 <= address2 - 1;
				address3 <= address3 + 1;
				
				// Leer los valores de la LUT para cada direccion
				Out1 <= sine_wave_lut[address1];
				Out2 <= (sine_wave_lut[address2] | 12'b100000000000);
				Out3 <= sine_wave_lut[address3];
				
				if(address1 == 10000) begin		//address1 = 10000
					state = state + 1;			//address2 = 3333
				end								//address3 = 6667
			end
			4'b1001: begin
				// Incrementar las direcciones
				address1 <= address1 - 1;
				address2 <= address2 - 1;
				address3 <= address3 + 1;
				
				// Leer los valores de la LUT para cada direccion
				Out1 <= (sine_wave_lut[address1] | 12'b100000000000);
				Out2 <= (sine_wave_lut[address2] | 12'b100000000000);
				Out3 <= sine_wave_lut[address3];
				
				if(address3 == 10000 || address2 == 0) begin		//address1 = 6667
					state = state + 1;								//address2 = 0
				end													//address3 = 10000
			end
			4'b1010: begin
				// Incrementar las direcciones
				address1 <= address1 - 1;
				address2 <= address2 + 1;
				address3 <= address3 - 1;
				
				// Leer los valores de la LUT para cada direccion
				Out1 <= (sine_wave_lut[address1] | 12'b100000000000);
				Out2 <= sine_wave_lut[address2];
				Out3 <= (sine_wave_lut[address3] | 12'b100000000000);
				
				if(address1 == 0) begin			//address1 = 0
					state = state + 1;			//address2 = 6667
				end								//address3 = 3333
			end
			4'b1011: begin
				// Incrementar las direcciones
				address1 <= address1 + 1;
				address2 <= address2 + 1;
				address3 <= address3 - 1;
				
				// Leer los valores de la LUT para cada direccion
				Out1 <= sine_wave_lut[address1];
				Out2 <= sine_wave_lut[address2];
				Out3 <= (sine_wave_lut[address3] | 12'b100000000000);
				
				if(address2 == 10000 || address3 == 0) begin			//address1 = 3333
					state = 4'b1000;								//address2 = 10000
				end													//address3 = 0
			end
			default: begin
					Out1 <= 0;
					Out2 <= 0;
					Out3 <= 0;
				end
		endcase
    end
	
endmodule

