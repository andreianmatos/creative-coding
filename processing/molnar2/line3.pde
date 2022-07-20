// vera molnar, structures de quadrilateres 1986

color black = #000000;
color whitish = #f1f1f1;
color darkred = color (139, 0, 0);

int grid = 100;
int margin = 200;

void setup(){
  size(800, 800);
}

void draw() {
  delay(500);
  background(whitish);
     
  dust();  
  
  int gap = 10;
  
  // calculate the size of each square for the given number of squares and gap between them
  // this will always be the same number. I could have just given it a specific number, but left the calculation just to try different gap sizes.
  float cellsize = ( width - (5 + 1) * gap ) / 5; // if you do the math, this equals to 108.
   
  int redCount = 0; 
  
  for (int i=0; i<5; i++) { 
    for (int j=0; j<5; j++) { 
 
      // To create the red squares, it starts by gnerating a random number between 0 and 5 which will be used to determine whether the square being created should be red or not.
      int red = (int) random(0, 5);
     
      if(red == 0 && redCount < 5){
         fill(darkred); 
         redCount++; // after each time that a red square is created (determined by the random number being 0), the counter which keeps track of how many red squares have been created so far, is increased by 1.
      } else {        
         fill(black, 200); // if the randomly generated number is not 0, or if there are 5 red squares already, then the next square to be generated will be brown.
      }
     
      rect( gap * (i+1) + cellsize * i + (int) random(-12, 12), // X position. the random number is what makes the squares keep moving slightly left to right.
            gap * (j+1) + cellsize * j + (int) random(-12, 12), // Y position. the random number is what makes the squares keep moving slightly up and down.
            cellsize,
            cellsize);
    }
  }
  fill(black);
  textSize(28);
  //text("---", 600, 700); 
  //text("D", 625, 708); 
  
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
    fill(black);
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
