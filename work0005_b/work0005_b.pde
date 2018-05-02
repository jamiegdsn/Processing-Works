ArrayList<Particle> particles = new ArrayList<Particle>();
int numParticles = 600;
color bgColor;
int updateCount = 0;
int hue;

void setup() {
  size(2048, 1024, P3D);
  pixelDensity(displayDensity());
  smooth(16);
  colorMode(HSB, 360, 100, 100, 100);
  bgColor = color(0, 0, 98);
  hint(DISABLE_DEPTH_TEST);
  reset();
}

void reset() {
  background(bgColor);
  updateCount = 0;
  hue = (int)random(360);
  initPoints();
}

void initPoints() {
  noiseSeed(millis());
  particles.clear();
  for (int i = 0; i < numParticles; i++) {
    particles.add(new Particle());
  }
}

void draw() {
  translate(width/2, height/2, 0);
  rotateZ(HALF_PI);

  strokeWeight(0.5);
  for (int f = 0; f < 10; f++) {
    for (Particle p : particles) {
      p.update();
    }

    beginShape(LINES);
    for (int i = 0; i < numParticles; i++) {
      Particle from = particles.get(i);
      for (int j = i + 1; j < numParticles; j++) {
        Particle to = particles.get(j);
        float d = dist(from.x, from.y, from.z, to.x, to.y, to.z);
        float lengthLimit = map(abs(from.unitY + to.unitY), 0, 2, 30, 3);
        if (d < lengthLimit) {
          from.addVertex();
          to.addVertex();
        }
      }
    }
    endShape();

    if (++updateCount % 600 == 0) {
      initPoints();
    }
  }
}

void keyPressed() {
  switch (key) {
    case 'r': reset(); break;
    case 's': saveFrame("frames/####.png"); break;
  }
}
