
%% Assignment 4 Part 2
%Simulation of circuit response to Sinusois Function input

R0 = 1000;
R1 = 1;
R2 = 2;
R3 = 17.68;
R4 = 0.1;
C1 = 0.25;
L = 0.2;
a = 100;

G0 = 1/R0;
G1 = 1/R1;
G2 = 1/R2;
G3 = 1/R3;
G4 = 1/R4;

step = 1000;
iterations = 15;
t = linspace(0, 1, step);
dt = 1E-3;

V =  zeros(7 , 1);
Vs = zeros(1, step);
Vo = zeros(1, step);
V1 = zeros(1, step);
V2 = zeros(1, step);
V3 = zeros(1, step);
V4 = zeros(1, step);
IL = zeros(1, step);
I3 = zeros(1, step);

  % V1    V2     IL    V3    I3    V4    V0
G = [1    0      0     0     0     0     0;
    -G2   G1+G2 -1     0     0     0     0;
     0    1      0    -1     0     0     0;
     0    0     -1     G3    0     0     0;
     0    0      0     0    -a     1     0;
     0    0      0     G3   -1     0     0;
     0    0      0     0     0    -G4   G4+G0];

  % V1    V2     IL    V3    I3    V4    V0
C = [0    0      0     0     0     0     0;
    -C1   C1     0     0     0     0     0;
     0    0      -L    0     0     0     0;
     0    0      0     0     0     0     0;
     0    0      0     0     0     0     0;
     0    0      0     0     0     0     0;
     0    0      0     0     0     0     0 ];

f = 1/0.03;

for time = 1:step
Vs(time) = sin(2* pi * f * t(time));
F = [Vs(time)    0     0    0     0     0     0];
 for n = 1:iterations 
    V_prev = V;
    V = (C./dt + G)\(C.*V_prev./dt + F');
   
 end

    V1(time) = V(1, 1);
    V2(time) = V(2, 1);
    IL(time) = V(3, 1);
    V3(time) = V(4, 1);
    I3(time) = V(4, 1);
    V4(time) = V(6, 1);
    Vo(time) = V(7, 1);

end


plot (t, Vo);
hold on
plot (t, V1,'color','red');
title("V_{in} and V_{o}, Sinusoid Input")
legend('V_{O}','V_{in}')
xlabel('time (s)');
ylabel('Potential (V)');

fft_V1 = fft(V1.');
ffts_V1 = fftshift(fft_V1);

fft_Vo = fft(Vo.');
ffts_Vo = fftshift(fft_Vo);

nexttile
freq = linspace(-step/2,step/2,step);
plot (freq, (abs(ffts_V1)), 'r');
hold on
plot (freq, (abs(ffts_Vo)), 'b');

title("V_{in} and V_{o}, Frequency Domain")
legend('V_{O}','V_{in}')
ylabel('Potential (dB)');
xlabel('Frequency (Hz)');

grid on

