import processing.sound.*;

final String sketchname = getClass().getName();

import com.hamoid.*;
VideoExport videoExport;

float t;
float nr_shapes = 50;
int timer;

SinOsc sine;

PinkNoise noise;


void setup(){
  background(20);
  size(900, 900);
  
  // Create the sine oscillator
  sine = new SinOsc(this);
  sine.play();
  sine.freq(200);
  
  // Create the noise generator
  noise = new PinkNoise(this);
  noise.play();
}

void draw() {
  rec();
  background(20);
  stroke(255);   
  strokeWeight(3);
  translate(width/2, height/2);
  
  for(int i = 0; i < nr_shapes;i++)
    circle(0, 0, i*10);
  
  if (millis() % 2 == 0) {
    noFill();
    noise.play();
    sine.stop();
  }
  else {
    fill(255);
    noise.stop();
    sine.play();
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
