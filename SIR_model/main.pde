// VISUAL SIMULATION OF UNCONTROLLED
// PANDEMIC USING SIR MODEL
// By Ville Muhonen
// 2018




void setup(){
  size(1280,700,P3D);
  pixelDensity(2); // <MAC RETINA DISPLAY>
  frameRate(60);
  background(0);
  

  kuva = loadImage("worldMap.png");
  
  scl = 6;
  
  size = 2;
  col = floor(width / scl) + 1; 
  row = floor(height / scl) + 1; 
  balls = new Ball [col * row + row];
  
  imgArr = new float[col*row];
  float imgAspectX = float(kuva.width) / width;
  float imgAspectY = float(kuva.height) / height;

  for(int i = 0; i < row; i++)
   {    
     for(int j = 0; j < col; j++)
     {
       PImage newImg = kuva.get(floor(j*scl * imgAspectX), floor(i*scl * imgAspectY), round(scl * imgAspectX), round(scl * imgAspectY));
       int index = j + i*col;
       imgArr[index] = get_brightness(newImg);
       println(get_brightness(newImg));
     }
   }
     
  onoff = new boolean[col+ col*row];
  rr = 50;
 
}

void draw() {
  if(!done){
    createBalls();
    done = true;
  }
  
  lights();
  background(0);
  if(frameCount > -1){
  
  
    int infection_count = 0;
    Ball random = balls[int(random(0, row*col))];
    if (random != null) {
      random.infect(3);
    }
    
    for(Ball b: balls){
      if(b != null){
        if(b.I > random(0, 100000)) {
          
          b.setFill(255,0,0);
          for(Ball node:b.neighbourNodes){
            node.infect(1);
          }
          infection_count++;
          
        }
        
        b.showSphere();
        b.update();
      }
    }
    
  }

  //saveFrame("SIR_ANIM-#####.png");

}
