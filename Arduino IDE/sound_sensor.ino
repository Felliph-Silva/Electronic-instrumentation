// Define os pinos usados pelo sensor KY-037
#define SOUND_SENSOR_PIN 2  // Pino GPIO 02 (analógico no ESP32)

// Variáveis para armazenar a leitura do sensor
int soundLevel = 0;
float filteredSoundLevel = 0;  // Inicialização do valor filtrado

// Parâmetros do filtro
float alpha = 0.1;  // Ajuste para controlar a frequência de corte do filtro (0 < alpha <= 1)

void setup() {
  // Inicializa a comunicação serial
  Serial.begin(115200);

  // Configura o pino como entrada
  pinMode(SOUND_SENSOR_PIN, INPUT);
}

void loop() {
  // Lê o valor analógico do sensor de som
  soundLevel = analogRead(SOUND_SENSOR_PIN);

  // Aplica o filtro IIR passa-baixa
  filteredSoundLevel = alpha * soundLevel + (1 - alpha) * filteredSoundLevel;

  // Exibe os valores no monitor serial
  //Serial.print("Raw: ");
  Serial.print(soundLevel);
  //Serial.print(" | Filtered: ");
  Serial.print(" ");
  Serial.println(filteredSoundLevel);

  // Aguarda um tempo para evitar sobrecarregar o monitor serial
  delay(50);  // Ajuste o tempo conforme necessário para sua aplicação
}
