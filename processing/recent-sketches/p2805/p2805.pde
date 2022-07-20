// inspirado pela curta de hans richter

final String sketchname = getClass().getName();

import com.hamoid.*;
VideoExport videoExport;

PFont font1;
PFont font2;

float noiseScale = 0.02;

color fg = color(7,7,7);

int yesImage = 0;

void setup(){
  size(600, 600);
 }

void draw() {
  delay(1000);
  
  background(200);
  //background(139, 7, 7);

  translate(height/2, width/2);
  
  dust();  
  
  
  noFill();
  
  filter(THRESHOLD);
  
  stroke(255, 102, 0);
  stroke(0, 0, 0);
  for(int i=0; i <5;  i++){
    strokeWeight(random(0,5));
    bezier(0, 0, random(-400,400), random(-400,400), random(-400,400), random(-400,400), 0, 0);  
  }
  saveFrame(); 
  rec();
}


void dust(){
  
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
    videoExport = new VideoExport(this, "../"+sketchname+".mp4");
    videoExport.setFrameRate(30);  
    videoExport.startMovie();
  }
  videoExport.saveFrame();
}
