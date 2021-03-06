int[] palette = new int[5];

void setup() {
  size(2048, 1024, P2D);
  pixelDensity(displayDensity());
  smooth(16);
  colorMode(HSB, 360, 100, 100, 100);
  noLoop();
}

void draw() {
  switchColor((int)random(palette.length));

  background(palette[(int)random(2)], 5, 98);

  float size = height * 0.8;
  pushMatrix();
  translate(width/2 - size/2, height/2);
  branch(size);
  popMatrix();
  pushMatrix();
  translate(width/2 + size/2, height/2);
  branch(size);
  popMatrix();

  saveFrame("frames/####.png");
}

void switchColor(int theme) {
  switch(theme) {
  case 0:
    palette[0] = 15;
    palette[1] = 210;
    break;
  case 1:
    palette[0] = 338;
    palette[1] = 232;
    break;
  case 2:
    palette[0] = 41;
    palette[1] = 191;
    break;
  case 3:
    palette[0] = 185;
    palette[1] = 335;
    break;
  case 4:
    palette[0] = 325;
    palette[1] = 35;
    break;
  }
}

void branch(float size) {
  if (random(1) < 0.95) {
    drawGradationRect(size);
  } else {
    drawRect(size);
  }

  float P = map(size, 5, height * 0.8, 0.4, 1);
  float scale = 1.0;
  size *= 0.5;
  if (size > 5) {
    if (random(1) < P) {
      pushMatrix();
      translate(-size/2, -size/2);
      scale(scale);
      branch(size);
      popMatrix();
    }
    if (random(1) < P) {
      pushMatrix();
      translate(size/2, -size/2);
      scale(scale);
      branch(size);
      popMatrix();
    }
    if (random(1) < P) {
      pushMatrix();
      translate(-size/2, size/2);
      scale(scale);
      branch(size);
      popMatrix();
    }
    if (random(1) < P) {
      pushMatrix();
      translate(size/2, size/2);
      scale(scale);
      branch(size);
      popMatrix();
    }
  }
}

void drawGradationRect(float size) {
  int r = (int)random(4);
  rotate(r * HALF_PI);

  int pad = 1;

  beginShape();

  strokeWeight(0.5);
  stroke(0, 0, 0, 10);
  fill(palette[0], 100, 100, 10);
  vertex(-size/2+pad, -size/2+pad);
  vertex(+size/2-pad, -size/2+pad);

  fill(palette[1], 100, 100, 10);
  vertex(+size/2-pad, +size/2-pad);
  vertex(-size/2+pad, +size/2-pad);

  endShape(CLOSE);

  if (random(1) < 0.1) {
    strokeWeight(2);
    stroke(0, 0, 0);
    beginShape(POINTS);
    vertex(-size/2+pad, -size/2+pad);
    vertex(+size/2-pad, -size/2+pad);
    vertex(+size/2-pad, +size/2-pad);
    vertex(-size/2+pad, +size/2-pad);
    endShape();
  }
}

void drawRect(float size) {
  beginShape();

  strokeWeight(0.5);
  stroke(0, 0, 0, 10);
  fill(random(1) < 0.5 ? palette[0] : palette[1], 100, 100);
  vertex(-size/2, -size/2);
  vertex(+size/2, -size/2);
  vertex(+size/2, +size/2);
  vertex(-size/2, +size/2);

  endShape(CLOSE);
}

void mousePressed() {
  redraw();
}
