int numLines = 8; // Lineオブジェクトの数
Line[] lines = new Line[numLines]; // Lineオブジェクト配列

void setup() {
  fullScreen(P3D);
  // RetinaとかのHigh-Resディスプレイ用の処理
  pixelDensity(displayDensity());
  // HSBカラーモード
  colorMode(HSB, 360, 100, 100, 100);
  // 加算合成で発光してるっぽくみせる
  blendMode(ADD);
  // zテストを無効化
  hint(DISABLE_DEPTH_TEST);
  initWindow();
}

void initWindow() {
  background(0, 0, 0);
  for (int i = 0; i < numLines; i++) {
    lines[i] = new Line();
  }
}

void draw() {
  translate(width/2, height/2, 0);

  // 線の描画と更新
  for (int i = 0; i < numLines; i++) {
    // このfor文の繰り返し数を増やすと描画が早くなる
    // さっさと壁紙作りたいとき便利
    for (int j = 0; j < 1; j++) {
      lines[i].update();
      lines[i].display();
    }
  }
}

void keyPressed() {
  if (key == 's') {
    saveFrame("frames/frame-####.png");
  } else if (key == 'r') {
    initWindow();
  }
}

class Line {
  PVector p1, p2;                  // 座標1, 2
  PVector s;                       // 線の始点
  Noise sxNoise, syNoise, szNoise; // sのノイズ
  float theta, phi;                // 球体の計算用の角度
  Noise thetaNoise, phiNoise;      // thetaとphiのノイズ
  float radius;                    // 半径
  int hue;                         // 色相

  Line() {
    p1 = new PVector();
    p2 = new PVector();
    s = new PVector();

    sxNoise = new Noise(random(10), 0.01).setRange(-50, 50);
    syNoise = new Noise(random(10), 0.01).setRange(-50, 50);
    szNoise = new Noise(random(10), 0.01).setRange(-50, 50);

    thetaNoise = new Noise(random(10), 0.0015).setRange(-TWO_PI, TWO_PI);
    phiNoise   = new Noise(random(10), 0.0015).setRange(-TWO_PI, TWO_PI);

    hue = int(random(360));
    radius = height * 0.45;
  }

  // 更新を行うメソッド
  void update() {
    // ノイズで始点を変動させる
    s.x = sxNoise.update().getValue();
    s.y = syNoise.update().getValue();
    s.z = szNoise.update().getValue();

    // noise()で角度を変動させる
    theta = thetaNoise.update().getValue();
    phi = phiNoise.update().getValue();

    // 球体の面上にある座標の計算
    p1.x = radius * sin(theta) * cos(phi);
    p1.y = radius * sin(theta) * sin(phi);
    p1.z = radius * cos(theta);
    p2.x = - p1.x;
    p2.y = - p1.y;
    p2.z = - p1.z;
  }

  // 描画を行うメソッド
  void display() {
    stroke(hue, 80, 6, 30);
    strokeWeight(1);
    line(s.x, s.y, s.z, p1.x, p1.y, p1.z);
    line(s.x, s.y, s.z, p2.x, p2.y, p2.z);

    stroke(0, 0, 100, 10);
    strokeWeight(1);
    point(p1.x, p1.y, p1.z);
    point(p2.x, p2.y, p2.z);
  }
}
