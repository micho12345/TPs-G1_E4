%% Realimentacion. Venier Anache, Valentino. 60097.

clear all;
clc;

%% Forma canónica de variables de fase - Continua
disp('******************************************')
disp('Forma canónica de variables de fase - Continua')
syms s;
N1 = 124;
N2 = 26;
L1 = 4.26e-3;
L2 = 188.9e-6;
Cap = 47e-6;
RL2 = 32;
d = 0.2;


Aon = [0,0;
       0,-(1/(RL2*Cap))];
 
Bon = [ 1/L1;
        0];
  
Con = [0 1];

Aoff = [0,(-1/L2)*(N2/N1);
       (1/Cap)*(N1/N2),-(1/(RL2*Cap))];
   
Boff = [ 0;
        0];   

Coff = [0 1];

A = Aon*d + Aoff*(1-d)
B = Bon*d + Boff*(1-d)
C = Con*d + Coff*(1-d)
D = 0;

Sf = ss(A, B, C, D)

%% Chequeo transferencia
disp('Chequeo transferencia')
[num, den] = ss2tf(A, B, C, D);
G = tf(num, den);
zpk(G)

%% Chequeo controlabilidad
MC = [B, A*B];
if det(MC) ~= 0
    disp('Es controlable')
else
    disp('No es controlable')
end

%% Chequeo observabilidad
Om = obsv(A,C);
Rank_O = rank(Om);
if Rank_O == 2
    disp('Es Observable')
else
    disp('No es Observable')
end

%% Polos continuos
disp('******************************************')
wn = 2000*2*pi;
xi = 0.707;
disp('Polos plano S')
p1 = - xi*wn + 1i*wn*sqrt(1-xi^2);
double(p1)
p2 = - xi*wn - 1i*wn*sqrt(1-xi^2);
double(p2)


cp = [p1,p2]
k = place (A,B,cp)
Acl = A-B*k

cp_check = eig(Acl);

[numT,denT] = ss2tf(Acl,B,C,D);
Tcl = tf(numT,denT)

%% Control Integral
disp('******************************************')
disp('Control integral');
Aa = [[A;-C] zeros(3,1)];
Ba = [B;-D];
Ca = [C 0];
Bar = [0 ; 0 ; 1];
Da = [0];

cpl = [cp, -10000] %Agregar un polo muy lejos para que no afecte al resto del sistema

Kc = place(Aa, Ba, cpl)
Acli = Aa-Ba*Kc

% Determinamos el error en regimen permanente
ess = 1+Ca*(inv(Acli))*Bar
% Calcula la transferencia a lazo cerrado con el CI.
[numT,denT] = ss2tf(Acli,Bar,Ca,Da);

disp('******************************************')
disp('Transferencia con control integral');
Ta = tf(numT,denT)
minreal(Ta);

step(Ta)
stepinfo(Ta)





