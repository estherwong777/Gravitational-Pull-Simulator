class Mover {
  float mass;
  float originalMass;
  PVector location;
  PVector velocity;
  PVector acceleration;
  float c = 0.47;
  color clr;
  ArrayList<PVector> history;
  int TRAIL_LENGTH = 35;
  final int TRANSPARENCY = 70;
  final int DISPLAY_SCALE = 4;
  boolean trailOn;
  
  public Mover(float m, float x, float y, color clr) {
    location = new PVector(x, y);
    velocity = new PVector(0,0);
    acceleration = new PVector(0,0);
    history = new ArrayList<PVector>();
    mass = m;
    originalMass = m;
    this.clr = clr;
    trailOn = false;
  }
  
  void move(float x, float y) {
    location.x += x;
    location.y += y;
  }
  
  void setVelocity(PVector v) {
    velocity = v;
  }
  
  void setTrail(boolean b) {
    trailOn = b;
  }
  
  void scaleMass(float m) {
    mass = m + originalMass;
  }
  
  PVector getVelocity() {
    return velocity;
  }
  
  void applyForce(PVector force) {
    PVector a = PVector.div(force, mass);
    acceleration.add(a);
  }
  
  void drag() {
    //drag size force formula : C * v^2
    float dragSize = velocity.mag() * velocity.mag() * c; 
    PVector drag = velocity;
    drag.mult(-1);
    drag.normalize();
    drag.mult(dragSize);
    applyForce(drag);
  }
  
  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    acceleration.mult(0);
    history.add(new PVector(location.x, location.y));
    if (history.size() > TRAIL_LENGTH) {
      history.remove(0);
    }
  }
  
  void display() {
    stroke(1000);
    fill(clr);
    ellipse(location.x, location.y, mass * DISPLAY_SCALE, mass * DISPLAY_SCALE);
    if (trailOn) {
      displayTrail(); 
    }
  }
  
  void displayTrail() {
    for (PVector v : history) {
      fill(clr, TRANSPARENCY);
      ellipse(v.x, v.y, mass * DISPLAY_SCALE, mass * DISPLAY_SCALE);
    }
  }
 
}
