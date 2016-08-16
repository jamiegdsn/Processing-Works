ArrayList<Particle> particles = new ArrayList<Particle>();
int numParticles = 1000;
float lengthLimit = 50;
color bgColor;

void setup () {
  fullScreen(P3D);
  // size(1280, 720, P3D);
  pixelDensity(displayDensity());
  colorMode(HSB, 360, 100, 100, 100);
  bgColor = color(215, 80, 8);
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
  if (frameCount % 400 == 0) {
    noiseSeed(millis());
  }
  translate(width/2, height/2, 0);
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

void keyPressed() {
  switch (key) {
    case 'r': reset(); break;
    case 's': saveFrame("frames/frame-####.png"); break;
  }
}
