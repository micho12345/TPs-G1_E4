



module Main (
    input wire clk,        // Clock input
    input wire reset,      // Reset signal
    output wire Va,        // Output signal for phase A
	output wire Van,       // Output signal for phase A negado
    output wire Vb,        // Output signal for phase B
	output wire Vbn,       // Output signal for phase B negado
    output wire Vc,        // Output signal for phase C
	output wire Vcn        // Output signal for phase C negado
);

    // Internal signals
    wire [15:0] tri_wave;
    wire [15:0] sine_wave1, sine_wave2, sine_wave3;
	
	
    
    // Instantiate the triangular wave generator
    triangular_wave tw_gen (
        .clk(clk),
        .reset(reset),
        .count(tri_wave)
    );

    // Instantiate the sine wave generator
    SineWaveGenerator sine_gen (
        .clk(clk),
        .Out1(sine_wave1),
        .Out2(sine_wave2),
        .Out3(sine_wave3)
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

    Comparator comp3 (
        .sen(sine_wave3),
        .triang(tri_wave),
        .Signal(Vc),
		.Signal_n(Vcn)
    );

endmodule
