import numpy as np

# Parámetros
num_samples = 20000  # 20,000 muestras
amplitude = (2**7) - 1  # Amplitud de 8 bits (0-127)
offset = 2**7  # Offset de 8 bits (128)

# Generar valores de onda senoidal
sine_wave = (np.sin(2 * np.pi * np.arange(num_samples) / num_samples) * amplitude + offset).astype(int)

# Generar el archivo Verilog
with open("sine_wave_lut_8bit.v", "w") as f:
    f.write("module SineWaveLUT (\n")
    f.write("    input wire [14:0] address,\n")
    f.write("    output reg [7:0] data\n")
    f.write(");\n")
    f.write("    always @(*) begin\n")
    f.write("        case (address)\n")
    for i, val in enumerate(sine_wave):
        f.write(f"            15'b{i:015b} : data = 8'b{val:08b};\n")
    f.write("            default : data = 8'b00000000;\n")
    f.write("        endcase\n")
    f.write("    end\n")
    f.write("endmodule\n")

print("Archivo Verilog generado: sine_wave_lut_8bit.v")
