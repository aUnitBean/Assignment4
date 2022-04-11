
%Potential Maximum
numplot =10;  %number of points plotted
V0 = linspace(0.1,10,numplot);  %matrix of potential points
%Silicon Temperature
T = 300;

%Number of Particles
num_part = 30000;

% Sigma Map
sigma_out = 1;
sigma_in = 10^-2;

% Dimesions
passageWidth = 10;

passageLength = 40;
l = 200; % length
w = 100; % width
silicon = zeros(w, l);

ave_current = zeros(numplot,1);

for i = 1:numplot
    ave_current(i) = A4_boxes(passageWidth, V0(i));
end

P = polyfit(V0,ave_current,1);
yfit = P(1)*V0+P(2);

plot(V0,ave_current);
hold on
plot (V0, yfit)
title("Current in Silicon vs Input Potential");
ylabel('Currnet, (A)')
xlabel('Input Potential, (V)')


slope = 1/P(1)
