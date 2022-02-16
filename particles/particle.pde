public class Particle {
  PVector origin;
  PVector position;
  PVector velocity;
  PVector acceleration;
  float mass;
  int r;
  
  PVector previousPos;
  
  Particle(PVector origin_){
    position = origin_;
    velocity = new PVector(0, 0, 0);
    acceleration = new PVector(0, 0, 0);
    mass = random(1, 30);
    
    previousPos = position.copy();
    origin = position.copy();
    r = int(random(1) * 255);
  }
 
  
  
  void applyForce(PVector force){
    acceleration.add(force.div(mass)); 
  }
  
  void applyGravity(){
    // F = G * (m1 * m2) / r^2
    PVector totalForce = new PVector(0, 0, 0);
    double mag;
    PVector F;
    float G = 6.674 * pow(10, -11);

    for(Particle p: particles){
      double r = p.position.dist(position);
      if(r > 0){
         mag = G * p.mass * this.mass / (r*r);
         F = position.copy().sub(p.position).normalize();
         totalForce.add(F.mult((float)mag));
      }
     
    }
    applyForce(totalForce);
  }
  
  
  void update() {
    

    float dist = origin.dist(position);

    velocity.add(acceleration);
    position.add(velocity);
    acceleration.mult(0);
    
  }
  
  void show(){
    pushMatrix();
    translate(position.x, position.y, position.z);
    fill(r, 255 - r, 255);
    noStroke();
    ellipse(0, 0, mass / 10, mass / 10);
    popMatrix();
    
    previousPos = position.copy();
  }  
}
