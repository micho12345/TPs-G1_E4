module Main (
    input wire clk,        // Clock input
    input wire reset,      // Reset signal
    output wire Va,        // Output signal for phase A
    output wire Vb,        // Output signal for phase B
    output wire Vc         // Output signal for phase C
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
        .In1(sine_wave1),
        .In2(tri_wave),
        .Out1(Va)
    );

    Comparator comp2 (
        .In1(sine_wave2),
        .In2(tri_wave),
        .Out1(Vb)
    );

    Comparator comp3 (
        .In1(sine_wave3),
        .In2(tri_wave),
        .Out1(Vc)
    );

endmodule
