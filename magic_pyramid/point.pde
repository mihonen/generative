public class Point{
  
  PVector position;
  PVector velocity;
  PVector acceleration;
  float lifetime;
  
  color c;
  
  Point(PVector origin){
    position = origin;
    velocity = new PVector(0, 0, 0);
    acceleration = new PVector(0, 0, 0);
    lifetime = 0;
    
  }
  
  void setColor(color c_){
    c = c_;
  }
  
  void show(PGraphics canvas){
    canvas.pushMatrix();
    canvas.translate(0, 0, 0);
    
    if(alpha(c) != 0){
      canvas.strokeWeight(2.0);
      canvas.stroke(c);
      canvas.point(position.x, position.y, position.z);
    }
    
    canvas.popMatrix();
  }
  
  void update(){
    velocity.add(acceleration);
    position.add(velocity);
    acceleration.mult(0);
    if(lifetime < 200 && alpha(c) < 255){
      c = color(red(c), green(c), blue(c), alpha(c) + 1);
    }
    if(lifetime > 1200){
      c = color(red(c), green(c), blue(c), alpha(c) - 1);
      //velocity = new PVector(0, 0, 0);
      //acceleration.add(new PVector(random(0, 1.0), random(0, 1.0), random());
    
    }
    lifetime += 1;

  }

}
