// retalhos recombinados de poemas de Judith Teixeira
// em ocasião do aniversário da sua morte
// a completar quando tiver em minha posse a sua colectânea (em Viseu)

final String sketchname = getClass().getName();

import com.hamoid.*;
VideoExport videoExport;

PFont font1;
PFont font2;


color fg = color(7,7,7);


void setup(){
  size(600, 600);
  //font1 = createFont("Tomatoes-O8L8.ttf", 128);
  //font2 = createFont("LucySaidOkPersonalUseItalic-OV9ee.ttf", 128);
}

void draw() {
  delay(1000);
  
  background(200);
  //background(139, 7, 7);
  
  //dust();  
  
  strokeWeight(2);
  
  textSize(20);
  noFill();
 
  square(50, 50, 500);
  fill(fg);
  for(int i = 51; i < 545; i+=5){
    for(int j = 66; j < 555; j+=15){
      if(random(1,10) > 5){
        text("\\", i, j);
      }
    }
  }
  
  for(int i = 51; i < 541; i+=5){
    for(int j = 66; j < 555; j+=15){
      if(random(1,10) > 9){
        text(">", i, j);
      }
    }
  }
  
  for(int i = 51; i < 541; i+=5){
    for(int j = 66; j < 555; j+=15){
      if(random(1,10) > 9){
        text("_", i, j);
      }
    }
  }
  
  saveFrame(); 
}


void dust(){
  
  int nr_dots = 100;
  int nr_lines = 5;
  
  rec();
  
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
