class Mover {
  float mass;
  PVector location;
  PVector velocity;
  PVector acceleration;
  float c = 0.47;
  color clr;
  
  public Mover(float m, float x, float y, color clr) {
    location = new PVector(x, y);
    mass = m;
    velocity = new PVector(0,0);
    acceleration = new PVector(0,0);
    this.clr = clr;
  }
  
  void setVelocity(PVector v) {
    velocity = v;
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
  }
  
  void display() {
    stroke(1000);
    fill(clr);
    ellipse(location.x, location.y, mass * 4, mass * 4);
  }
 
}
