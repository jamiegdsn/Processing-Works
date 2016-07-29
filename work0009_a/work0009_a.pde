int numFragments = 20;
ArrayList<SphereFragment> sFragments = new ArrayList<SphereFragment>();

void setup() {
  // fullScreen(P3D);
  size(1200, 1200, P3D);
  pixelDensity(displayDensity());
  colorMode(HSB, 360, 100, 100, 100);
  smooth(8);
  blendMode(ADD);
  hint(DISABLE_DEPTH_TEST);
  initSphere();
}

void initSphere() {
  sFragments.clear();
  for (int i = 0; i < numFragments; i++) {
    float startTheta = radians(random(180));
    float endTheta;
    if (random(2) < 1) {
      endTheta = startTheta + radians(random(20, 45));
    } else {
      endTheta = startTheta;
      startTheta -= radians(random(20, 45));
    }
    startTheta = max(startTheta, radians(10));
    endTheta = min(endTheta, radians(170));

    float startPhi = radians(random(360));
    float endPhi = startPhi + radians(random(60, 180));
    SphereFragment sf = new SphereFragment(startTheta, endTheta, startPhi, endPhi);
    sFragments.add(sf);
  }
}

void draw() {
  background(210, 80, 5);
  // showFrameRate();
  translate(width/2, height/2, 0);

  for (SphereFragment sf : sFragments) {
    sf.update();
    sf.display();
  }
}

void showFrameRate() {
  fill(0 , 0, 100);
  text(frameRate, 100, 100);
}

void keyPressed() {
  if (key == 'r') {
    initSphere();
  }
  if (key == 's') {
    saveFrame("frame-####.jpg");
  }
}
