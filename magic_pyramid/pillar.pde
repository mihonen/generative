public class Pillar{
  PVector position;
  color c;
  
  Pillar(PVector pos, color c_){
    position = pos;
    c = c_;
  }
  
  void show(PGraphics canvas){
    canvas.pushMatrix();
    canvas.translate(position.x, position.y, position.z);
    canvas.fill(c);
    canvas.box(8, 50, 8);
    
    
    canvas.translate(0, -35, 0);
    sphere(8);
    canvas.popMatrix();
  }
  
  
  
}
