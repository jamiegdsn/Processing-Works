PImage img; // 光る球体の画像

float phiStep = 0; // 角度phiの間隔
float phiStepVelocity = 0.05; // phiStepの更新間隔

void setup() {
  size(1280, 720, P3D);
  pixelDensity(displayDensity());
  colorMode(HSB, 360, 100, 100, 100);
  // zテストを無効化
  hint(DISABLE_DEPTH_TEST);
  // 加算合成
  blendMode(ADD);
  imageMode(CENTER);
  // 画像の生成
  img = createLight(200);
}

// 光る球体の画像を生成する関数
PImage createLight(float hue) {
  int side = 80; // 1辺の大きさ
  float center = side / 2.0; // 中心座標

  // 画像を生成
  PImage img = createImage(side, side, RGB);

  // 画像の一つ一つのピクセルの色を設定する
  for (int y = 0; y < side; y++) {
    for (int x = 0; x < side; x++) {
      // 中心との距離計算
      float d = dist(x, y, center, center) / side;
      // 光の強さを計算
      float light = constrain(0.1 / d, 0, 1);
      light = pow(light, 3.0);
      float h = hue;
      float s = 100 * (1.0-light);
      float b = 100 * light;
      // ピクセルの色を設定
      img.pixels[x + y * side] = color(h, s, b);
    }
  }
  return img;
}

void draw() {
  background(200, 80, 8);
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

    // 2ループ目以降なら線を描画
    if (!firstLoop) {
      stroke(0, 0, 100);
      strokeWeight(1);
      line(x, y, z, px, py, pz);
    } else firstLoop = false;

    pushMatrix();
    // 画像の座標へ原点を移動
    translate(x, y, z);
    // 画像の向きを元に戻す
    rotateY(-frameCount*0.01);
    rotateX(-frameCount*0.01);
    // 画像を描画
    image(img, 0, 0);
    popMatrix();

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
    saveFrame("frame-####.png");
  }
}
