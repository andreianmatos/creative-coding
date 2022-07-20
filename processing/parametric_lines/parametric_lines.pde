// use sins/ cos or polar coordinate equations

float t;
float nr_lines = 10;

void setup(){
  background(20);
  size(500, 500);
  delay(5000);
}

void draw() {
  background(20);
  stroke(255);
  strokeWeight(5);
  
  translate(width/2, height/2);
  
  for( int i = 0; i < nr_lines; i++) {
    line(x1(t + i), y1(t + i), x2(t + i), y2(t + i));
  }
  
  for( int i = 0; i < nr_lines; i++) {
    line(y2(t + i), x2(t + i), y1(t + i), x1(t + i));
  }

  t += 0.1;
}


// coef inside sin changes freq and outside changes amplitude
float x1(float t) {
  return sin(t / 20) * 2 + cos(t/10) * 10 ;
}

float y1(float t) {
  return cos(-t / 10) * 100 + cos(t) * 50 ;
}

float x2(float t) {
  return sin(t / 10) * 100 + + cos(t) * 10;
}

float y2(float t) {
  return cos(t / 20) * 2 + + cos(t/2) * 50;
}
