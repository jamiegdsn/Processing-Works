int numLines = 4; // Lineオブジェクトの数
Line[] lines = new Line[numLines]; // Lineオブジェクト配列

void setup() {
  size(2048, 1024, P2D);
  // RetinaとかのHigh-Resディスプレイ用の処理
  pixelDensity(displayDensity());
  smooth(16);
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
  translate(width/2, height/2);

  // 線の描画と更新
  for (int i = 0; i < numLines; i++) {
    // このfor文の繰り返し数を増やすと描画が早くなる
    // さっさと壁紙作りたいとき便利
    for (int j = 0; j < 30; j++) {
      lines[i].update();
      lines[i].render();
    }
  }
}

void keyPressed() {
  if (key == 's') {
    saveFrame("frames/####.png");
  } else if (key == 'r') {
    initWindow();
  }
}
