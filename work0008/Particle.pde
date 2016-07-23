class Particle {
  float x, y, z;
  float radius;
  float theta, phi;
  float velocityMag = 0.015;
  float noiseScale = 1;
  float sNoisePosX, sNoisePosY;
  color strokeColor;
  boolean isInsane;

  Particle() {
    initAngle();
    int r = (int)random(4);
    switch (r) {
      case 0: sNoisePosX = 100; sNoisePosY = 100; break;
      case 1: sNoisePosX = 100; sNoisePosY = -100; break;
      case 2: sNoisePosX = -100; sNoisePosY = 100; break;
      case 3: sNoisePosX = -100; sNoisePosY = -100; break;
    }
    isInsane = random(100) < 1 ? true : false;
    if (isInsane) {
      strokeColor = color(random(160, 220), 80, 80, 40);
    } else {
      strokeColor = color(random(160, 220), 80, 60, 5);
    }
  }

  void initAngle() {
    float unitZ = random(-1, 1);
    theta = acos(unitZ);
    phi = random(TWO_PI);
  }

  void update() {
    float noisePosX = sNoisePosX + theta * noiseScale;
    float noisePosY = sNoisePosY + phi * noiseScale;
    float angle = noise(noisePosX, noisePosY) * (4 * TWO_PI) - (2 * TWO_PI);
    if (isInsane) {
      radius = map(angle, - 2 * TWO_PI, 2 * TWO_PI, height * 0.5, height * 0.6);
    } else {
      radius = map(angle, - 2 * TWO_PI, 2 * TWO_PI, height * 0.3, height * 0.5);
    }

    theta += velocityMag * cos(angle);
    phi   += velocityMag * sin(angle);

    x = radius * sin(theta) * cos(phi);
    y = radius * sin(theta) * sin(phi);
    z = radius * cos(theta);
  }

  void display() {
    stroke(strokeColor);
    point(x, y, z);
  }
}
