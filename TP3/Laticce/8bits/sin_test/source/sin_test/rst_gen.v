module rst_gen(
   output rst_n,
   input clk);
   
localparam N=4;

reg [N-1:0] rst_cnt = {N{1'b0}};

always @(posedge clk) begin
	if (rst_cnt < {N{1'b1}})
		rst_cnt <= rst_cnt + 1'd1;
end
	
assign rst_n = (rst_cnt == {N{1'b1}});

endmodule
