

module en_gen #(
	parameter LIMIT = 9,
	parameter N = 4
	)(
	input rst_n,
	input clk,
	output reg en
);

reg [N-1:0] cnt;

always @(posedge clk) begin
	if (~rst_n) cnt <= 0;
	else begin
		if (cnt == LIMIT) cnt <= 0;
		else cnt <= cnt + 1;
	end
end

always @(posedge clk) begin
	if (cnt == LIMIT) en <= 1;
	else en <= 0;
end
endmodule