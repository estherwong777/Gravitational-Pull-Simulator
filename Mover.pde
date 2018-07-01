class Mover {
  float mass;
  PVector location;
  PVector velocity;
  PVector acceleration;
  float c = 0.47;
  
  public Mover(float m, float x, float y) {
    location = new PVector(x, y);
    mass = m;
    velocity = new PVector(0,0);
    acceleration = new PVector(0,0);
  }
  
  void applyForce(PVector force) {
    PVector a = PVector.div(force, mass);
    acceleration.add(a);
  }
  
  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    acceleration.mult(0);
  }
  
  void display() {
    stroke(1000);
    fill(255, 105, 180);
    ellipse(location.x, location.y, mass * 4, mass * 4);
  }
 
  
}
