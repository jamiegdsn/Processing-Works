class Line {
  PVector p1, p2;         // 座標1, 2
  PVector s;              // 線の始点
  float angle;            // 角度
  float radius;           // 半径
  int hue;                // 色相

  Noise sxNoise, syNoise; // sのノイズ
  Noise angleNoise;       // thetaとphiのノイズ
  Noise radiusNoise;      // 半径のノイズ

  Line() {
    p1 = new PVector();
    p2 = new PVector();
    s = new PVector();
    hue = int(random(360));

    sxNoise = new Noise(random(100), 0.001).setRange(-40, 40);
    syNoise = new Noise(random(100), 0.001).setRange(-40, 40);
    angleNoise = new Noise(random(100), 0.0001).setRange(-TWO_PI, TWO_PI);
    radiusNoise = new Noise(random(100), 0.0003).setRange(50, height);
  }

  // 更新を行うメソッド
  void update() {
    // ノイズで始点を変動させる
    s.x = sxNoise.update().getValue();
    s.y = syNoise.update().getValue();

    // noise()で角度を変動させる
    angle = angleNoise.update().getValue();

    radius = radiusNoise.update().getValue();

    // 球体の面上にある座標の計算
    p1.x = radius * cos(angle);
    p1.y = radius * sin(angle);
    p2.x = - p1.x;
    p2.y = - p1.y;
  }

  // 描画を行うメソッド
  void render() {
    stroke(hue, 80, 4, 16);
    strokeWeight(1);
    line(s.x, s.y, p1.x, p1.y);
    line(s.x, s.y, p2.x, p2.y);

    stroke(0, 0, 100, 6);
    strokeWeight(1);
    point(p1.x, p1.y);
    point(p2.x, p2.y);
  }
}
