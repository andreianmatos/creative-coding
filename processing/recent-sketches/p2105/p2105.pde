// inspirado pela curta de hans richter
// MAYBE RANDOMIZE WHICH SPEED THEY GO AT AT EACH GO?

final String sketchname = getClass().getName();

import com.hamoid.*;
VideoExport videoExport;

PFont font1;
PFont font2;

float noiseScale = 0.02;

color fg = color(7,7,7);

int insideOut1 = 0, insideOut2 = 0, insideOut3 = 0;
int count1 = 0, count2 = 0, count3 = 0;

void setup(){
  size(600, 800);
 }

void draw() {
  delay(1000);
  
  background(200);
  //background(139, 7, 7);
  
  dust();  
  
  strokeWeight(1);
  
  textSize(20);
  noFill();
  
  filter(THRESHOLD);
  
  count1++;
  count2++;
  count3++;
  
  int var1 = 0;
  if(count1 < 150)
    var1 += count1;
  else{
    if(insideOut1 == 1)
      insideOut1 = 0;
    else
      insideOut1 = 1;
    count1 = 0;
  }
    
  int var2 = 0;
  if(count2 < 75)
    var2 += count2;
  else{
    if(insideOut2 == 1)
      insideOut2 = 0;
    else
      insideOut2 = 1;
    count2 = 0;
  }
    
  int var3 = 0;
  if(count3 < 50)
    var3 += count3;  
  else{
    if(insideOut3 == 1)
      insideOut3 = 0;
    else
      insideOut3 = 1;
    count3 = 0;
  }
  
  noStroke();

  if(insideOut1 == 0){
    fill(200);
    rect(150, 50, 150, 200);
    rect(300, 50, 150, 200);
    fill(fg);
    rect(300, 50, var1, 200);
    rect(300, 50, -var1, 200);
  }
  else{
    fill(fg);
    rect(150, 50, 150, 200);
    rect(300, 50, 150, 200);
    fill(200);
    rect(150, 50, var1, 200);
    rect(450, 50, -var1, 200);
  }
  
  if(insideOut2 == 0){
    fill(200);
    rect(150, 300, 150, 200);
    rect(300, 300, 150, 200);
    fill(fg);
    rect(300, 300, var2*2, 200);
    rect(300, 300, -var2*2, 200);
  }
  else{
    fill(fg);
    rect(150, 300, 150, 200);
    rect(300, 300, 150, 200);
    fill(200);
    rect(150, 300, var2*2, 200);
    rect(450, 300, -var2*2, 200);
  }
  
  if(insideOut3 == 0){
    fill(200);
    rect(150, 550, 150, 200);
    rect(300, 550, 150, 200);
    fill(fg);
    rect(300, 550, var3*3, 200);
    rect(300, 550, -var3*3, 200);
  }
  else{
    fill(fg);
    rect(150, 550, 150, 200);
    rect(300, 550, 150, 200);
    fill(200);
    rect(150, 550, var3*3, 200);
    rect(450, 550, -var3*3, 200);
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
