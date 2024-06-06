





module triangular_wave (
    input wire clk,        // Clock input
    output reg [15:0] count // 16-bit counter
);

    parameter MAX_COUNT = 16'd15151; // Max count value for 1650 Hz triangular wave with 50 MHz clock
    parameter AMPLITUDE = 16'd65535; // Amplitude of 65535 (2^16 - 1)
    parameter ma = 16'd13;           // Multiplier ma (1.3 in scale of 0 to 13)

    reg direction; // 0 for up, 1 for down
    reg [31:0] internal_count; // Internal counter for fine granularity

    always @(posedge clk) begin
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
		count <= ((internal_count / MAX_COUNT) * ma) / 10; // Scale the output
    end

    //always @(*) begin
        //count = ((internal_count / MAX_COUNT) * ma) / 10; // Scale the output
    //end
endmodule

