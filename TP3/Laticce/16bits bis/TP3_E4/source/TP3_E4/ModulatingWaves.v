

module SineWaveGenerator (
    input wire clk,
    output reg [15:0] Out1,
    output reg [15:0] Out2,
    output reg [15:0] Out3
);

    // Instancia de la LUT
    wire [15:0] data1;
	wire [15:0] data2;
	wire [15:0] data3;
    reg [14:0] address1;
    reg [14:0] address2;
    reg [14:0] address3;

    SineWaveLUT lut(.clk (clk), .address1(address1), .address2(address2), .address3(address3), .data1(data1), .data2(data2), .data3(data3));

    reg [14:0] p1 = 0;
    reg [14:0] p2 = 6666;  // 120 grados desfasado (1/3 de 20000 muestras)
    reg [14:0] p3 = 13333; // -120 grados desfasado (2/3 de 20000 muestras)


    always @(posedge clk) begin
        
		address1 <= p1;
		address2 <= p2;
		address3 <= p3;
		
		Out1 <= data1;
		Out2 <= data2;
		Out3 <= data3;
		
		address1 <= (address1 == 19999) ? 0 : address1 + 1;
		address2 <= (address2 == 19999) ? 0 : address2 + 1;
		address3 <= (address3 == 19999) ? 0 : address3 + 1;
          
    end
endmodule

