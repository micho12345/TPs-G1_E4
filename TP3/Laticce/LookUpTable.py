import numpy as np

# Parámetros
num_samples = 10000  # Número de muestras para medio ciclo
amplitude = 2**11 - 1  # Amplitud máxima para 16 bits signados (32767)

# Generar las muestras de medio ciclo de la onda sinusoidal
t = np.linspace(0, np.pi, num_samples, endpoint=False)
sine_wave = amplitude * np.sin(t)

# Convertir las muestras a enteros de 16 bits signados
sine_wave_int = sine_wave.astype(np.int16)

# Guardar las muestras en un archivo .mem
with open("sine_wave_lut.mem", "w") as f:
    for sample in sine_wave_int:
        # Escribir cada muestra en formato binario de 16 bits
        binary_sample = format(sample, '012b')  # Asegurarse de que cada muestra tenga 15 bits
        f.write(f"{binary_sample}\n")

print("Archivo 'sine_wave_lut.mem' generado correctamente.")
