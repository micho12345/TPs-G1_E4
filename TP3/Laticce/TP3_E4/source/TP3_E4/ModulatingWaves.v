
module SineWaveGenerator (
    input wire clk,
    output reg [15:0] Out1,
    output reg [15:0] Out2,
    output reg [15:0] Out3
);

    // Instancia de la LUT
    wire [15:0] data1, data2, data3;
    reg [14:0] address1 = 0;
    reg [14:0] address2 = 6666;  // 120 grados desfasado (1/3 de 20000 muestras)
    reg [14:0] address3 = 13333; // -120 grados desfasado (2/3 de 20000 muestras)

    SineWaveLUT lut1(.address(address1), .data(data1));
    SineWaveLUT lut2(.address(address2), .data(data2));
    SineWaveLUT lut3(.address(address3), .data(data3));

    always @(posedge clk) begin
        // Actualizar las salidas con los valores de la LUT
        Out1 <= data1;
        Out2 <= data2;
        Out3 <= data3;

        // Incrementar los contadores y volver al inicio si alcanzan el final de la LUT
        address1 <= (address1 == 19999) ? 0 : address1 + 1;
        address2 <= (address2 == 19999) ? 0 : address2 + 1;
        address3 <= (address3 == 19999) ? 0 : address3 + 1;
    end
endmodule
