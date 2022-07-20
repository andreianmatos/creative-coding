final String sketchname = getClass().getName();

import com.hamoid.*;
VideoExport videoExport;

String[] words = {
  ",", ".", "!", ",", ",", ".",
};

int xCoord[] =  new int[words.length];
int yCoord[] =  new int[words.length];

void setup(){
  size(600, 600);
}

void draw() {
  delay(1000);
  background(200);
  
  stroke(80, 0, 0);
  strokeWeight(3);
  
  textSize(50);
  //fill(255, 255, 255);
  fill(0, 0, 0);
  
  for(int x = 0; x < words.length; x++){
    int a = (int)random(50, width-100);
    int b = (int)random(50, height-50);
    xCoord[x] = a;
    yCoord[x] = b;
    text(words[x], a, b);
  }

  for(int x = 0; x < words.length; x++){
    int choice1 = (int)random(0, words.length-1);
    int choice2 = (int)random(0, words.length-1);
    line(xCoord[choice1]+20, yCoord[choice1], 
      xCoord[choice2]+40, yCoord[choice2]);
  }
  saveFrame(); 
}
