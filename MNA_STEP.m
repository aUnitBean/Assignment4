
%% Assignment 4 Part 2
%Simulation of circuit response to Step Function input

R0 = 1000;
R1 = 1;
R2 = 2;
R3 = 10;
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
dt = 10^-3;


V = zeros(7, step);
V_start = zeros(7, 1);
V_prev = zeros(7, 1);
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


for time = 1:step
     Vs = time >30;
     F = [Vs 0 0 0 0 0 0];
     V(:,time) = (C./dt+G)\(F'+C*V_prev/dt);
     V_prev = V(:, time);   
end

fft_V = fft(V');
ffts_V = fftshift(fft_V);



figure(1)
plot(t, V(7,:), 'r')
hold on
plot(t, V(1,:), 'b')
title('V_{in} and V_{o}, Step Input')
xlabel('Time (s)')
ylabel('Potential (V)')
legend('V_{O}','V_{in}')
grid on

freq = linspace(-step/4,step/4,step);

nexttile

plot (freq, (abs(ffts_V(:,7))), 'r');
hold on
plot (freq, (abs(ffts_V(:,1))), 'b');
title("V_{in} and V_{o}, Frequency Domain")
legend('V_{O}','V_{in}')
ylabel('Potential (dB)');
xlabel('Frequency (Hz)');
