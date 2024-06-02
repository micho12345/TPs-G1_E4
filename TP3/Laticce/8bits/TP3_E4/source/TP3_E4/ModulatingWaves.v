

module SineWaveGenerator (
    input wire clk,
    output reg [7:0] Out1,
    output reg [7:0] Out2,
    output reg [7:0] Out3
);

    // Instancia de la LUT
    wire [7:0] data;
    reg [14:0] address;

    SineWaveLUT lut(.address(address), .data(data));

    reg [14:0] address1 = 0;
    reg [14:0] address2 = 6666;  // 120 grados desfasado (1/3 de 20000 muestras)
    reg [14:0] address3 = 13333; // -120 grados desfasado (2/3 de 20000 muestras)

    reg [1:0] state = 0;

    always @(posedge clk) begin
        case (state)
            2'b00: begin
                address <= address1;
                Out1 <= data;
                address1 <= (address1 == 19999) ? 0 : address1 + 1;
            end
            2'b01: begin
                address <= address2;
                Out2 <= data;
                address2 <= (address2 == 19999) ? 0 : address2 + 1;
            end
            2'b10: begin
                address <= address3;
                Out3 <= data;
                address3 <= (address3 == 19999) ? 0 : address3 + 1;
            end
        endcase
        state <= state + 1;
    end
endmodule
