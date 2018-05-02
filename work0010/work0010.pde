int space = 10;
int rows, cols;

float sat = 90;
float bri = 90;
float noiseScale = 0.04;

boolean save = false;

void setup() {
  size(1000, 1000, P2D);
  pixelDensity(displayDensity());
  smooth(8);
  colorMode(HSB, 360, 100, 100, 100);
  noiseDetail(8, 0.5);
  rectMode(CENTER);
  noLoop();

  rows = width / space;
  cols = height / space;
}

void draw() {
  noiseSeed(millis());
  sat = random(50, 100);

  background(0, 0, 8);

  float pointHue      = random(360);
  float gradStartHue1 = random(360);
  float gradStartHue2 = random(360);
  float gradStartHue3 = random(360);
  float gradStartHue4 = random(360);
  float gradRange1 = random(20, 180);
  float gradRange2 = random(20, 180);
  float gradRange3 = random(20, 180);
  float gradRange4 = random(20, 180);

  for (int ri = 0; ri < rows; ri++) {
    for (int ci = 0; ci < cols; ci++) {
      float posX = ri * space + space/2;
      float posY = ci * space + space/2;
      float n = noise(ri * noiseScale, ci * noiseScale);
      n = pow(n, 2);
      if (n <= 0.2) {
        noStroke();
        fill(pointHue, 100, 100, 40);
        ellipse(posX, posY, 1, 1);
      } else if (n <= 0.25) {
        drawBorderdGradationRect(posX, posY, gradStartHue1, gradRange1, 0.5, 0);
      } else if (n <= 0.40) {
        drawGradationRect(posX, posY, gradStartHue2, gradRange2, 0.5, -3)
      } else if (n <= 0.50) {
        drawGradationRect(posX, posY, gradStartHue3, gradRange3, 0.5, -6);
      } else if (n <= 1.00) {
        drawGradationRect(posX, posY, gradStartHue4, gradRange4, 0.5, -9);
      }
    }
  }

  postprocess();

  if (save) {
    saveFrame("frames/frame-####.png");
  }
}

void drawGradationRect(float posX, float posY, float gradStartHue, float gradRange, float pad, float offset) {
  float progress1 = map(posY-space/2, 0, height, 0, 1);
  float progress2 = map(posY+space/2, 0, height, 0, 1);

  noStroke();
  beginShape();
  fill(gradStartHue + progress1 * gradRange, sat, bri);
  vertex(posX-space/2+pad+offset, posY-space/2+pad+offset);
  vertex(posX+space/2-pad+offset, posY-space/2+pad+offset);
  fill(gradStartHue + progress2 * gradRange, sat, bri);
  vertex(posX+space/2-pad+offset, posY+space/2-pad+offset);
  vertex(posX-space/2+pad+offset, posY+space/2-pad+offset);
  endShape(CLOSE);
}

void drawBorderdGradationRect(float posX, float posY, float gradStartHue, float gradRange, float pad, float offset) {
  float progress1 = map(posY-space/2, 0, height, 0, 1);
  float progress2 = map(posY+space/2, 0, height, 0, 1);

  drawGradationRect(posX, posY, gradStartHue, gradRange, pad, offset);

  pad += 0.5;

  beginShape();
  fill(0, 0, 8);
  vertex(posX-space/2+pad+offset, posY-space/2+pad+offset);
  vertex(posX+space/2-pad+offset, posY-space/2+pad+offset);
  vertex(posX+space/2-pad+offset, posY+space/2-pad+offset);
  vertex(posX-space/2+pad+offset, posY+space/2-pad+offset);
  endShape(CLOSE);

  pad += 2.0;

  beginShape();
  fill(gradStartHue + progress1 * gradRange, sat, bri);
  vertex(posX-space/2+pad+offset, posY-space/2+pad+offset);
  vertex(posX+space/2-pad+offset, posY-space/2+pad+offset);
  vertex(posX+space/2-pad+offset, posY+space/2-pad+offset);
  vertex(posX-space/2+pad+offset, posY+space/2-pad+offset);
  endShape(CLOSE);
}

void postprocess() {
  for (int y = 0; y < height*2; y++) {
    for (int x = 0; x < width*2; x++) {
      float bri = random(-10, 10);
      color cols = get(x, y);

      if (brightness(cols) < 20) continue;

      cols = color(hue(cols), saturation(cols), brightness(cols)+bri);
      set(x, y, cols);
    }
  }
}

void keyPressed() {
  redraw();
}
