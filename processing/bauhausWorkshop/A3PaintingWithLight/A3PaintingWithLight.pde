final String sketchname = getClass().getName();

import com.hamoid.*;
VideoExport videoExport;

color bg = #000000;
color fg = #f1f1f1;

float angle, t;

void setup(){
  size(900, 900);
  randomSeed(10);
  background(bg);
  dust();
}

void draw() {
  delay(100);
  rec();

  translate(width/2, height/2);

  pushMatrix();
  fill(fg, 10);
  noStroke();
  
  
  ellipse(cos(angle)*t, sin(angle)*t,100,100);  
  
  
  popMatrix();
  
  angle += PI/90;
  t += 1;
    
  saveFrame(); 
}

void dust(){
  
  
  int nr_dots = 100;
  int nr_lines = 20;
  
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
    stroke(fg);
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
