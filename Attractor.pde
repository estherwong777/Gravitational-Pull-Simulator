class Attractor {
  
float mass;
PVector location;
float G = 9.8;

public Attractor() {
  location = new PVector(width/2,height/2);
  mass = 20;
}

void display() {
  stroke(1000);
  fill(255);
  ellipse(location.x,location.y,mass*4,mass*4);
}

PVector attract(Mover m) {
  PVector f = PVector.sub(location, m.location);
  float distance = f.mag();
  distance = constrain(distance, 5.0, 25.0);
  f.normalize();
  f.mult((G * mass * m.mass) / (distance * distance));
  return f;
}

}
