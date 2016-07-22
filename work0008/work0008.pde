ArrayList<Particle> particles = new ArrayList<Particle>();
color bgColor;

void setup () {
  size(1280, 720, P3D);
  pixelDensity(displayDensity());
  colorMode(HSB, 360, 100, 100, 100);
  bgColor = color(0, 0, 98);
  background(bgColor);
  initPoints();
}

void initPoints() {
  int numParticles = 10000;

  particles.clear();
  for (int i = 0; i < numParticles; i++) {
    particles.add(new Particle());
  }
  strokeWeight(1);
}

void draw() {
  translate(width/2, height/2, 0);
  rotateY(HALF_PI);

  for (Particle p : particles) {
    p.update();
    p.display();
  }
}

void keyPressed() {
  switch (key) {
    case 'c': background(bgColor); break;
    case 'r': initPoints(); break;
    case 'n': noiseSeed(millis()); break;
    case 's': saveFrame("images/frame-####.jpg"); break;
  }
}
