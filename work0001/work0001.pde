float phiStep = 0; // 角度phiの間隔
float phiStepVelocity = 0.05; // phiStepの更新間隔

void setup() {
  size(1280, 720, P3D);
  colorMode(HSB, 360, 100, 100, 100);
  pixelDensity(displayDensity());
}

void draw() {
  background(0, 0, 8);
  translate(width/2, height/2, 0);
  rotateX(frameCount * 0.01);
  rotateY(frameCount * 0.01);

  float px = 0, py = 0, pz = 0;  // 1つ前の座標
  float radius = height * 0.4; // 球体の半径
  boolean firstLoop = true; // ループの最初かどうか

  for (float dTheta = 0, dPhi = 0; dTheta <= 180; dTheta++, dPhi += phiStep) {
    float theta = radians(dTheta);
    float phi = radians(dPhi);

    // 球体の座標を計算
    float x = radius * sin(theta) * cos(phi);
    float y = radius * sin(theta) * sin(phi);
    float z = radius * cos(theta);

    stroke(frameCount * 0.5 % 360, 80, 80);
    // 2ループ目以降なら線を描画
    if (!firstLoop) {
      strokeWeight(1);
      line(x, y, z, px, py, pz);
    } else firstLoop = false;

    // 点を描画
    strokeWeight(15);
    point(x, y, z);

    // 1つ前の座標を更新
    px = x;
    py = y;
    pz = z;
  }
  // phiStepを更新
  phiStep += phiStepVelocity;
}

void keyPressed() {
  if (key == 's') {
    saveFrame("frames/frame-####.png");
  }
}
