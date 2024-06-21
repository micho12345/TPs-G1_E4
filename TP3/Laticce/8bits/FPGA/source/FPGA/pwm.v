


module pwm #(parameter WIDTH = 12) (
	input clk,
	input [WIDTH-1:0] pwm_i,
	output pwm_o
);
reg [WIDTH:0] pwm_acc;

always @(posedge clk) 
	pwm_acc <= pwm_acc[WIDTH-1:0] + pwm_i;

assign pwm_o = pwm_acc[WIDTH];

endmodule