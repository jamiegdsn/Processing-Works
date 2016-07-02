float tStep = 0;
float tStepVelocity = 0.05;

void setup() {
  size(1280, 720, P3D);
  colorMode(HSB, 360, 100, 100, 100);
  pixelDensity(displayDensity());
}

void draw() {
  background(210, 80, 5);
  translate(width/2, height/2, 0);
  rotateX(frameCount * 0.01);
  rotateY(frameCount * 0.01);

  float px = 0, py = 0, pz = 0;
  float radius = height * 0.4;
  boolean firstLoop = true;

  for (float s = 0, t = 0; s <= 180; s++, t+=tStep) {
    float theta = radians(s);
    float phi = radians(t);

    float x = radius * sin(theta) * cos(phi);
    float y = radius * sin(theta) * sin(phi);
    float z = radius * cos(theta);

    stroke(210, 80, 80);
    if (!firstLoop) {
      strokeWeight(1);
      line(x, y, z, px, py, pz);
    } else firstLoop = false;

    strokeWeight(10);
    point(x, y, z);

    px = x;
    py = y;
    pz = z;
  }
  tStep += tStepVelocity;
}
