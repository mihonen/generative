public class Pyramid{
  float t;
  Pyramid(float t_){
    t = t_;
  }
  
  
  void show(PGraphics canvas) { 
    //canvas.stroke(255, 255, 255);
    canvas.noStroke();
    canvas.noFill();
    
    // this pyramid has 4 sides, each drawn as a separate triangle
    // each side has 3 vertices, making up a triangle shape
    // the parameter " t " determines the size of the pyramid
    /*
    canvas.beginShape(TRIANGLES);
  

    canvas.vertex( -t, 0, -t);
    canvas.vertex( -t, 0, t);
    canvas.vertex( 0, -t*1.5, 0);
  
    canvas.vertex( -t, 0, t);
    canvas.vertex(t, 0, t);
    canvas.vertex( 0, -t*1.5, 0);
  
    canvas.vertex(t,  0, -t);
    canvas.vertex(t,  0,  t);
    canvas.vertex(0, -t*1.5,  0);
  
  
    canvas.vertex(-t,  0, -t);
    canvas.vertex( t,  0, -t);
    canvas.vertex( 0, -t*1.5, 0);
  
  
    
    canvas.endShape();
    */
    canvas.normal(0, 1, 0);
    canvas.fill(0, 0, 0);
    canvas.box(300, 5, 300);

  }

}
