// use sins/ cos or polar coordinate equations

float t, t2;
float nr_points = 2000, nr_points_sphere = 400;

void setup(){
  background(20);
  size(500, 500);
}

void draw() {
  background(20);
  stroke(255);
  strokeWeight(5);
  
  translate(width/2, height/2);
  for( int i = 0; i < nr_points; i++) {
    point(x1(t + i), y1(t + i));
  }
  
  for( int i = 0; i < nr_points_sphere; i++) {
    point(x2(t2 + i, 145, 100), y2(t2 + i, 145, 100));
  }
  
  t += 0.05;
  t2 += 150;
}


// coef inside sin changes freq and outside changes amplitude
float x1(float t) {
  return sin(t/100) * 100;
}

float y1(float t) {
  return cos(-t) * 100;
}

float x2(float t, float d, float b) {
  return sin(-t/b) * d;
}

float y2(float t, float d, float b) {
  return cos(t/b) * d;
}
