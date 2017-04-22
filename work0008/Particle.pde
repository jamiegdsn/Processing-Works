class Particle {
  float x, y, z;
  float unitZ;
  float radius;
  float theta, phi;
  float velocityMag = 0.01;
  float noiseScale = 0.15;
  float sNoisePosX, sNoisePosY;
  color strokeColor;
  int layer;

  Particle() {
    initAngle();
    int r = (int)random(4);
    switch (r) {
      case 0: sNoisePosX =  100; sNoisePosY =  100; break;
      case 1: sNoisePosX =  100; sNoisePosY = -100; break;
      case 2: sNoisePosX = -100; sNoisePosY =  100; break;
      case 3: sNoisePosX = -100; sNoisePosY = -100; break;
    }
    r = (int)random(100);
    if (r < 66) {
      strokeColor = color(hue1, 60, random(30, 50), 2);
    } else {
      strokeColor = color(hue2, 60, random(30, 50), 2);
    }
    layer = (int)random(5);
  }

  void initAngle() {
    unitZ = random(-1, 1);
    theta = acos(unitZ);
    phi = random(TWO_PI);
  }

  void update() {
    float noisePosX = sNoisePosX + phi * noiseScale;
    float noisePosY = sNoisePosY + theta * noiseScale;
    float angle = noise(noisePosX, noisePosY) * (4 * TWO_PI) - (2 * TWO_PI);
    if (layer <= 1) {
      radius = map(angle, - 2 * TWO_PI, 2 * TWO_PI, height * 0.5, height * 0.7);
    } else {
      radius = map(angle, - 2 * TWO_PI, 2 * TWO_PI, height * 0.2, height * 0.5);
    }

    phi   += 2 * velocityMag * cos(angle);
    theta += velocityMag * sin(angle);
    unitZ = cos(theta);

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
