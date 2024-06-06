import numpy as np

# Parámetros
num_samples = 20000
amplitude = 2**7 - 1  # 8-bit amplitude (máximo valor positivo para 8 bits)
offset = 128  # Offset para centrar la onda sinusoidal en 8 bits sin signo

# Generar las muestras de la onda sinusoidal
t = np.linspace(0, 2 * np.pi, num_samples, endpoint=False)
sine_wave = amplitude * np.sin(t) + offset

# Convertir las muestras a enteros de 8 bits
sine_wave_int = sine_wave.astype(np.uint8)

# Guardar las muestras en un archivo .mem
with open("sine_wave_8bit.mem", "w") as f:
    for sample in sine_wave_int:
        # Escribir cada muestra en formato hexadecimal de 2 dígitos
        f.write(f"{sample:02X}\n")
