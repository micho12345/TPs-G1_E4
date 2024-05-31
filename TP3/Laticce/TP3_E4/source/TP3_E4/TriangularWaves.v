



module triangular_wave (
    input wire clk,        // Clock input
    input wire reset,      // Reset signal
    output reg [15:0] count // 16-bit counter
);

    parameter MAX_COUNT = 16'd83; // Max count value (83 for 300 kHz triangular wave with 50 MHz clock)

    reg direction; // 0 for up, 1 for down

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            count <= 16'd0;    // Reset counter to 0
            direction <= 1'b0; // Start counting up
        end else begin
            if (direction == 1'b0) begin
                if (count < MAX_COUNT) begin
                    count <= count + 1;
                end else begin
                    direction <= 1'b1; // Change direction to down
                end
            end else begin
                if (count > 0) begin
                    count <= count - 1;
                end else begin
                    direction <= 1'b0; // Change direction to up
                end
            end
        end
    end
endmodule
