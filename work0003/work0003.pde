int numPoints = 1500; // 点の数 ウィンドウサイズで調整してくれ
int numSpheres = 3;   // 球体の数
int lengthLimit = 80; // 距離制限 ウィンドウサイズで調整してくれ

Point[] points;
Sphere[] spheres;

void setup() {
  fullScreen(P3D);
  pixelDensity(displayDensity());
  strokeWeight(0.5);
  initObjects();
}

void initObjects() {
  // 球体を作る
  spheres = new Sphere[numSpheres];
  for (int i = 0; i < numSpheres; i++) {
    spheres[i] = new Sphere();
  }
  // 点を作る
  points = new Point[numPoints];
  for (int i = 0; i < numPoints; i++) {
    points[i] = new Point();
  }
}

void draw() {
  background(255);

  translate(width/2, height/2, 0);
  rotateY(frameCount * 0.01);

  // 更新
  for (int i = 0; i < spheres.length; i++) {
    spheres[i].update();
  }
  for (int i = 0; i < points.length; i++) {
    points[i].update();
  }

  // 全ての点に対して、他の全ての点との距離を計算し
  // lengthLimit以下ならその２点間に線を引く
  for (int i = 0; i < points.length; i++) {
    Point fromP = points[i];
    stroke(fromP.gray);
    for (int j = i + 1; j < points.length; j++) {
      Point toP = points[j];
      float dist = dist(fromP.x, fromP.y, fromP.z, toP.x, toP.y, toP.z);
      if (dist < lengthLimit) {
        line(fromP.x, fromP.y, fromP.z, toP.x, toP.y, toP.z);
      }
    }
  }
}

void keyPressed() {
  if (key == 's') {
    saveFrame("frame.jpg");
  }
  if (key == 'r') {
    initObjects();
  }
}

// 球体クラス
class Sphere {
  float radius;   // 半径
  float radNoise; // 半径を変化させるノイズ
  float speed;

  Sphere() {
    radNoise = random(10);
    speed = 0.006;
  }
  // 半径の大きさを更新
  void update() {
    radius = 50 + noise(radNoise) * height * 0.4;
    radNoise += speed;
  }
}

// 点クラス
class Point {
  float x, y, z;   // 点の座標
  float a, b, c;   // 値の保管用
  Sphere mySphere; // 球体の半径を参照する
  color gray;

  Point() {
    // 球体上の座標を計算
    float radianT = radians(random(360));
    float unitZ = random(-1, 1);
    a = sqrt(1 - unitZ * unitZ) * cos(radianT);
    b = sqrt(1 - unitZ * unitZ) * sin(radianT);
    c = unitZ;
    // 参照する球体をランダムに設定
    mySphere = spheres[int(random(numSpheres))];
    gray = color(random(100), random(255));
  }

  // 点の座標を更新
  void update() {
    x = mySphere.radius * a;
    y = mySphere.radius * b;
    z = mySphere.radius * c;
  }
}
