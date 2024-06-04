
`timescale 1 ns / 1 ns


module SineWaveLUT(
	input clk,
    input wire [14:0] address,
    output reg [15:0] data
);

reg [14:0] data_tbl [0:((1<<15)-1)]; 

initial begin
	$readmemb("tbl.mem", data_tbl);
end

always @(posedge clk) data <= data_tbl[address];

endmodule








