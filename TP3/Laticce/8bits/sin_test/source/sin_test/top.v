

module top(
	output  gpio_28,	// GND for isolating
	output     gpio_36,	// GND for isolating
	output  reg   Va_p, // n
	output  reg   Va_gnd, // p
	output  reg   Vb_p, // n
	output  reg   Vb_gnd, // p
	output  reg   Vc_p, // n
	output  reg   Vc_gnd, // p
	input      gpio_20	// clk 12MHz input (jumper OSC shorted)
);

wire clk;
wire rst_n;
assign gpio_28 = 1'b0;
assign gpio_36 = 1'b0;
	
assign clk = gpio_20;
rst_gen rst_gen_inst(.clk(clk), .rst_n(rst_n));

wire signed [11:0] Va;
wire signed [11:0] Vb;
wire signed [11:0] Vc;

wire en;


en_gen #(.LIMIT(11), .N(4)) en_gen_inst (
	.clk(clk),
	.rst_n(rst_n),
	.en(en)
	);
	
	
SineWaveGenerator sine_gen (
    .clk(clk),
	.rst_n(rst_n),
	.en(en),
    .Out1(Va),
	.Out2(Vb),
	.Out3(Vc)
	);


wire w;
pwm #(.WIDTH(12)) pwm_inst1 (.clk(clk), .pwm_i({!Va[11], Va[10:0]}), .pwm_o(w));
wire y;
pwm #(.WIDTH(12)) pwm_inst2 (.clk(clk), .pwm_i({!Vb[11], Vb[10:0]}), .pwm_o(y));
wire z;
pwm #(.WIDTH(12)) pwm_inst3 (.clk(clk), .pwm_i({!Vc[11], Vc[10:0]}), .pwm_o(z));

always @(posedge clk)
begin
	if (en) begin
		Va_gnd <= 0;
		Va_p <= w;
		Vb_gnd <= 0;
		Vb_p <= y;
		Vc_gnd <= 0;
		Vc_p <= z;
	end
end

endmodule