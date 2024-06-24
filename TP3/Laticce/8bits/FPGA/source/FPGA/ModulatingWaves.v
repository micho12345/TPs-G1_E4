




module SineWaveGenerator(
    input wire clk,
	input en,
	input rst_n,
    output reg [11:0] Out1,
	output reg [11:0] Out2,
	output reg [11:0] Out3
);

    reg [11:0] sine_wave_lut [0:9999]; // Memoria para la LUT
	
	initial $readmemb("tbl.mem", sine_wave_lut); // Leer datos desde el archivo .mem
	
    reg [13:0] address1;
	reg [13:0] address2;
	reg [13:0] address3;
	reg [13:0] address;
	
	reg direction1 = 0;
	reg direction2 = 0;
	reg direction3 = 1;
	
	reg [1:0] state = 2'b00;
  
//revisar cuestiones de direcciones
always @(posedge clk) begin
	if (~rst_n) begin
		address <= 0;
		address1 <= 0;
		address2 <= 6666;
		address3 <= 6666;
		direction1 <= 0;
		direction2 <= 0;
		direction3 <= 1;
		end
	
	case (state) 
		2'b00: begin
			if (en) begin // 1 MHz
				if (address1 == 9998)
					direction1 <= 1;
				else if (address1 == 1)
					direction1 <= 0;
				if (address2 == 9998)
					direction2 <= 1;
				else if (address2 == 1)
					direction2 <= 0;
				if (address3 == 9998)
					direction3 <= 1;
				else if (address3 == 1)
					direction3 <= 0;
				address1 <= (direction1 == 0) ? address1 + 1 : address1 - 1;
				address2 <= (direction2 == 0) ? address2 + 1 : address2 - 1;
				address3 <= (direction3 == 0) ? address3 + 1 : address3 - 1;
				state <= 2'b01;
				address <= address1;
			end
		end
		2'b01: begin
			Out1 <= (direction1 == 0) ? sine_wave_lut[address] : -(sine_wave_lut[address]);
			state <= 2'b10;
			address <= address2;
			end
		2'b10: begin
			Out2 <= (direction2 == 0) ? sine_wave_lut[address] : -(sine_wave_lut[address]);
			state <= 2'b11;
			address <= address3;
			end
		default: begin
			Out3 <= (direction3 == 0) ? sine_wave_lut[address] : -(sine_wave_lut[address]);
			state <= 2'b00;
			address <= address1;
			end
	endcase
		
end

endmodule