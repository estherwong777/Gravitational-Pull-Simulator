class Attractor {
  
  float mass;
  PVector location;
  float G = 9.8;
  float diameter;


  public Attractor(float x, float y) {
    location = new PVector(x, y);
    setMass(20);
  }

  void display() {
    stroke(1000);
    fill(255);
    ellipse(location.x,location.y, diameter, diameter);
  }
  
  void setMass(float mass) {
    this.mass = mass;
    this.diameter = 4 * mass;
  }

  PVector attract(Mover m) {
    PVector f = PVector.sub(location, m.location);
    float distance = f.mag();
    distance = constrain(distance, 5.0, 25.0);
    f.normalize();
    f.mult((G * mass * m.mass) / (distance * distance)); //formula for G force Gmm/r^2
    return f;
  }

}
