class Particle {
  float x, y, z;
  float unitY;
  float theta, phi;
  float velocityMag = 0.01;
  float noiseScale = 0.08;
  color strokeColor;

  Particle() {
    initAngle();
    strokeColor = color(hue, 40, random(30, 50), 2);
  }

  void initAngle() {
    unitY = random(-1, 1);
    theta = acos(unitY);
    phi = random(TWO_PI);
  }

  void update() {
    float noisePosX = phi * noiseScale;
    float noisePosY = theta * noiseScale;
    float noiseValue = noise(noisePosX, noisePosY);
    float angle = noiseValue * (4 * TWO_PI) - (2 * TWO_PI);
    float radius = map(noiseValue, 0, 1, height * 0.2, height * 0.4);

    phi   += 2 * velocityMag * cos(angle);
    theta += velocityMag * sin(angle);
    unitY = cos(theta);

    x = radius * sin(theta) * cos(phi);
    y = radius * cos(theta);
    z = radius * sin(theta) * sin(phi);
  }

  void addVertex() {
    stroke(strokeColor);
    vertex(x, y, z);
  }

  void display() {
    stroke(strokeColor);
    point(x, y, z);
  }
}