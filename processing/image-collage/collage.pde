import java.io.File;
String[] imageFileNames;
PImage[] images;

void setup() {
  size(900, 900);

  java.io.File folder = new java.io.File(dataPath("img"));
  imageFileNames = folder.list();

  images = new PImage[imageFileNames.length];

  println("loading...");
  // Load the image-files and push thems to imagess-arrayList
  for (int i = 0; i < imageFileNames.length; i++) {
    String filename = imageFileNames[i];
    if (filename.indexOf("Store") == -1) {
      PImage temp = loadImage("data/img/"+filename);
      temp.resize(width, height);
      images[i] = temp;
    }
  }

  println(images.length + " images loaded!");
  frameRate(30);
}

void draw() {
  background(0);


  for (int i = 0; i < images.length; i++) {
    if (random(1) < 0.1) {
      PImage img = images[i];
      PGraphics mask = createGraphics(width, height);
      mask.beginDraw();
      mask.rectMode(CENTER);
      mask.background(0);
      mask.noStroke();
      mask.fill(#ffffff);
      float x = random(width);
      float y = random(height);
      float w = random(width);
      float h = random(height);
      mask.rect(x, y, w, h);
      mask.endDraw();

      img.mask(mask);
      image(img, 0, 0);

      fill(#ffff00);
      noStroke();
      rectMode(CENTER);
    }
  }
  
  dust();

  saveFrame("out/collage###.jpg");

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
    fill(#ffffff);
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
