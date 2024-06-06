


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


    always @(posedge clk) begin
        // Leer los valores de la LUT para cada dirección
        Out1 <= SineWaveLUT[address1];
        Out2 <= SineWaveLUT[address2];
        Out3 <= SineWaveLUT[address3];

        // Incrementar las direcciones
        address1 <= (address1 == 19999) ? 0 : address1 + 1;
        address2 <= (address2 == 19999) ? 0 : address2 + 1;
        address3 <= (address3 == 19999) ? 0 : address3 + 1;
    end
endmodule

