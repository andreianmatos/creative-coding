final String sketchname = getClass().getName();

import com.hamoid.*;
VideoExport videoExport;

float t;
float nr_shapes = 10;

void setup(){
  background(20);
  size(600, 600);
}

void draw() {
  delay(200);
  rec();
  background(20);
  stroke(255);   
  noFill();
  
  for(int x = 60; x < width-20; x+= 60){
    for(int y = 60; y < height-20; y+= 60){
       for(int i = 0; i < nr_shapes; i++){
         strokeWeight(random(0.1,1));
         rotate(PI/random(0,PI));
         quad(x, y,random(10,60), random(10,60),random(10,60),random(10,60));  
         //line(x, y,random(10,60), random(10,60));  
       }
    }
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
