clc
clear

A = readmatrix('leitura_sensor.txt');

time = A(1,1:end);
y = A(2,1:end);

plot(time, y);
xlabel("time(s)");
ylabel("Magnitude")