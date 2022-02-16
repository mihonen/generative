import peasy.*;
 
PVector lightDir = new PVector();
PShader defaultShader;
PGraphics shadowMap;
int landscape = 1;
float render_no = 0;

public void initShadowPass() {
    shadowMap = createGraphics(2048, 2048, P3D);

    shadowMap.noSmooth(); // Antialiasing on the shadowMap leads to weird artifacts
    //shadowMap.loadPixels(); // Will interfere with noSmooth() (probably a bug in Processing)
    shadowMap.beginDraw();
    shadowMap.noStroke();
    shadowMap.shader(new PShader(this, "vertShadowPass.glsl", "fragShadowPass.glsl"));
    shadowMap.ortho(-200, 200, -200, 200, 10, 400); // Setup orthogonal view matrix for the directional light
    shadowMap.endDraw();
}
 
public void initDefaultPass() {
  
    defaultShader = new PShader(this, "vertDefaultPass.glsl", "fragDefaultPass.glsl");
    shader(defaultShader);
    defaultShader.set("fraction", 1.0);
    noStroke();
}
 
void updateDefaultShader() {
 
    // Bias matrix to move homogeneous shadowCoords into the UV texture space
    PMatrix3D shadowTransform = new PMatrix3D(
        0.5, 0.0, 0.0, 0.5, 
        0.0, 0.5, 0.0, 0.5, 
        0.0, 0.0, 0.5, 0.5, 
        0.0, 0.0, 0.0, 1.0
    );
 
    // Apply project modelview matrix from the shadow pass (light direction)
    shadowTransform.apply(((PGraphicsOpenGL)shadowMap).projmodelview);
 
    // Apply the inverted modelview matrix from the default pass to get the original vertex
    // positions inside the shader. This is needed because Processing is pre-multiplying
    // the vertices by the modelview matrix (for better performance).
    PMatrix3D modelviewInv = ((PGraphicsOpenGL)g).modelviewInv;
    shadowTransform.apply(modelviewInv);
 
    // Convert column-minor PMatrix to column-major GLMatrix and send it to the shader.
    // PShader.set(String, PMatrix3D) doesn't convert the matrix for some reason.
    defaultShader.set("shadowTransform", new PMatrix3D(
        shadowTransform.m00, shadowTransform.m10, shadowTransform.m20, shadowTransform.m30, 
        shadowTransform.m01, shadowTransform.m11, shadowTransform.m21, shadowTransform.m31, 
        shadowTransform.m02, shadowTransform.m12, shadowTransform.m22, shadowTransform.m32, 
        shadowTransform.m03, shadowTransform.m13, shadowTransform.m23, shadowTransform.m33
    ));
 
    // Calculate light direction normal, which is the transpose of the inverse of the
    // modelview matrix and send it to the default shader.
    float lightNormalX = lightDir.x * modelviewInv.m00 + lightDir.y * modelviewInv.m10 + lightDir.z * modelviewInv.m20;
    float lightNormalY = lightDir.x * modelviewInv.m01 + lightDir.y * modelviewInv.m11 + lightDir.z * modelviewInv.m21;
    float lightNormalZ = lightDir.x * modelviewInv.m02 + lightDir.y * modelviewInv.m12 + lightDir.z * modelviewInv.m22;
    float normalLength = sqrt(lightNormalX * lightNormalX + lightNormalY * lightNormalY + lightNormalZ * lightNormalZ);
    defaultShader.set("lightDirection", lightNormalX / -normalLength, -lightNormalY / -normalLength, lightNormalZ / -normalLength);

    // Send the shadowmap to the default shader
    defaultShader.set("shadowMap", shadowMap);
    
    defaultShader.set("viewPos", cam.getPosition());
    defaultShader.set("render_no", render_no);
    render_no += 0.01;
}
 
public void keyPressed() {
    if(key != CODED) {
        if(key >= '1' && key <= '3')
            landscape = key - '0';
        else if(key == 'd') {
            shadowMap.beginDraw(); shadowMap.ortho(-200, 200, -200, 200, 10, 400); shadowMap.endDraw();
        } else if(key == 's') {
            shadowMap.beginDraw(); shadowMap.perspective(60 * DEG_TO_RAD, 1, 10, 1000); shadowMap.endDraw();
        }
    }
}
 
public void renderLandscape(PGraphics canvas) {
    switch(landscape) {
        case 1: {
                
                for(Sphere s: spheres){
                      
                   if(s.mortal){
                      s.killInsidePyramid(pyramid.t);

                   }
                   else {
                     
                
                     s.teleportInPyramid(pyramid.t);

                   }
                   
                    s.update();
                    s.show(canvas);
                }
               
                pyramid.show(canvas);
                pillar.show(canvas);
                pillar2.show(canvas);
                pillar3.show(canvas);
                pillar1.show(canvas);
                /*
                float angle = -frameCount * 0.0015, rotation = TWO_PI / 20;
                canvas.fill(0xffff5500);
                canvas.noStroke();
                
                
                for(int n = 0; n < 20; ++n, angle += rotation) {
                    canvas.pushMatrix();
                    canvas.translate(sin(angle) * 210, -250, cos(angle) * 210);
                    canvas.sphere(10);
                    canvas.popMatrix();
                }
                */
                canvas.pushMatrix();
                canvas.translate(0, 10, 0);
                canvas.fill(0xffaaaaaa);
                canvas.box(450, 5, 450);
                canvas.popMatrix();
                
            
        } break;
        case 2: {
            float angle = -frameCount * 0.0015, rotation = TWO_PI / 20;
            canvas.fill(0xffff5500);
            for(int n = 0; n < 20; ++n, angle += rotation) {
                canvas.pushMatrix();
                canvas.translate(sin(angle) * 210, cos(angle * 4) * 30, cos(angle) * 210);
                canvas.box(10, 100, 10);
                canvas.popMatrix();
            }
            canvas.fill(0xff0055ff);
            canvas.sphere(50);
        } break;
        case 3: {
            float angle = -frameCount * 0.0015, rotation = TWO_PI / 20;
            canvas.fill(0xffff5500);
            for(int n = 0; n < 20; ++n, angle += rotation) {
                canvas.pushMatrix();
                canvas.translate(sin(angle) * 70, cos(angle) * 70, 0);
                canvas.box(10, 10, 100);
                canvas.popMatrix();
            }
            canvas.fill(0xffffffff);
            canvas.sphere(50);
        }
    }
    

}
