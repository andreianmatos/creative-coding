// retalhos recombinados de poemas de Judith Teixeira
// em ocasião do aniversário da sua morte
// a completar quando tiver em minha posse a sua colectânea (em Viseu)

final String sketchname = getClass().getName();

import com.hamoid.*;
VideoExport videoExport;

PFont font1;
PFont font2;


color bg = color(139, 7, 7);
color fg = color(188,101,101);

String[] retalhos = {
  "Tu estás doente meu amor, porquê?", "Falta-te o sol, a luz, o meu sabor?", 
  "Se és tu o sol, a graça, essa mercê", "Beijemo-nos, meu bem, ardentemente...",
  "Já não me importo com o teu amor.", "Não julgues, não, que me esqueceste,",
  "que mentes!", "Eu estou na tua alma", "Podes ter os amores que quiseres,",
  "Sim, vou partir.", "Nem em ti penso agora!", "Eu sei amar,", "- e o hábito faz lei!",
  "Choro?! Oh, sim , perdidamente!", "A esquecer-me da vida -", "E o meu olhar ansioso",
  "E as tuas lindas mãos,", "- Sensualizando a vida,", "Devagar...", "Mais beijos!...",
  "Que estranha fantasia!", "Alvorada!", "as rosas encarnadas,", "Vem acordar-me!", 
  "que sou culpada dos teus tristes dias;", "e escrevias-me cartas tão banais!...",
  "vejo-te diferente…", "Como eu fui tua! Hoje é sem sabor", "Vens toda nua, recortada em graça",
  "Visão bendita!", "Abram-se as portas do inferno", "– E que o vento e as ondas,"
};

void setup(){
  size(600, 600);
  //font1 = createFont("Tomatoes-O8L8.ttf", 128);
  //font2 = createFont("LucySaidOkPersonalUseItalic-OV9ee.ttf", 128);
}

void draw() {
  delay(1000);
  background(139, 7, 7);
  
  dust();  
  
  strokeWeight(3);
  
  textSize(20);
  fill(188,101,101);
  //fill(0, 0, 0);
  
  for(int x = 0; x < random(1, retalhos.length); x++){
    text(retalhos[int(random(0, retalhos.length))], 100, 100+20*x);
  }
  
  saveFrame(); 
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
