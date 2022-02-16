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
  if(frameCount > -1)
  {
    
    
    int infection_count = 0;
    Ball random = balls[int(random(0, row*col))];
      if (random != null) {
          random.infect(3);
        }
        
    for(Ball b: balls)

    {
      if(b != null){

        
      if(b.I > random(0, 100000))
      {
        
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
  

}


float get_brightness(PImage img)
{
  float b = 0;
  for(int i = 0; i < img.pixels.length; i++)
  {
    b += brightness(img.pixels[i]);
  }
  b /= img.pixels.length;
  return b;
}


void createBalls(){
  
    for(int j = 0; j < row; j++)            //create balls
  {
    lat = map(j, 0, row, 0, PI);
    for(int i = 0; i < col; i++)
    {
      lon = map(i,0,col,0, TWO_PI);
      float x = i * (float(width) / float(col)) + size; // rr*sin(lat) * cos(lon);
      float y = j * (float(height) / float(row)) + size; //rr*sin(lat) * sin(lon);
      float z = -15; // rr*cos(lat);
      int index = i + j*col;
      

      if(imgArr[index] > th)
      {
        balls[index] = new Ball(index, x,y,z, size, 100000, 0, BETA, GAMMA);

        onoff[index] = true;
      }
      else 
      {
        onoff[index] = false;
      }
      
    }
  }

  for(Ball b : balls){
    if(b != null){
      
        b.createNetwork();
        b.setStroke(0,0,0);
        b.setFill(0,255,0);
        
      }
  }
   
}
  
