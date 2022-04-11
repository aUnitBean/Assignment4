%Sarah Dolan, ELEC 4700, March 2022
%% PA-7, MNA Building, DC
R0 = 1000;
R1 = 1;
R2 = 2;
R3 = 17.68;
R4 = 0.1;
C1 = 0.25;
L = 0.2;
a = 100;
omega = 0;

%syms Is IL V1 V2 V3 V4 V0;

G0 = 1/R0;
G1 = 1/R1;
G2 = 1/R2;
G3 = 1/R3;
G4 = 1/R4;

%Vs = 1;

iterations = 200;
Vo = zeros(1, iterations);
V1 = zeros(1, iterations);
V2 = zeros(1, iterations);
V3 = zeros(1, iterations);
V4 = zeros(1, iterations);
IL = zeros(1, iterations);
Is = zeros(1, iterations);

Vs = linspace (-10, 10 , iterations);

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
         0    0      -L    0     0     0     0;
         0    0      0     0     0     0     0;
         0    0      0     0     0     0     0;
         0    0      0     0     0     0     0;
         0    0      0     0     0     0     0 ];

    
    F = [Vs(n)    0     0    0     0     0     0];
    
    V = F/(G' + 1i * omega * C') ;
    
    Is(n) = V(1, 1);
    IL(n) = V(1, 2);
    V1(n) = V(1, 3);
    V2(n) = V(1, 4);
    V3(n) = V(1, 5);
    V4(n) = V(1, 6);
    Vo(n) = V(1, 7);

end
nexttile
plot (Vs, Vo);
hold on
plot (Vs, V3,'color','red');
title("Vo and V3, DC SImulation")
legend('V_0','V_3')
xlabel('V_{in}');
ylabel('Potential (V)');



