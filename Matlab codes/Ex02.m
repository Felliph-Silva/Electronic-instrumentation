clc
clear

% Leitura dos dados
A = readmatrix('leitura_sensor_filtrado.txt');

time = A(1:end, 1); % Tempo
y1 = A(1:end, 2);   % Sinal original
y2 = A(1:end, 3);   % Sinal filtrado

% Parâmetros da FFT
Fs = 1 / (50E-3);   % Taxa de amostragem (inverso do intervalo de tempo)
L = length(y1);     % Comprimento do sinal
f = Fs * (0:(L/2)) / L; % Eixo de frequência

% Aplicação da FFT para y1
Y1_fft = fft(y1);          % Transformada de Fourier do sinal original
P2_y1 = abs(Y1_fft / L);   % Espectro de duas faces (y1)
P1_y1 = P2_y1(1:L/2+1);    % Espectro de uma face (y1)
P1_y1(2:end-1) = 2 * P1_y1(2:end-1); % Ajuste de magnitude

% Aplicação da FFT para y2
Y2_fft = fft(y2);          % Transformada de Fourier do sinal filtrado
P2_y2 = abs(Y2_fft / L);   % Espectro de duas faces (y2)
P1_y2 = P2_y2(1:L/2+1);    % Espectro de uma face (y2)
P1_y2(2:end-1) = 2 * P1_y2(2:end-1); % Ajuste de magnitude

% Gráficos
figure;

% Gráfico do sinal y1 no tempo
subplot(2,2,1);
plot(time, y1);
xlabel("Tempo (s)");
ylabel("Amplitude");
title("Sinal original (y1)");
grid on;

% Gráfico do sinal y2 no tempo
subplot(2,2,2);
plot(time, y2);
xlabel("Tempo (s)");
ylabel("Amplitude");
title("Sinal filtrado (y2)");
grid on;

% Gráfico do espectro de frequência de y1
subplot(2,2,3);
plot(f, P1_y1);
xlabel("Frequência (Hz)");
ylabel("Amplitude");
title("Espectro de Frequência do Sinal original (y1)");
grid on;

% Gráfico do espectro de frequência de y2
subplot(2,2,4);
plot(f, P1_y2);
xlabel("Frequência (Hz)");
ylabel("Amplitude");
title("Espectro de Frequência do Sinal filtrado (y2)");
grid on;