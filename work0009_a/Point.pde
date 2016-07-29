class Point {
  float x, y, z;
  float unitX, unitY, unitZ;
  float radius, targetRadius;
  float xzDistance;
  color c;
  int startTime, delay;

  ArrayList<Point> nearPoints = new ArrayList<Point>();

  Point(float unitX, float unitY, float unitZ, float radius) {
    this.unitX = unitX;
    this.unitY = unitY;
    this.unitZ = unitZ;
    this.radius = radius;
    targetRadius = radius;
    xzDistance = dist(0, 0, radius * unitX, radius * unitZ);
    c = color(random(180, 220), random(60, 80), random(20));
    startTime = millis();
    delay = (int)random(300);
    calcCordinate();
  }

  void addNearPoint(Point p) {
    nearPoints.add(p);
  }

  void setTargetRadius(float targetRadius) {
    this.targetRadius = targetRadius;
    startTime = millis();
  }

  void update() {
    if (millis() - startTime > delay) {
      radius += (targetRadius - radius) * 0.08;
    }
    calcCordinate();
  }

  void calcCordinate() {
    x = radius * unitX;
    y = radius * unitY;
    z = radius * unitZ;
  }

  void display() {
    strokeWeight(1);
    noFill();
    beginShape(LINES);
    for (Point np : nearPoints) {
      stroke(c);
      vertex(x, y, z);
      stroke(np.c);
      vertex(np.x, np.y, np.z);
    }
    endShape();
  }
}
