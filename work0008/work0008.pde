int hue = 215, sat = 10, bri = 60;

void setup() {
  size(1000, 1000, P2D);
  pixelDensity(displayDensity());
  smooth(8);
  colorMode(HSB, 360, 100, 100, 100);
  rectMode(CENTER);
  noLoop();
}

void draw() {
  background(hue, sat, bri);
  translate(width/2, height/2);
  branch(width * 0.8);
  saveFrame("frames/####.png");
}

void branch(float size) {
  strokeWeight(0.5);
  stroke(hue, sat, bri);
  if (random(1) < 0.2) fill(hue, sat, bri);
  else fill(hue, sat, random(10));
  rect(0, 0, size, size);

  float P = map(size, 5, width * 0.8, 0.5, 1);
  float scale = map(size, 5, width * 0.8, 0.9, 1);
  size *= 0.5;
  boolean flag = false;
  if (size > 5) {
    if (random(1) < P) {
      pushMatrix();
      translate(-size/2, -size/2);
      scale(scale);
      branch(size);
      popMatrix();
      flag = true;
    }
    if (random(1) < P) {
      pushMatrix();
      translate(size/2, -size/2);
      scale(scale);
      branch(size);
      popMatrix();
      flag = true;
    }
    if (random(1) < P) {
      pushMatrix();
      translate(-size/2, size/2);
      scale(scale);
      branch(size);
      popMatrix();
      flag = true;
    }
    if (random(1) < P) {
      pushMatrix();
      translate(size/2, size/2);
      scale(scale);
      branch(size);
      popMatrix();
      flag = true;
    }
  }
}

void mousePressed() {
  hue = (int)random(360);
  redraw();
}
