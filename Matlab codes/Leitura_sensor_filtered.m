% Limpar leituras e gráficos anteriores
clear;
close all;

% Configuração da porta serial
portaSerial = '/dev/ttyUSB0'; % Substitua pela sua porta serial (exemplo: COM3 no Windows)
taxaBits = 115200;              % Taxa de bits definida no código Arduino

% Abre a conexão serial
s = serialport(portaSerial, taxaBits);

% Inicializa os gráficos
figure(1);
h1 = animatedline('Color', 'b', 'DisplayName', 'Bruto');
h2 = animatedline('Color', 'r', 'DisplayName', 'Filtrado');
legend;
title('Leitura da Entrada Analógica do MCU');
xlabel('Tempo (s)');
ylabel('Valor Analógico');
grid on;

% Tempo de execução
tempoInicial = datetime('now');
duration = seconds(15); % Tempo de execução do gráfico (ajuste conforme necessário)

% Inicializa arrays para armazenar dados de tempo e leitura
tempos = [];
leiturasBruto = [];
leiturasFiltrado = [];

% Leitura e plotagem em tempo real
while datetime('now') - tempoInicial < duration
    if s.NumBytesAvailable > 0
        % Lê os valores do Arduino
        data = readline(s); % Lê uma linha da porta serial
        valores = str2double(split(data, ' ')); % Divide pelos separadores de tabulação

        % Verifica se os dados são válidos
        if numel(valores) == 2
            valorBruto = valores(1);
            valorFiltrado = valores(2);

            % Obtém o tempo atual e adiciona o ponto ao gráfico
            tempoAtual = datetime('now') - tempoInicial;
            tempoSegundos = seconds(tempoAtual);

            % Adiciona dados aos arrays
            tempos = [tempos; tempoSegundos];
            leiturasBruto = [leiturasBruto; valorBruto];
            leiturasFiltrado = [leiturasFiltrado; valorFiltrado];

            % Adiciona pontos aos gráficos
            addpoints(h1, tempoSegundos, valorBruto);
            addpoints(h2, tempoSegundos, valorFiltrado);
            drawnow;
        end
    end
end

% Fecha a conexão serial
clear s;

% Salva os dados em um arquivo
dadosSalvos = [tempos, leiturasBruto, leiturasFiltrado];
writematrix(dadosSalvos, 'leitura_sensor_filtrado.txt', 'Delimiter', '\t');

% Gera o gráfico final com os dados armazenados
figure(2);
plot(tempos, leiturasBruto, 'b', 'DisplayName', 'Bruto');
hold on;
plot(tempos, leiturasFiltrado, 'r', 'DisplayName', 'Filtrado');
title('Dados armazenados da leitura analógica do MCU');
xlabel('Tempo (s)');
ylabel('Valor Analógico');
legend;
grid on;
