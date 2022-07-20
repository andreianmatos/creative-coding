// 80 * 80 = 640
// 60 * 80 = 480
int videoScale = 80;

int cols, rows;

/*String[] words = {
  "poeta", "arca", "seta","haste","agulha","chama","faulha","cisco", "limo", "limbo", "inferno",
  "flor", "amor", "seta", "arca", "poeta", "montanha"
};*/

String[] words = {
  "janela", "chá", "toque", "dedos", "neve", "sesta"
};


void setup() {
  size(400, 400); //400

  cols = width/videoScale;
  rows = height/videoScale;
}

void draw() {
  
  delay(1000);

  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {

      int x = i*videoScale;
      int y = j*videoScale;
      //strokeWeight(0.5);
      //stroke(80, 0, 0);
      //fill(200);º
      strokeWeight(1);
      stroke(60, 0, 0);
      fill(90);
      rect(x, y, videoScale, videoScale);
      if(random(0, cols*rows)>(cols*rows/2))
        fill(250, 250, 250);
        textSize(20);
        text(words[(int)random(0, words.length-1)], x+5, y+videoScale-5);
    }
  }
     saveFrame(); 

}
