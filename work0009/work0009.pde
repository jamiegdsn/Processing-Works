ArrayList<Particle> particles = new ArrayList<Particle>();
int numParticles = 20000;
color bgColor;
int hue;

final int THEME = 1; // 0 : black theme, 1 : white theme

void setup () {
  size(2048, 1024, P2D);
  smooth(16);
  pixelDensity(displayDensity());
  colorMode(HSB, 360, 100, 100, 100);
  if (THEME == 0) bgColor = color(0, 0, 5);
  else if (THEME == 1) bgColor = color(0, 0, 98);
  reset();
}

void reset() {
  background(bgColor);
  hue = (int)random(360);
  noiseDetail(8, 0.5);
  noiseSeed(millis());
  initPoints();
}

void initPoints() {
  particles.clear();
  for (int i = 0; i < numParticles; i++) {
    particles.add(new Particle());
  }
}

void draw() {
  for (int i = 0; i < 10; i++) {
   
  strokeWeight(0.5);
  beginShape(LINES);
  for (Particle p : particles) {
    p.update();
    p.addVertex();
  }
  endShape();

  }
}

void keyPressed() {
  switch (key) {
    case 'r': reset(); break;
    case 's': saveFrame("frames/####.png"); break;
  }
}