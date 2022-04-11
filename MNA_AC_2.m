%Sarah Dolan, ELEC 4700, March 2022
%% PA-7, MNA Building

iterations = 500;
omega = linspace (0, 100 , iterations);

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

Vo = zeros(1, iterations);
V1 = zeros(1, iterations);
V2 = zeros(1, iterations);
V3 = zeros(1, iterations);
V4 = zeros(1, iterations);
IL = zeros(1, iterations);
I3 = zeros(1, iterations);

%F= zeros(7,1);
Vs = 1;

for n = 1:iterations 
      % V1    V2     IL    V3    I3    V4    V0
    G = [1    0      0     0     0     0     0;
        -G2   G1+G2 -1     0     0     0     0;
         0    1      0    -1     0     0     0;
         0    0     -1     G3    0     0     0;
         0    0      0     0    -a     1     0;
         0    0      0     G3   -1     0     0;
         0    0      0     0     0    -G4   G4+G0];
    
      % V1    V2     IL    V2    I3    V4    V0
    C = [0    0      0     0     0     0     0;
        -C1   C1     0     0     0     0     0;
         0    0      L    0     0     0     0;
         0    0      0     0     0     0     0;
         0    0      0     0     0     0     0;
         0    0      0     0     0     0     0;
         0    0      0     0     0     0     0 ];

    
    F = [Vs   0     0     0     0    0    0];
    
    V = (G+C*1i*omega(n))\F';  
    
  
    V1(n) = real(V(1, 1));
    V2(n) = real(V(2, 1));
    IL(n) = real(V(3, 1));
    V3(n) = real(V(4, 1));
    I3(n) = real(V(5, 1));
    V4(n) = real(V(6, 1));
    Vo(n) = real(V(7, 1));

end
nexttile
    plot(omega(1:iterations), Vo)
    hold on
    plot(omega(1:iterations), V3)
    title("Vo and V3, AC Simulation")
    ylabel("Potential (V)")
    xlabel("\omega")
    legend('V_0','V_3')


nexttile
    semilogx (omega, log(Vo./V1));
    title("AC Gain, V_o/ V_1")
    ylabel("V_o/ V_1 (dB)")
    xlabel("\omega")

