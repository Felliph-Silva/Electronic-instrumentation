const int analogPin = 2;        // Pino A0 do sensor KY-037
const int ledPins[] = {13, 12, 14, 27, 26, 25, 4, 33, 32, 35, 34}; // Pinos dos LEDs
const int numLeds = 11;         // Número total de LEDs
int soundValue = 0;             // Leitura do som (A0)
int tolerance = 0;             // Tolerância mínima para som

void setup() {
  // Configura os pinos dos LEDs como saída
  for (int i = 0; i < numLeds; i++) {
    pinMode(ledPins[i], OUTPUT);
    digitalWrite(ledPins[i], LOW); // Inicialmente, todos os LEDs desligados
  }

  Serial.begin(115200);         // Inicializa a comunicação serial
}

void loop() {
  // Lê o valor analógico do sensor de som
  soundValue = analogRead(analogPin);

  // Aplica a tolerância mínima
  if (soundValue < tolerance) {
    soundValue = 0; // Ignora valores abaixo da tolerância
  }

  // Divide o valor de som em faixas para os LEDs
  int level = map(soundValue, 1700, 1950, 0, 11); // ESP32 tem resolução ADC de 12 bits (0-4095)

  // Acende os LEDs até o nível correspondente
  for (int i = 0; i < numLeds; i++) {
    if (i < level) {
      digitalWrite(ledPins[i], HIGH); // Liga os LEDs até o nível atual
    } else {
      digitalWrite(ledPins[i], LOW);  // Desliga os LEDs acima do nível atual
    }
  }

  // Mostra o valor lido e o nível no monitor serial
  //Serial.print("Sound Value: ");
  Serial.println(soundValue);
  //Serial.print(" | Level: ");
  //Serial.println(level);

  delay(50); // Pequena pausa para atualizar os LEDs
}
