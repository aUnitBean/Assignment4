%% Assignment 4 Part 2
%Simulation of circuit response to Gaussan input

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
t = linspace(0, 1, step);
dt = 10^-3;

V = zeros(7, step);
V_prev = zeros(7, 1);
F = zeros(1,7);


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

for time = 1:step
    F(1) = exp(-1/2*((time/step-0.06)/(0.03))^2);
    V(:,time) = (C./dt+G)\(F'+C*V_prev/dt);
    V_prev = V(:, time);      
end

plot(t, V(7,:), 'r')
hold on
plot(t, V(1,:), 'b')
title('V_{in} and V_o, Guassian Input')
xlabel('Time (s)')
ylabel('Potential (V)')
legend('V_{O}','V_{in}')

fft_V = fft(V.');
ffts_V = fftshift(fft_V);
freq = linspace(-step/2,step/2,step);

nexttile
plot (freq, (abs(ffts_V(:,7))), 'r');
hold on
plot (freq, (abs(ffts_V(:,1))), 'b');
title("V_{in} and V_{o}, Frequency Domain")
legend('V_{O}','V_{in}')
ylabel('Potential (dB)');
xlabel('Frequency (Hz)');

grid on