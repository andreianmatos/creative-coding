final String sketchname = getClass().getName();

import com.hamoid.*;
VideoExport videoExport;

float t;
float nr_shapes = 2;

void setup(){
  background(20);
  size(500, 500);
  delay(500);
}

void draw() {
  delay(200);
  rec();
  background(20);
  stroke(255);
  strokeWeight(0.5);
  
  translate(width/2, height/2);
  
  noFill();
  
  text("The Line.",-100,0);
  text("The Triangle.",-100,10);
  text("The Rectangle.",-100,20);
  text("The Oval.",-100,30);
  text("Study.",-100, 40);
  
  for(int i = 0; i < nr_shapes; i++){
    line(random(-200, 200), random(-200, 200),random(-200, 200), random(-200, 200));
    ellipse(random(-100, 100), random(-100, 100), random(20,220), random(20,220));
    triangle(random(-200, 200), random(-200, 200), random(-200, 200), random(-200, 200), random(-200, 200), random(-200, 200));
    rect(random(-100, 100), random(-100, 100), random(-100, 100), random(-100, 100));
  }
}

void rec() {
  if (frameCount == 1) {
    videoExport = new VideoExport(this, "../"+sketchname+".mp4");
    videoExport.setFrameRate(30);  
    videoExport.startMovie();
  }
  videoExport.saveFrame();
}
