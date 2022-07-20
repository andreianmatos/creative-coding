color bg = #000000;
color fg = #f1f1f1;

int nr_shapes = 1;

void setup(){
  size(900, 900);
}

void draw() {
  delay(200);
  background(bg);
  stroke(fg);
  fill(fg);
  
  translate(width/2, height/2);
    
  strokeWeight(random(5,10));
  
  rotate(PI/random(0,PI));
  
  float r = random(10,500);
  
  rect(random(10,500),random(10,500),random(10,500),random(10,500));
  ellipse(random(10,500),random(10,500),r,r);
  triangle(random(10,500),random(10,500),random(10,500),random(10,500),random(-200, 200), random(-200, 200));
  //arc(random(-100, 100), random(-100, 100),random(-100, 100), random(-100, 100), PI, TWO_PI);
  line(random(-1000,1000),random(-1000,1000),random(-1000,1000),random(-1000,1000));
   saveFrame(); 
}
