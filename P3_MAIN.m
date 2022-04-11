
nexttile
Cn = [0.00003; 0.00001; 0.000001];
dt = [10 ^-3; 10^-1; 10^-2];

% Varying Capacitance
MNA_GAUSSIAN_NOISE(Cn(1), dt(1))
figure
MNA_GAUSSIAN_NOISE(Cn(2), dt(1))
figure
MNA_GAUSSIAN_NOISE(Cn(3), dt(1))


% Varying Time
figure
MNA_GAUSSIAN_NOISE(Cn(2), dt(2))
figure
MNA_GAUSSIAN_NOISE(Cn(2), dt(3))