final String sketchname = getClass().getName();

import com.hamoid.*;
VideoExport videoExport;

float t;
float nr_shapes = 10;

void setup(){
  background(20);
  size(500, 500);
}

void draw() {
  delay(200);
  rec();
  background(20);
  stroke(250,250,250);
  
  translate(width/2, height/2);
  
  noFill();
  
  for(int i = 0; i < nr_shapes; i++){
    strokeWeight(random(1,5));
    rotate(PI/random(0,PI));
    float a = random(-100, 100);
    float b = random(-100, 100);
    float c = random(-100, 100);
    float d = random(-100, 100);
    line(a, b, c, d);
    line(a, b-100, c, d+100);
  }
   saveFrame(); 
}

void rec() {
  if (frameCount == 1) {
    videoExport = new VideoExport(this, "../"+sketchname+".mp4");
    videoExport.setFrameRate(30);  
    videoExport.startMovie();
  }
  videoExport.saveFrame();
}
