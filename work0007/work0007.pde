float updateCount = 0;
float outerRectSize, innerRectSize;

color[] palette = new color[2];
int THEME = 1;

void setup() {
  size(1024, 1024, P2D);
  pixelDensity(displayDensity());
  smooth(16);
  colorMode(HSB, 360, 100, 100, 100);
  rectMode(CENTER);
  noiseDetail(8, 0.5);
  palette[0] = color(210, 15, 90);
  palette[1] = color(210, 80, 30);
  reset();
}

void reset() {
  outerRectSize = width * 0.9;
  innerRectSize = width * 0.48;
  updateCount = 0;
  if (THEME == 0) {
    background(hue(palette[THEME]), 98, 5);
  } else if (THEME == 1) {
    background(hue(palette[THEME]), 5, 98);
  }
  noiseSeed(millis());
}

void draw() {
  translate(width/2, height/2);

  noFill();
  stroke(palette[THEME]);
  strokeWeight(2);
  rect(0, 0, outerRectSize, outerRectSize);

  noStroke();
  fill(palette[THEME]);
  rect(-30, 0, innerRectSize, innerRectSize);

  noFill();
  strokeWeight(0.5);
  for (int j = 0; j < 10; j++) {
    for (int i = 0; i < innerRectSize * 2; i++) {
      float n = noise(i * 0.01, updateCount * 0.0005);
      float alpha = 200 - updateCount * pow(n, 2.2);

      float x = innerRectSize/2 + updateCount * 0.1 -30;
      float y = -innerRectSize/2 + i * 0.5 + 0.5;
      stroke(palette[THEME], alpha);
      strokeWeight(0.5);
      point(x, y);
    }
    updateCount++;
  }
}

void keyPressed() {
  if (key == 's') {
    saveFrame("frames/####.png");
  }
  if (key == 'r') {
    reset();
  }
}