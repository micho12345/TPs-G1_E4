
`timescale 1 ns / 1 ns


module SineWaveLUT(
	input clk,
    input wire [14:0] address1,
	input wire [14:0] address2,
	input wire [14:0] address3,	
    output reg [15:0] data1,
	output reg [15:0] data2,
	output reg [15:0] data3
);
//
reg [14:0] data_tbl [0:((1<<15)-1)]; 

initial begin
	$readmemb("sine_wave_lut.mem", data_tbl);
end
//
always @(posedge clk) begin
	data1 <= data_tbl[address1];
	data2 <= data_tbl[address2];
	data3 <= data_tbl[address3];
end
endmodule








