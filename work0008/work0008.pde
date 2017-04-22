ArrayList<Particle> particles = new ArrayList<Particle>();
int numParticles = 1500;
color bgColor;
int updateCount = 0;
int hue1;
int hue2;

void setup () {
  size(2048, 1024, P3D);
  pixelDensity(displayDensity());
  colorMode(HSB, 360, 100, 100, 100);
  bgColor = color(0, 0, 98);
  background(bgColor);
  hint(DISABLE_DEPTH_TEST);
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
  updateCount = 0;
  hue1 = (int)random(360);
  hue2 = (int)random(360);
}

void draw() {
  if (updateCount % 200 == 0) {
    noiseSeed(millis());
    initPoints();
  }
  translate(width/2, height/2, 0);
  rotateZ(HALF_PI);

  strokeWeight(0.5);

  for (int f = 0; f < 20; f++) {
    for (Particle p : particles) {
      p.update();
    }

    beginShape(LINES);
    for (int i = 0;  i < numParticles; i++) {
      Particle from = particles.get(i);
      for (int j = i + 1;  j < numParticles; j++) {
        Particle to = particles.get(j);
        float d = dist(from.x, from.y, from.z, to.x, to.y, to.z);
        float lengthLimit = map(abs(from.unitZ + to.unitZ), 0, 2, 50, 10);
        if (d < lengthLimit) {
          from.addVertex();
          to.addVertex();
        }
      }
    }
    endShape();

    updateCount++;
  }
}

void keyPressed() {
  switch (key) {
    case 'r': reset(); redraw(); break;
    case 's': saveFrame("frames/####.png"); break;
  }
}
