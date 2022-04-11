%Sarah Dolan, ELEC 4700, March 2022
%% PA-7, MNA Building


iterations = 500;
omega = pi;

R0 = 1000;
R1 = 1;
R2 = 2;
R3 = 10;
R4 = 0.1;



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
Is = zeros(1, iterations);

Vs =  10*real(exp(1i * omega));

C1 = normrnd(0.25, 0.05, [iterations, 1]);


histogram(C1);
title("Histogram for C")
xlabel("C (F)")
ylabel("Occurences")


for n = 1:iterations 
      % Is    IL     V1    V2    V3    V4    V0
    G = [0     0     1     0     0     0     0;
         1     0     G1    -G1   0     0     0;
         0    -1    -G1  (G1-G2) 0     0     0;
         0     0     0    -1     1     0     0;
         0     1     0     0    -G3    0     0;
         0     -a    0     0     0     1     0;
         0     0     0     0     0     -G4   (G4+G0)];
    
    C = [0     0     0         0       0     0     0;
         0     0     C1(n)   -C1(n)    0     0     0;
         0     0    -C1(n)    C1(n)    0     0     0;
         0     -L    0         0       0     0     0;
         0     0     0         0       0     0     0;
         0     0     0         0       0     0     0;
         0     0     0         0       0     0     0];
    
    F = [Vs    0     0     0     0     0     0];
    
    V = F/(G' + 1i * omega * C') ;

    Is(n) = real(V(1, 1));
    IL(n) = real(V(1, 2));
    V1(n) = real(V(1, 3));
    V2(n) = real(V(1, 4));
    V3(n) = real(V(1, 5));
    V4(n) = real(V(1, 6));
    Vo(n) = real(V(1, 7));
end

A = Vo./V1;
nexttile
hist(real((log(A) ) ) );
title("Histogram for AC Gain, V_o/ V_1, \omega = \pi")
xlabel("V_o/ V_1 (dB)")
ylabel("Occurences")


