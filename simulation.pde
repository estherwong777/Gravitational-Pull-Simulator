Mover[] m = new Mover[10];
ArrayList<Attractor> a;
color[] colors = {color(255, 105, 180), 
                  color(255, 204, 0), 
                  color(51, 171, 249)};

void setup() {
 size(750, 750);
 a = new ArrayList<Attractor>();
 for (int i = 0; i < 10; i++) {
   m[i] = new Mover(random(1, 7), random(width), random(height), colors[i % colors.length]);
 }
}

void draw() {
  background(0);
  
  for (Mover mover : m) {
    PVector f = new PVector(0.0, 0.0);
    
    for (int i = 0; i < a.size(); i++) {
      f.add(a.get(i).attract(mover));
      a.get(i).display();
    }
    
    mover.applyForce(f);
    mover.update();
    mover.display();
  }
}

void mouseClicked() {
  a.add(new Attractor(mouseX, mouseY));
}
