ArrayList<Particle> particles = new ArrayList<Particle>();
int numParticles = 1000;
float lengthLimit = 50;
color bgColor;

void setup () {
  // fullScreen(P3D);
  size(1920, 1080, P3D);
  pixelDensity(displayDensity());
  colorMode(HSB, 360, 100, 100, 100);
  bgColor = color(0, 0, 95);
  background(bgColor);
  initPoints();
}

void initPoints() {
  particles.clear();
  for (int i = 0; i < numParticles; i++) {
    particles.add(new Particle());
  }
}

void reset() {
  background(bgColor);
  noiseSeed(millis());
  initPoints();
  frameCount = 0;
}

void draw() {
  if (frameCount % 360 == 0) {
    noiseSeed(millis());
  }
  translate(width/2, height/2, 0);

  if (frameCount == 1) {
    for (int i = 0; i < 10; i++) {
      float startAngle = random(TWO_PI);
      float endAngle = startAngle + random(HALF_PI);
      float angleStep = radians(random(0.2, 0.5));
      drawLine(startAngle, endAngle, angleStep, random(height * 0.5, height * 0.8));
    }
  }

  rotateZ(HALF_PI);

  strokeWeight(0.5);
  for (Particle p : particles) {
    p.update();
    p.display();
  }

  for (int i = 0;  i < numParticles; i++) {
    Particle from = particles.get(i);
    for (int j = i + 1;  j < numParticles; j++) {
      Particle to = particles.get(j);
      float d = dist(from.x, from.y, from.z, to.x, to.y, to.z);
      if (d < lengthLimit) {
        stroke(from.strokeColor);
        line(from.x, from.y, from.z, to.x, to.y, to.z);
      }
    }
  }
}

void drawLine(float startAngle, float endAngle, float angleStep, float radius) {
  noFill();
  stroke(0, 0, random(0, 50));
  strokeWeight(1);
  for (float angle = startAngle; angle < endAngle; angle += angleStep) {
    float r1 = random(1, 1.05);
    float r2 = random(0.8, 1);
    float x1 = radius * r1 * cos(angle);
    float y1 = radius * r1 * sin(angle);
    float x2 = radius * r2 * cos(angle);
    float y2 = radius * r2 * sin(angle);
    line(x1, y1, 0, x2, y2, 0);
  }
}

void keyPressed() {
  switch (key) {
    case 'r': reset(); break;
    case 's': saveFrame("images/frame-####.png"); break;
  }
}
