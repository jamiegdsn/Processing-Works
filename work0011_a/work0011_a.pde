float updateCount = 0;
float outerRectSize, innerRectSize;

color[] palette = new color[3];
int pi = 0;

void setup() {
  size(1024, 1024, P2D);
  pixelDensity(displayDensity());
  smooth(8);
  colorMode(HSB, 360, 100, 100, 100);
  rectMode(CENTER);
  noiseDetail(8, 0.6);
  palette[0] = color(185, 80, 30);
  palette[1] = color(205, 80, 30);
  palette[2] = color(335, 80, 30);
  reset();
}

void reset() {
  outerRectSize = width * 0.8;
  innerRectSize = width * 0.45;
  updateCount = 0;
  background(hue(palette[pi]), 3, 98);
  noiseSeed(millis());
}

void draw() {
  translate(width/2, height/2);

  noFill();
  stroke(palette[pi]);
  strokeWeight(6);
  rect(0, 0, outerRectSize, outerRectSize);

  noStroke();
  fill(palette[pi]);
  rect(0, 0, innerRectSize, innerRectSize);

  noFill();
  strokeWeight(0.5);
  for (int j = 0; j < 10; j++) {

  for (int i = 0; i < innerRectSize * 2; i++) {
    float n = noise(i * 0.01, updateCount * 0.0005);
    float alpha = 200 - updateCount * pow(n, 2.2);

    float x = innerRectSize/2 + updateCount * 0.1;
    float y = -innerRectSize/2 + i * 0.5;
    stroke(palette[pi], alpha);
    strokeWeight(0.5);
    point(x, y);
  }
  updateCount++;

  }
}

void keyPressed() {
  if (key == 's') {
    saveFrame("####.png");
  }
  if (key == 'r') {
    reset();
  }
}
