




module triangular_wave (
    input wire clk,        // Clock input
    output reg [15:0] count // 16-bit counter
);

    parameter MAX_COUNT = 16'd15151; // Max count value for 1650 Hz triangular wave with 50 MHz clock
    parameter AMPLITUDE = 16'd32767; // Amplitude of 32767 (2^15 - 1)
    parameter ma = 8'd13; // Multiplicador ma (1.3 en escala de 0 a 13)

    reg direction; // 0 for up, 1 for down
    reg [15:0] internal_count; // Internal counter

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            internal_count <= 16'd0; // Reset internal counter to 0
            direction <= 1'b0; // Start counting up
        end else begin
            if (direction == 1'b0) begin
                if (internal_count < AMPLITUDE) begin
                    internal_count <= internal_count + (AMPLITUDE / MAX_COUNT);
                end else begin
                    direction <= 1'b1; // Change direction to down
                end
            end else begin
                if (internal_count > 0) begin
                    internal_count <= internal_count - (AMPLITUDE / MAX_COUNT);
                end else begin
                    direction <= 1'b0; // Change direction to up
                end
            end
        end
    end

    always @(*) begin
        count = (internal_count * ma) / 10; // Multiply by ma and scale down
    end
endmodule


