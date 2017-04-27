ArrayList<Particle> particles = new ArrayList<Particle>(); // パーティクルの配列
ArrayList<ForceField> fields = new ArrayList<ForceField>(); // 力場の配列
boolean debug = false; // trueにすると力場が見える

int numParticles; // パーティクルの数
int numFields; // 力場の数

int hue1;
int hue2;

void setup() {
  size(2048, 1024, P3D);
  pixelDensity(displayDensity());
  colorMode(HSB, 360, 100, 100, 100);
  background(0, 0, 98);
  strokeWeight(0.5);
  strokeCap(SQUARE);
  initParticles();
  initFields();
}

// パーティクルの初期化
void initParticles() {
  hue1 = (int)random(360);
  hue2 = (int)random(360);
  particles.clear();
  numParticles = 3000; // 数はウィンドウサイズに合わせて調節
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
  }

  beginShape(LINES);
  for (int i = 0; i < numParticles; i++) {
    Particle fromP = particles.get(i);
    for (int j = i + 1; j < numParticles; j++) {
      Particle toP = particles.get(j);
      float d = PVector.dist(fromP.position, toP.position);
      if (d < 30) {
        stroke(fromP.c);
        fromP.addVertex();
        toP.addVertex();
      }
    }
  }
  endShape();
}

void keyPressed() {
  if (key == 'r') {
    background(0, 0, 98);
    initParticles();
    initFields();
  }
  if (key == 's') {
    saveFrame("frames/####.png");
  }
}

// パーティクルのクラス
class Particle {
  PVector position; // 位置
  PVector velocity; // 速度
  PVector acceleration; // 加速度
  PVector gravity; // 重力
  color c; // 色

  Particle(float x, float y) {
    position = new PVector(x, y);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
    gravity = new PVector(0, random(0.05, 0.1));
    int r = (int)random(100);
    if (r < 80) {
      c = color(hue1, random(30, 50), random(30, 60), 5);
    } else {
      c = color(hue2, random(30, 50), random(30, 60), 5);
    }
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

  void addVertex() {
    vertex(position.x, position.y);
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
    strength = random(0.1);
  }

  void display() {
    noFill();
    stroke(0, 0, 100);
    ellipse(position.x, position.y, radius * 2, radius * 2);
  }
}
