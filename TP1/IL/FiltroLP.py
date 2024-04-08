# df = pd.read_csv('D:/il_d36_68ohm.csv')

import pandas as pd
import numpy as np
from scipy.signal import butter, filtfilt
from scipy.fft import fft, ifft

# Cargar los datos CSV en un DataFrame de Pandas
df = pd.read_csv('D:/il_d36_68ohm.csv', header=None, names=['x-axis', 'F1'])

# Extraer las columnas de tiempo y tensión
tiempo = df['x-axis'].values
tension = df['F1'].values
tiempo[0] = tiempo[1]
tension[0] = tension[1]

tiempo = tiempo.astype(np.float64)
tension = tension.astype(np.float64)

# Definir la frecuencia de muestreo
frecuencia_muestreo = 1 / (10e-6)  # Frecuencia de muestreo de 100 kHz para un período de 10 microsegundos

# Realizar la transformada de Fourier
transformada = fft(tension)

# Frecuencia de corte para el filtro de paso bajo
frecuencia_corte = 800  # Frecuencia de corte de 5 kHz

# Crear filtro de paso bajo
filtro = np.ones_like(transformada)
frecuencias = np.fft.fftfreq(len(tension), 1 / frecuencia_muestreo)
filtro[np.abs(frecuencias) > frecuencia_corte] = 0

# Aplicar el filtro
señal_filtrada = np.real(ifft(transformada * filtro))

# Guardar los datos filtrados en un nuevo archivo CSV
df_filtrado = pd.DataFrame({'Tiempo': tiempo, 'Volt': señal_filtrada})
df_filtrado.to_csv('C:/Users/Nico Bustelo/Desktop/datos_filtrados.csv', index=False)