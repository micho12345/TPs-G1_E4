



module top(
	input      		gpio_20,	// clk 12MHz input (jumper OSC shorted)
	output  		gpio_28,	// GND for isolating
	output     		gpio_36,	// GND for isolating
	output  reg   	Va_p, 		// n
	output  reg   	Va_gnd, 	// p
	output  reg   	Vb_p, 		// n
	output  reg   	Vb_gnd, 	// p
	output  reg   	Vc_p, 		// n
	output  reg   	Vc_gnd, 	// p
	output wire		Va,
	output wire		Vb,
	output wire		Vc,
	output wire		Van,
	output wire		Vbn,
	output wire		Vcn
);

wire clk;
wire rst_n;
assign gpio_28 = 1'b0;
assign gpio_36 = 1'b0;
	
assign clk = gpio_20;
rst_gen rst_gen_inst(.clk(clk), .rst_n(rst_n));

wire signed [11:0] tri_wave;
wire signed [11:0] sine_wave1;
wire signed [11:0] sine_wave2;
wire signed [11:0] sine_wave3;

wire en_sin;
wire en_tri;

en_gen #(.LIMIT(11), .N(4)) en_gen_sin (
	.clk(clk),
	.rst_n(rst_n),
	.en(en_sin)
	);
	
en_gen #(.LIMIT(1), .N(1)) en_gen_tri (
	.clk(clk),
	.rst_n(rst_n),
	.en(en_tri)
	);
	
	
SineWaveGenerator sine_gen (
    .clk(clk),
	.rst_n(rst_n),
	.en(en_sin),
    .Out1(sine_wave1),
	.Out2(sine_wave2),
	.Out3(sine_wave3)
	);
	
TriangularWave triangular_gen (
    .clk(clk),
	.en(en_tri),
	.rst_n(rst_n),
    .count(tri_wave)
	);
	
	
// Instantiate the comparators
    Comparator comp1 (
        .sen(sine_wave1),
        .triang(tri_wave),
        .Signal(Va),
		.Signal_n(Van)
    );

    Comparator comp2 (
        .sen(sine_wave2),
        .triang(tri_wave),
        .Signal(Vb),
		.Signal_n(Vbn)
    );
//
    Comparator comp3 (
        .sen(sine_wave3),
        .triang(tri_wave),
        .Signal(Vc),
		.Signal_n(Vcn)
    );


wire w;
pwm #(.WIDTH(12)) pwm_inst1 (.clk(clk), .pwm_i({!sine_wave1[11], sine_wave1[10:0]}), .pwm_o(w));
wire y;
pwm #(.WIDTH(12)) pwm_inst2 (.clk(clk), .pwm_i({!sine_wave2[11], sine_wave2[10:0]}), .pwm_o(y));
wire z;
pwm #(.WIDTH(12)) pwm_inst3 (.clk(clk), .pwm_i({!sine_wave3[11], sine_wave3[10:0]}), .pwm_o(z));

always @(posedge clk)
begin
	if (en_sin) begin
		Va_gnd <= 0;
		Va_p <= w;
		Vb_gnd <= 0;
		Vb_p <= y;
		Vc_gnd <= 0;
		Vc_p <= z;
	end
end

endmodule