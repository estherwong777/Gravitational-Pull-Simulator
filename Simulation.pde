import controlP5.*;

ControlP5 cp5;
int AttractorMass = 20;
int moverMass = 1;
boolean attractorOn;
boolean moverOn;
int startTime;
boolean showTrail = false;
boolean paused = false;

ArrayList<Mover> m;
ArrayList<Attractor> a;
color[] colors = {color(255, 105, 180), 
                  color(255, 204, 0), 
                  color(51, 171, 249)};

void setup() {
  startTime = millis();
  size(1000, 750);
  cp5 = new ControlP5(this);
  moverOn = false;
  attractorOn = false;
 
  cp5.addSlider("AttractorMass")
     .setPosition(60, 60)
     .setRange(1, 50)
     .setSize(120, 20)
     .setLabel(" Attractor Mass (KG) ");
     
  cp5.addSlider("moverMass")
     .setPosition(60, 30)
     .setRange(0, 3)
     .setSize(120, 20)
     .setLabel(" Avg Mover Mass ");
     
  cp5.addTextfield("avgVelocity")
     .setPosition(60, 150)
     .setSize(120, 20)
     .setText("  0.0")
     .setLabel("Avg velocity of movers (m/s)");
    
  cp5.addButton("attractor")
     .setValue(0)
     .setPosition(60, 90)
     .setSize(60,50)
     .setLabel("ADD \nATTRACTOR");
    
  cp5.addButton("mover")
    .setValue(0)
    .setPosition(130, 90)
    .setSize(50,50)
    .setLabel("ADD \nMOVER");
    
  cp5.addToggle("showTrail")
     .setValue(false)
     .setPosition(60, 190)
     .setSize(40, 20)
     .setLabel("SHOW TRAILS")
     .setMode(ControlP5.SWITCH);
  
  cp5.addToggle("paused")
     .setValue(false)
     .setPosition(140, 190)
     .setSize(30, 20)
     .setLabel("PAUSE");  
     
  cp5.addButton("restart")
    .setValue(0)
    .setPosition(60, 230)
    .setSize(120,25)
    .setLabel("RESTART");
     
  a = new ArrayList<Attractor>();
  m = new ArrayList<Mover>();
  for (int i = 0; i < 5; i++) {
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
    }
    if (!paused) {
      updateAvgVelocity();
      mover.applyForce(f);
      mover.update();
    }
    mover.display();
    mover.setTrail(showTrail);
  }
  
  for (Attractor attr : a) {
    attr.display();
  }
}

void updateAvgVelocity() {
  PVector sum = new PVector(0.0, 0.0);
  for (Mover mover : m) {
    sum.add(mover.getVelocity());
  }
  if (m.size() > 0) {
    cp5.get(Textfield.class, "avgVelocity").setText("  " + sum.mag() / m.size());
  } else {
    cp5.get(Textfield.class, "avgVelocity").setText("  " + 0.0);
  }
}

void updateSliders() {
  for (Attractor attr : a) {
    attr.setMass(AttractorMass);
    println(AttractorMass);
  }
  
  for (Mover mover : m) {
    mover.scaleMass(moverMass);
  }
}

public void mover() {
  if (millis() - startTime < 1000) {
    //check to prevent button from being pressed when program starts
    return;
  }
  attractorOn = false;
  moverOn = true;
}

public void attractor() {
  if (millis() - startTime < 1000) {
    return;
  }
  attractorOn = true;
  moverOn = false;
}

public void restart() {
  m.clear();
  a.clear();
  updateAvgVelocity();
}

void mouseClicked() {
  if (!mouseOnButtons()) {
    if (attractorOn) {
      a.add(new Attractor(mouseX, mouseY));
    } else if (moverOn) {
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
}

boolean mouseOnPauseButton() {
  return mouseX > 140 && mouseX < 170 && mouseY > 190 && mouseY < 210;
}

boolean mouseOnTrailToggle() {
  return mouseX > 60 && mouseX < 100 && mouseY > 190 && mouseY < 210;
}

boolean mouseOnAttractorMoverButton() {
  return mouseX > 60 && mouseX < 180 && mouseY > 90 && mouseY < 140;
}

boolean mouseOnRestartButton() {
  return mouseX > 60 && mouseX < 180 && mouseY > 230 && mouseY < 265;
}

boolean mouseOnButtons() {
  return mouseOnPauseButton() || mouseOnTrailToggle() || mouseOnAttractorMoverButton() || 
         mouseOnRestartButton();
}
