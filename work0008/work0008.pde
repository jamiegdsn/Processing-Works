int hue = 215, sat = 5, bri = 80;

void setup() {
  size(2048, 1024, P2D);
  pixelDensity(displayDensity());
  smooth(16);
  colorMode(HSB, 360, 100, 100, 100);
  rectMode(CENTER);
  noLoop();
}

void draw() {
  background(hue, sat, bri);
  
  float size = height * 0.8;
  pushMatrix();
  translate(width/2 - size/2, height/2);
  branch(size);
  popMatrix();
  pushMatrix();
  translate(width/2 + size/2, height/2);
  branch(size);
  popMatrix();
}

void branch(float size) {
  strokeWeight(0.5);
  stroke(hue, sat, bri);
  if (random(1) < 0.2) fill(hue, sat, bri);
  else fill(hue, sat, 5);
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