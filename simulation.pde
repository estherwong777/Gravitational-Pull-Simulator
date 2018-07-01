import controlP5.*;

ControlP5 cp5;
int AttractorMass = 20;
boolean attractorOn = false;
boolean moverOn = false;

ArrayList<Mover> m;
ArrayList<Attractor> a;
color[] colors = {color(255, 105, 180), 
                  color(255, 204, 0), 
                  color(51, 171, 249)};

void setup() {
 size(750, 750);
 cp5 = new ControlP5(this);
 
 cp5.addSlider("AttractorMass")
    .setPosition(60, 60)
    .setRange(1, 50)
    .setSize(100, 20)
    .setLabel(" Attractor Mass");
    
 cp5.addButton("attractor")
    .setValue(0)
    .setPosition(60, 90)
    .setSize(50,50)
    .setColorActive(342);
    
  cp5.addButton("mover")
    .setValue(0)
    .setPosition(120, 90)
    .setSize(50,50)
    .setColorActive(1000);
    
 a = new ArrayList<Attractor>();
 m = new ArrayList<Mover>();
 for (int i = 0; i < 10; i++) {
   m.add(new Mover(random(1, 7), random(width), random(height), 
   colors[i % colors.length]));
 }

}

void draw() {
  background(0);
  updateSliders();
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

void updateSliders() {
  for (Attractor attr : a) {
    attr.setMass(AttractorMass);
  }
}

public void attractor() {
  attractorOn = true;
  moverOn = false;
}

public void mover() {
  attractorOn = false;
  moverOn = true;
}

void mouseClicked() {
  if (attractorOn) {
    if (mouseX > 170 || mouseY > 150) {
      a.add(new Attractor(mouseX, mouseY));
    }
  } else {
    Mover m1 = new Mover(random(1, 3), mouseX, mouseY, colors[0]);
    Mover m2 = new Mover(random(3, 5), mouseX, mouseY, colors[1]);
    Mover m3 = new Mover(random(5, 7), mouseX, mouseY, colors[2]);
    
    m1.setVelocity(new PVector(3,0));
    m2.setVelocity(new PVector(-3,0));
    m3.setVelocity(new PVector(0,-3));
    
    m.add(m1);
    m.add(m2);
    m.add(m3);
  }
}
