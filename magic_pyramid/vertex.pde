public class Vertex{
  PVector position;
  color c;
  
  Vertex(PVector origin){
    position = origin;
    
  }
  
  void setColor(color c_){
    c = c_;
    
  }
  
  void show(PGraphics canvas){
    canvas.pushMatrix();
    canvas.translate(0, 0, 0);
    if(alpha(c) != 0){
      canvas.stroke(c);
      canvas.point(position.x, position.y, position.z);
    }
    
    canvas.popMatrix();
  }
}
