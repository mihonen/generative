import peasy.*;
ArrayList<Particle> particles;
PeasyCam cam;
void setup(){
  size(500, 800, P3D); 
  background(0);
  frameRate(60);
    
  particles = new ArrayList<Particle>();
  float blastMag = 30;
  for(int n = 0;  n < 1500; n++){
    PVector o = new PVector(width / 2, height / 2, 0);
    Particle p = new Particle(o);
    PVector f = new PVector(random(-1, 1) * blastMag, random(-1, 1) * blastMag, random(-1, 1) * blastMag);
    p.applyForce(f);
    particles.add(p);
  }
  
}
void draw(){
  background(0);
  for(Particle p: particles){
    //PVector f = new PVector(random(-PI, PI), random(-PI, PI), random(-PI, PI));
    p.applyGravity();
    p.update(); 
    p.show();
  }
  //saveFrame("blast-######.png");
}
