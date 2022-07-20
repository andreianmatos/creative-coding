int age = 34;
String text = "hey internet!";
PImage img;

void setup() {
  size(500,500);
  img = loadImage("IMAGE.jpg");
  img.resize(500,500);
  //frameRate(10);
}

void draw() {
  background(255);
  
  fill(0);
  noStroke();
  
  float tiles = mouseX/10;
  float tileSize = width/tiles;
  
  translate(tileSize/2, tileSize/2);
  
  for(int x = 0; x < tiles; x++) {
      for(int y = 0; y < tiles; y++) {
        
        color c = img.get(int(x*tileSize), int(y*tileSize));
        
        float size = map(brightness(c), 0, 255, tileSize, 0);
        
        square(x*tileSize, y*tileSize, size);
      }
  }
  
}
