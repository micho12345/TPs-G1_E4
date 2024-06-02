

module triangular_wave (
    input wire clk,        // Clock input
    input wire reset,      // Reset signal
    output reg [7:0] count // 8-bit counter
);

    parameter MAX_COUNT = 16'd15151; // Max count value for 1650 Hz triangular wave with 50 MHz clock
    parameter AMPLITUDE = 8'd255;    // Amplitud de 255 (2^8 - 1)
    parameter ma = 8'd13;            // Multiplicador ma (1.3 en escala de 0 a 13)

    reg direction; // 0 for up, 1 for down
    reg [15:0] internal_count; // Internal counter for fine granularity

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            internal_count <= 16'd0; // Reset internal counter to 0
            direction <= 1'b0; // Start counting up
        end else begin
            if (direction == 1'b0) begin
                if (internal_count < (AMPLITUDE * MAX_COUNT)) begin
                    internal_count <= internal_count + 1;
                end else begin
                    direction <= 1'b1; // Change direction to down
                end
            end else begin
                if (internal_count > 0) begin
                    internal_count <= internal_count - 1;
                end else begin
                    direction <= 1'b0; // Change direction to up
                end
            end
        end
    end

    always @(*) begin
        count = ((internal_count / MAX_COUNT) * ma) / 10; // Scale the output
    end
endmodule
