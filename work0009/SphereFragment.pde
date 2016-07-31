class SphereFragment {
  ArrayList<Point> points = new ArrayList<Point>();
  int numPoints;
  float lengthLimit;
  float rotSpeed;
  float minRadius, maxRadius;

  SphereFragment(float startTheta, float endTheta, float startPhi, float endPhi) {
    minRadius = height * 0.1;
    maxRadius = height * 0.4;
    float radius = random(minRadius, maxRadius);

    float defaultThetaStep = radians(4);
    float thetaStep;
    float phiStep;

    for (float theta = startTheta; theta <= endTheta; theta += thetaStep) {
      for (float phi = startPhi; phi <= endPhi; phi += phiStep) {
        float unitX = sin(theta) * cos(phi);
        float unitY = cos(theta);
        float unitZ = sin(theta) * sin(phi);
        points.add(new Point(unitX, unitY, unitZ, radius));

        float rate = (1.0 - sin(theta)) * map(radius, minRadius, maxRadius, 1, 0);
        phiStep = radians(3) + radians(15) * rate;
        phiStep *= random(0.75, 1.25);
      }
      thetaStep = defaultThetaStep * random(0.75, 1.25);
    }

    float maxXZDist = -1, minXZDist = 10000;
    for (Point p : points) {
      maxXZDist = max(maxXZDist, p.xzDistance);
      minXZDist = min(minXZDist, p.xzDistance);
    }
    lengthLimit = map((minXZDist+maxXZDist)/2, 0, maxRadius, 0, height * 0.1);
    numPoints = points.size();
    rotSpeed = random(-0.01, 0.01);

    for (int i = 0; i < numPoints; i++) {
      Point fromP = points.get(i);
      for (int j = i + 1; j < numPoints; j++) {
        Point toP = points.get(j);
        float distance = dist(fromP.x, fromP.y, fromP.z, toP.x, toP.y, toP.z);
        if (distance <= lengthLimit) {
          fromP.addNearPoint(toP);
        }
      }
    }
  }

  void update() {
    for (Point p : points) {
      p.update();
    }

    if (random(100) < 0.3) {
      float targetRadius = random(minRadius, maxRadius);
      for (Point p : points) {
        p.setTargetRadius(targetRadius);
      }
    }
  }

  void display() {
    pushMatrix();
    rotateY(frameCount * rotSpeed);
    for (Point p : points) {
      p.display();
    }
    popMatrix();
  }
}
