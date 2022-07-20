final String sketchname = getClass().getName();

import com.hamoid.*;
VideoExport videoExport;

color bg = #000000;
color fg = #f1f1f1;

float angle;

int nrPics = 0;

void setup(){
  size(900, 900);
  background(bg);
  randomSeed(10);
  dust();
}

void draw() {
  delay(100);
  randomSeed(10);
  background(bg);
  dust();
  
  translate(width/2, height/2);

  pushMatrix();
  fill(fg, 100);
  noStroke();
  
  rotate(radians(angle)); 
  float diff = 50;
  float x1 = 0;
  float y1 = -diff;
  float x2 = diff;
  float y2 = diff;
  float x3 = -diff;
  float y3 = diff;
  triangle(x1, y1, x2, y2, x3, y3);
  popMatrix();
  
  pushMatrix();
  translate(0,angle);
  square(-50, -50, 100);
  popMatrix();
  
  pushMatrix();
  translate(0,-angle);
  ellipse(0, 0, 100, 100); 
  popMatrix();
    
  if(angle == 90 || angle == 180 || angle == 270)
    switchColor();
  else if(bg != #000000)
    switchColor();
    
  if(angle < 360)
    angle+=10;
     
  if(nrPics < 500){
    saveFrame(); 
    nrPics++;
  }
  
  rec();
}

void switchColor(){
  color temp = fg;
  fg = bg;
  bg = temp;
}

void dust(){
  
  
  int nr_dots = 100;
  int nr_lines = 3;
  
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
    videoExport = new VideoExport(this, "../"+sketchname+".mp4");
    videoExport.setFrameRate(30);  
    videoExport.startMovie();
  }
  videoExport.saveFrame();
}
