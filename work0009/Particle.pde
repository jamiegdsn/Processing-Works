class Particle {
  PVector p;
  PVector prevP;
  float speed;
  color strokeColor;

  Particle() {
    p = new PVector();
    p.x = random(width);
    p.y = random(height);
    prevP = new PVector(p.x, p.y);
    speed = 1;
    if (THEME == 0) strokeColor = color(hue, 10, random(30, 100), 10);
    else if (THEME == 1) strokeColor = color(hue, random(20, 80), 60, 20);
  }

  void update() {
    float angle = 6 * pattern3(PVector.mult(p, 0.002));
    float vx = speed * cos(angle);
    float vy = speed * sin(angle);
    p.x += vx;
    p.y += vy;
  }

  float noise2D(PVector p) {
    return noise(p.x, p.y);
  }

  float pattern1(PVector p) {
    return noise2D(p);
  }

  float pattern2(PVector p) {
    PVector q = new PVector( noise2D(p), noise2D(PVector.add(p, new PVector(5.2, 1.3))) );
    return noise2D( p.add(q.mult(4)) );
  }

  float pattern3(PVector p) {
    PVector q = new PVector( noise2D(p),
                             noise2D(PVector.add(p, new PVector(5.2, 1.3))) );
  
    PVector p4q = PVector.add(p, PVector.mult(q, 4));
    PVector r = new PVector( noise2D(PVector.add(p4q, new PVector(1.7, 9.2))),
                             noise2D(PVector.add(p4q, new PVector(8.3, 2.8))) );
  
    return noise2D( p.add(r.mult(4)) );
  }

  void addVertex() {
    stroke(strokeColor);
    vertex(prevP.x, prevP.y);
    vertex(p.x, p.y);
    
    prevP.set(p);
  }
}