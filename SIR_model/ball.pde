public class Ball{
  float posx, posy,posz;
  int idx;
  float size;
  float vel;

  float S, I, R, N;
  float dS_dt, dI_dt, dR_dt;
  float beta, gamma, R0;
  ArrayList <Ball> neighbourNodes;
  
  float [] strk;
  float [] fll;
  
  Ball(int idx_, float posX, float posY, float posZ, float s, int S0, int I0, float beta_, float gamma_)
  {
    
    strk = new float[3];
    fll = new float[3];
    S = S0;
    I = I0;
    R = 0;
    N = S0 + I0;
    
    beta = beta_/10000;
    gamma = gamma_/10;
    R0 = beta/gamma;

    neighbourNodes = new ArrayList<Ball>();
   
    posx = posX;
    posy = posY;
    posz = posZ;
    vel = 0;
    size = s;
    idx = idx_;
}
  
  void showSphere(){
    pushMatrix();
    translate(posx, posy, posz);
    fill(fll[0], fll[1], fll[2]);
    noStroke();
    sphereDetail(8);
    sphere(size);
    popMatrix();
    
  }
  
  void showCircle(){
    pushMatrix();
    //translate(posx, posy, posz); //3D
    translate(posx*2*size, posy*2*size,posz*2*size);  //2D
    stroke(strk[0], strk[1], strk[2]);    
    noStroke();
    fill(fll[0], fll[1], fll[2]);
    ellipse(0,0,size,size);
    popMatrix();
  }

  

  void drop(){

    vel += random(0,0.5);
    
  }
  
  void update(){
    if(posz < -100){
      vel = 0;
    }
    posz -= vel;
    
    dS_dt = -beta*S*I;
    dI_dt = beta*S*I - gamma*I;
    dR_dt = gamma*I;
    
    S += dS_dt;
    I += dI_dt;
    R += dR_dt;

    float c = map(this.I, 0, N, 0, 255);
    this.setFill(c, 255 - c, 0);
  }
  
  void randomize(){
    posx += random(-2,2);    
    posy += random(-2,2);
    posz += random(-2,2);

  }
  void moveZ(int amount){
    posz += amount;
  }
  
  void createNetwork(){

    for(int j = -1; j <= 1; j++){
      for(int i = -1; i <= 1; i++){
        int neighbourIndex = this.idx + i + j * col;
        
        if (neighbourIndex < col * row && neighbourIndex >= 0 && balls[neighbourIndex] != null){
          this.neighbourNodes.add(balls[neighbourIndex]);
        }
      }
    }
    
  }
  
  void highlightNodes(){
    for(Ball b : neighbourNodes)
    {
      b.setFill(0, 255, 0);
    }
    
  }
  
  void setStroke(float r, float g, float b){
    strk[0] = r;
    strk[1] = g;
    strk[2] = b;
    

  }
  
  void setFill(float r, float g, float b){

      fll[0] = r;
      fll[1] = g;
      fll[2] = b;
    
  }
  
  void infect(int count){
    this.I += count;
    this.S -= count;
    
  }

  
}
