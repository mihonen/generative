

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

    for(int i = 0; i < col; i++)
    {

      float x = i * (float(width) / float(col)) + size;
      float y = j * (float(height) / float(row)) + size;
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
  
