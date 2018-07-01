Mover[] m = new Mover[10];
Attractor a;

void setup() {
 size(750, 750);
 a = new Attractor();
 for (int i = 0; i < 10; i++) {
   m[i] = new Mover(random(1, 6), random(width), random(height));
 }
}

void draw() {
  background(0);
  
  for (Mover mover : m) {
    PVector f = a.attract(mover);
    mover.applyForce(f);
    mover.update();

    a.display();
    mover.display();
  }
}
