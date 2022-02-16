public class Sphere{
  float r;
  PVector position;
  PVector velocity;
  PVector acceleration;
  ArrayList<Point> points;
  boolean mortal;
  float lifetime;
  
  Sphere(float r_, PVector origin){
    r = r_;
    position = origin;
    velocity = new PVector(0, 0, 0);
    acceleration = new PVector(0, 0, 0);
    points = new ArrayList<Point>();
    
    for(int i = 0; i < r; i++){
      float lon = map(i, 0, r, -PI, PI);
      for(int j = 0; j < r; j++){
        float lat = map(j, 0, r, -HALF_PI, HALF_PI);
        float x = r * sin(lon) * cos(lat);
        float y = r * sin(lon) * sin(lat);
        float z = r * cos(lon);
        
        PVector o = new PVector(x, y, z);
        o.add(position);
        color c = color(255, 255, 255);
        Point p = new Point(o);
        p.setColor(c);
        points.add(p);        
      }
    }
    mortal = false;
  }
  
  void makeMortal(){
    mortal = true;
  }
  void update() {
    for(Point p: points){
      p.update();
    }
    lifetime++;
    
  }
  
  void rotate(){
    float angle = -frameCount * 0.015, rotation = TWO_PI / 20;
    position.x = sin(angle) * 210;
    position.y =  -200 + cos(angle) * 210;
  }
  

  void setVelocity(PVector vel){
    for(Point p:points){
      p.acceleration = vel.copy();
    }
    
  }
  
  void setColor(color c_){
    for(Point p:points){
      p.setColor(c_);
    }
    
  }
  
  void killInsidePyramid(float t){
    
    for(Point p: points){
      PVector worldPos = new PVector(
        p.position.x,
        p.position.y + 1.5 * t,
        p.position.z);
      
      //println(worldPos);
      if(isInsidePyramid(t, worldPos)){
        p.velocity = new PVector(0, 0, 0);
        p.acceleration = new PVector(random(-1, 1), random(-1, 1), random(-1, 1));
      }
      else {
        color w = color(255, 255, 255);
        //p.setColor(w);
      }
    }

  }
  
  void teleportInPyramid(float t){
    for(Point p: points){
      PVector worldPos = new PVector(
        p.position.x,
        p.position.y + 1.5 * t,
        p.position.z);
      if(isInsidePyramid(t, worldPos)){
        
        color r = color(255, 255, 255, 0);
        // first side of pyramid
        float dy = (t * 0.75 - abs(p.position.y));
        p.position.y -= 2*dy;


        if(abs(p.velocity.x) > abs(p.velocity.z)){
            if(p.position.x > 0){
              p.position.x -= t;
            }
            else {
              p.position.x += t;
            }
            
        }
        else if (abs(p.velocity.x) < abs(p.velocity.z)){
            if(p.position.z > 0){
              p.position.z -= t;
            }
            else {
              p.position.z += t;
            }
        }
        

        
        p.velocity.y *= -1;
        
      }
      else {
        color w = color(255, 255, 255);
        //p.setColor(w);
      }
    }
  }
  
  boolean isInsidePyramid(float t, PVector point){

    PVector v1 = new PVector( t, 0,  t);
    PVector v2 = new PVector( t, 0, -t);
    PVector v3 = new PVector(-t, 0, -t);
    PVector v4 = new PVector(-t, 0,  t);
    PVector v5 = new PVector( 0, -1.5*t, 0);
    
    
    PVector normal1 = v1.copy().sub(v5).cross(v2.copy().sub(v5)).normalize();
    PVector normal2 = v2.copy().sub(v5).cross(v3.copy().sub(v5)).normalize();
    PVector normal3 = v3.copy().sub(v5).cross(v4.copy().sub(v5)).normalize();
    PVector normal4 = v4.copy().sub(v5).cross(v1.copy().sub(v5)).normalize();
    PVector normal5 = v4.copy().sub(v3).cross(v3.copy().sub(v2)).normalize();


    if(
    normal1.dot(point) * normal1.dot(v3) > 0 
    && normal2.dot(point) * normal2.dot(v4) > 0
    && normal3.dot(point) * normal3.dot(v1) > 0
    && normal4.dot(point) * normal4.dot(v2) > 0
    && normal5.dot(point) * normal5.dot(v5) < 0 
    ){
      return true;
    }
    
    return false;
  }
  void show(PGraphics canvas){

    if(lifetime > 1400){
      return;
    }
    canvas.pushMatrix();
    
    for(Point p : points){
      p.show(canvas);
    }
    canvas.popMatrix();

  }  
}
