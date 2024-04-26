from sympy import symbols, Eq, solve

# Define las incógnitas
x = symbols('x')

# Define las constantes
Vd = 311
Vo= 5 
D = 0.2 #DUTY BRO
Fs = 150e3
Bmax = 200e-3 #En teslas
A = 6e-5 #En metros cuadrados
Io = 3


# AL CON O SIN GAP
Al = 1900e-9
Al_g02 = 290e-9
Al_g034 = 195e-9  
Al_g06 = 140e-9 

Idc = ((Io/(1-D))*(Vo/Vd)*((1-D)/D)) #En amperes
print("Idc: ", Idc)
Ts = 1/Fs 
IntV = Vd * D * Ts 
R = 1/Al_g02

# Define la ecuación
ecuacion = Eq(0.5 * (IntV/(x*A)) + (x*Idc)/(R*A), 200e-3)

# Resuelve la ecuación
soluciones = solve(ecuacion, x)

# Imprime las soluciones
print("Las soluciones son:", soluciones)
print("Con un Al de: ", (1/R)*1e9, "nH")
