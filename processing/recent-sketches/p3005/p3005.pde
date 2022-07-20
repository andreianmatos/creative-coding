// vera molnar, structures de quadrilateres 1986

final String sketchname = getClass().getName();

import com.hamoid.*;
VideoExport videoExport;

color bg = #000000;
color fg = #f1f1f1;

int grid = 150;
int margin = 150;

boolean dusted = false;

color[] colArray = {
  color(#000000), // black
  color (139, 0, 0) // dark red
};

void setup(){
  size(800, 800);
}

void draw() {
  background(fg);
   
  noFill();
  
  dust();
    
  float d = grid*0.6;
  
  for (int i = margin; i < width-margin; i += grid) {
    for (int j = margin; j < height-margin; j += grid) {
      
      int colArrayNum = (int)random(1);
      stroke(colArray[colArrayNum]);
      strokeWeight(random(20));
      
      for(int num = 0; num < 1; num++) {
        float x1 = -random(d);
        float y1 = -random(d);
        float x2 = random(d);
        float y2 = -random(d);
        float x3 = random(d);
        float y3 = random(d);
        float x4 = -random(d);
        float y4 = random(d);
      
        pushMatrix();
        
        translate(i,j);
        
        //quad(x1, y1, x2, y2, x3, y3, x4, y4);
        //quad(x1-10, y1-10, x2-10, y2-10, x3-10, y3-10, x4-10, y4-10);
        //quad(x1+10, y1+10, x2+10, y2+10, x3+10, y3+10, x4+10, y4+10);
        polygon(0, 0, x2, int(random(10)));
        
        popMatrix();
      }
    }  
  }  
  //rec();
  saveFrame(); 
}

void polygon(float x, float y, float radius, int npoints) {
  float angle = TWO_PI / npoints;
  beginShape();
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = x + cos(a) * radius;
    float sy = y + sin(a) * radius;
    vertex(sx, sy);
  }
  endShape(CLOSE);
}

void dust(){
  
  stroke(#000000);
   
  int nr_dots = 100;
  int nr_lines = 5;
  
  pushMatrix();

  for(int i=0; i < nr_dots; i++) {
    noFill();
    rotate(PI/random(0,PI));
    strokeWeight(random(0,0.2));
    ellipse(random(0,900),random(0,900),random(0,0.5),random(0,0.5));
    fill(fg);
    strokeWeight(random(0,1));
    ellipse(random(0,900),random(0,900),random(0,6),random(0,6));  
    arc(random(0,900),random(0,900),random(0,900),random(0,900), PI+QUARTER_PI, CHORD);

  }
  
  for(int i=0; i < nr_lines; i++) {
    noFill();
    strokeWeight(random(0,0.2));
    rotate(PI/random(0,PI));
    float r = random(0,900);
    curve(random(0,900),random(0,900),random(0,900),random(0,900),random(0,900),random(0,900),random(0,900),random(0,900));
    strokeWeight(random(0,1));
    curve(r, r+random(0,50), r, r+random(0,50), r, r+random(0,50), r, r+random(0,50));
  }
  
  popMatrix();

}

void rec() {
  if (frameCount == 1) {
    videoExport = new VideoExport(this, "../video/"+sketchname+".mp4");
    videoExport.setFrameRate(30);  
    videoExport.startMovie();
  }
  videoExport.saveFrame();
}

void keyPressed() {
  if(key == ' ') redraw();
}
