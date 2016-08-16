ArrayList<Particle> particles = new ArrayList<Particle>(); // パーティクルの配列
ArrayList<ForceField> fields = new ArrayList<ForceField>(); // 力場の配列
boolean debug = false; // trueにすると力場が見える

int numParticles; // パーティクルの数
int numFields; // 力場の数

void setup() {
  fullScreen(P2D);
  pixelDensity(displayDensity());
  colorMode(HSB, 360, 100, 100, 100);
  blendMode(SCREEN);
  background(0, 0, 3);
  strokeWeight(0.5);
  strokeCap(SQUARE);
  initParticles();
  initFields();
}

// パーティクルの初期化
void initParticles() {
  particles.clear();
  numParticles = 20000; // 数はウィンドウサイズに合わせて調節
  for (int i = 0; i < numParticles; i++) {
    float posX = random(width);
    particles.add(new Particle(posX, 0));
  }
}

// 力場の初期化
void initFields() {
  fields.clear();
  numFields = 100; // 数はウィンドウサイズに合わせて調節
  for (int i = 0; i < numFields; i++) {
    float posX = random(width);
    float posY = random(200, height-100);
    // 引力か斥力かをランダムに決定
    int type = random(-1, 1) > 0 ? 1 : -1;
    fields.add(new ForceField(posX, posY, type));
  }

  if (debug) {
    for (ForceField f : fields) {
      f.display();
    }
  }
}

void draw() {
  for (Particle p : particles) {
    p.update(fields);
    p.display();
  }
}

void keyPressed() {
  if (key == 'r') {
    background(0, 0, 3);
    initParticles();
    initFields();
  }
  if (key == 's') {
    saveFrame("images/frame-####.png");
  }
}

// パーティクルのクラス
class Particle {
  PVector position; // 位置
  PVector pPosition; // 1フレーム前の位置
  PVector velocity; // 速度
  PVector acceleration; // 加速度
  PVector gravity; // 重力
  color c; // 色

  Particle(float x, float y) {
    position = new PVector(x, y);
    pPosition = new PVector(x, y);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
    gravity = new PVector(0, random(0.05, 0.1));
    c = color(random(180, 230), random(60, 80), random(15));
  }

  void update(ArrayList<ForceField> fields) {
    for (ForceField f : fields) {
      PVector force = PVector.sub(f.position, position);
      float dist = force.mag();
      if (dist <= f.radius) {
        force.normalize().mult(f.forceType * f.strength);
        acceleration.add(force);
      }
    }
    acceleration.add(gravity);
    velocity.add(acceleration);
    position.add(velocity);
    acceleration.mult(0);
    velocity.mult(0.98);
  }

  void display() {
    stroke(c);
    line(pPosition.x, pPosition.y, position.x, position.y);
    pPosition = position.copy();
  }
}

// 力場のクラス
class ForceField {
  PVector position;
  float radius;
  int forceType;
  float strength;

  ForceField(float x, float y, int type) {
    position = new PVector(x, y);
    radius = random(40, 80);
    forceType = type;
    strength = random(0.2);
  }

  void display() {
    noFill();
    stroke(0, 0, 100);
    ellipse(position.x, position.y, radius * 2, radius * 2);
  }
}
