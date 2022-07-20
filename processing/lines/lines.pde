
color bg = #000000;
color fg = #f1f1f1;

int grid = 150;
int margin = 150;

color[] colArray = {
  color(#000000), // black
  color (139, 0, 0) // dark red
};

void setup(){
  size(800, 800);
}

void draw() {
  delay(500);
  background(fg);
   
  noFill();
  
  dust();  
  
  float d = grid*0.6;
  
  for (int i = margin; i < width-margin; i += grid) {
    for (int j = margin; j < height-margin; j += grid) {
      
      int colArrayNum = (int)random(1);
      stroke(colArray[colArrayNum]);
      strokeWeight(1);
      
      for(int num = 0; num < 100; num++) {
        float x1 = -random(d);
        float y1 = -random(d);
        float x2 = random(d);
        float y2 = -random(d);
        float x3 = random(d);
        float y3 = random(d);
        float x4 = -random(d);
        float y4 = random(d);
      
        pushMatrix();
        translate(i,j);
        line(x1, y1, x2, y2);
        popMatrix();
      }
    }  
  }
  
  fill(bg);
  textSize(28);
  text("---", 600, 700); 
  text("D", 625, 708); 
  
  saveFrame(); 
}

void dust(){
  
  stroke(#000000);
  
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

void keyPressed() {
  if(key == ' ') redraw();
}
