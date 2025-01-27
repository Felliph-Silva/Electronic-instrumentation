% Limpar leiturar e gŕaficos anteriores
clear;
close all;

% Configuração da porta serial
portaSerial = '/dev/ttyUSB0'; % Substitua pela sua porta serial (exemplo: COM3 no Windows)
taxaBits = 115200;              % Taxa de bits definida no código Arduino

% Abre a conexão serial
s = serialport(portaSerial, taxaBits);

% Inicializa o gráfico
figure(1);
h = animatedline;
title('Leitura da Entrada Analógica do MCU');
xlabel('Tempo (s)');
ylabel('Valor Analógico');
grid on;

% Tempo de execução
tempoInicial = datetime('now');
duration = seconds(15); % Tempo de execução do gráfico (ajuste conforme necessário)

% Inicializa arrays para armazenar dados de tempo e leitura
tempos = [];
leituras = [];

% Leitura e plotagem em tempo real
while datetime('now') - tempoInicial < duration
    if s.NumBytesAvailable > 0
        % Lê o valor do Arduino
        data = str2double(readline(s));

        % Obtém o tempo atual e adiciona o ponto ao gráfico
        tempoAtual = datetime('now') - tempoInicial;
        tempoSegundos = seconds(tempoAtual);

        % Adiciona dados aos arrays
        tempos = [tempos; tempoSegundos];
        leituras = [leituras; data];

        % Adiciona ponto ao gráfico
        addpoints(h, tempoSegundos, data);
        drawnow;
    end
end

% Fecha a conexão serial
clear s;

out = [tempos ; leituras];

writematrix(out,'leitura_sensor.txt')

figure(2);
plot(tempos, leituras);
title('Dados armazenados da leitura analógica do MCU');
xlabel('Tempo (s)');
ylabel('Valor Analógico');

grid on;


% Exibe os dados salvos (opcional)
% disp('Tempos (s):');
% disp(tempos);
% disp('Leituras:');
% disp(leituras);
