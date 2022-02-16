import peasy.*;
PeasyCam cam;

Pyramid pyramid;
Sphere sphere;
Sphere sphere2;
Sphere sphere3;
Sphere sphere4;
Pillar pillar;
Pillar pillar1;
Pillar pillar2;
Pillar pillar3;

color c1 = color(184, 86, 255, 0);
color c2 = color(233, 182, 90, 0);
  
ArrayList<Sphere> spheres;

void setup(){
  size(1000, 1000, P3D);
  frameRate(60);
  pixelDensity(2);
  smooth(8);
  
  
  cam = new PeasyCam(this, 800);
  //cam.rotateX(PI * 0.03);
  cam.lookAt(0, -200, 0);
  
  pyramid = new Pyramid(150);
  sphere = new Sphere(80, new PVector(200, -150, 0)); 
  sphere2 = new Sphere(40, new PVector(0, -150, 300));
  sphere3 = new Sphere(60, new PVector(-150, -100, 0));
  sphere4 = new Sphere(40, new PVector(0, -200, -400));

  sphere.setColor(color(133, 92, 12));
  sphere2.setColor(color(random(43, 90), random(120, 222), random(55, 180)));
  sphere3.setColor(color(random(43, 90), random(120, 222), random(55, 180)));
  sphere3.setColor(color(random(43, 90), random(120, 222), random(55, 180)));
  
  spheres = new ArrayList<Sphere>();
  //spheres.add(sphere); spheres.add(sphere2); spheres.add(sphere3); spheres.add(sphere4);
  sphere.setVelocity(new PVector(-0.5, 0.2, 0));
  sphere2.setVelocity(new PVector(0, 0.1, -0.2));
  sphere3.setVelocity(new PVector(0.6, 0.1, 0));
  sphere4.setVelocity(new PVector(0, 0.3, 0.6));
  

  pillar = new Pillar(new PVector(200, -15, 200), color(184, 86, 255, 255));
  pillar1 = new Pillar(new PVector(-200, -15, 200), color(233, 182, 90, 255));
  pillar2 = new Pillar(new PVector(-200, -15, -200), color(184, 86, 255, 255));
  pillar3 = new Pillar(new PVector(200, -15, -200), color(233, 182, 90, 255));
  
  initShadowPass();
  initDefaultPass();
}

float rotZ = 0;

void draw(){
  //lights();
  cam.rotateY(0.005);
  
  background(0);
  lightDir.set(50, -300, 0);
 
  // Render shadow pass
  shadowMap.beginDraw();
  shadowMap.camera(lightDir.x, lightDir.y, lightDir.z, 0, 0, 0, 0, 1, 0);
  shadowMap.background(0xffffffff); // Will set the depth to 1.0 (maximum depth)
  renderLandscape(shadowMap);
  shadowMap.endDraw();
  shadowMap.updatePixels();
 
  // Update the shadow transformation matrix and send it, the light
  // direction normal and the shadow map to the default shader.
  updateDefaultShader();
 
  // Render default pass
  background(0xff000000);
  renderLandscape(g);
 if(frameCount % 120 == 0){
   float sign = random(-1, 1);
   if(sign < 0) sign = -1;
   else sign = 1;
   
   PVector spawn = new PVector(0, random(-1200, -300), random(sign * 200, sign * 1200));
   Sphere s = new Sphere(40, spawn);
   PVector vel = new PVector(0, -spawn.y, -spawn.z).normalize().mult(random(1, 3));
   s.setVelocity(vel);
   if(random(0, 10) < 2) s.makeMortal();
   
   s.setColor(c2);
   spheres.add(s);
   
   sign = random(-1, 1);
   if(sign < 0) sign = -1;
   else sign = 1;
   
   PVector spawnx = new PVector(random(sign * 200, sign * 1200), random(-1200, -300), 0);
   Sphere sx = new Sphere(40, spawnx);
   
   PVector velx = new PVector(-spawnx.x, -spawnx.y, 0).normalize().mult(random(1, 2));
   sx.setVelocity(velx);
   if(random(0, 10) < 2) sx.makeMortal();
   
   sx.setColor(c1);

   spheres.add(sx);
 }
 
  //saveFrame("intersection-######.png");
}
