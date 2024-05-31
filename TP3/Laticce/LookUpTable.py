import numpy as np

# Parámetros
num_samples = 20000
amplitude = (2**15) - 1  # Amplitud de 16 bits (0-32767)
offset = 2**15  # Offset de 16 bits (32768)

# Generar valores de onda senoidal
sine_wave = (np.sin(2 * np.pi * np.arange(num_samples) / num_samples) * amplitude + offset).astype(int)

# Generar el archivo Verilog
with open("sine_wave_lut_16bit.v", "w") as f:
    f.write("module SineWaveLUT (\n")
    f.write("    input wire [14:0] address,\n")
    f.write("    output reg [15:0] data\n")
    f.write(");\n")
    f.write("    always @(*) begin\n")
    f.write("        case (address)\n")
    for i, val in enumerate(sine_wave):
        f.write(f"            15'b{i:015b} : data = 16'b{val:016b};\n")
    f.write("            default : data = 16'b0000000000000000;\n")
    f.write("        endcase\n")
    f.write("    end\n")
    f.write("endmodule\n")

print("Archivo Verilog generado: sine_wave_lut_16bit.v")
