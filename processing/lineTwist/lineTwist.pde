final String sketchname = getClass().getName();

import com.hamoid.*;
VideoExport videoExport;

float last_x = 100, 
last_y = 100;
float next_x = 550, 
next_y = 700;
boolean redo = false;
int count = 150;

float nr_words = 10;
String[] words = {
  "janela", "chá", "toque", "dedos", "neve", "sesta"
};
float noiseScale = 500;

int nr_ellipses = 2, nr_lines = 0;

void setup(){
  background(0);
  size(500, 500, P3D);
}

void draw() {
  rec();
  delay(200);
  if(redo){
    background(0);
    nr_lines = 0;
    nr_ellipses = 0;
    redo = false;
  }
  stroke(20);
  
  //translate(width/2, height/2);
  rotateY(frameCount / 200.0);
    
  //noFill();
  fill(250, 250, 250);
  textSize(50);
  
  for(int x = 60; x < width-20; x+= 60){
    for(int y = 60; y < height-20; y+= 60){
       for(int i = 0; i < nr_words; i++){
         print("a");
         text(words[(int)random(0, words.length-1)], x, y);  
       }
    }
  } 
}

void keyPressed() {
  if (key == ENTER) {
    redo = true;
    saveFrame(timestamp()+"_##.png");
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

// timestamp
String timestamp() {
  count++;
  return String.format(str(count)+".jpg");
}
