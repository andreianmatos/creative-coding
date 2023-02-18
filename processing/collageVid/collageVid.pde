import processing.video.*;
import processing.sound.*;
import ddf.minim.*;
import ddf.minim.ugens.*;

import com.hamoid.*;
VideoExport videoExport;

final String sketchname = getClass().getName();

// GLOBAL VARIABLES:
Movie myVideo;

int yes = 1;

import java.io.File;
String[] vidFileNames;
Movie[] videos;

ArrayList<Movie> currentMovies;
ArrayList<PGraphics> currentMasks;

void setup() {
  size(1280,720);
  
  background(250);
  
  java.io.File folder = new java.io.File(dataPath("b"));
  vidFileNames = folder.list();
  
  videos = new Movie[vidFileNames.length];
  currentMovies = new ArrayList<Movie>();
  currentMasks = new ArrayList<PGraphics>();

  println("loading...");
  
  for (int i = 0; i < vidFileNames.length; i++) {
    String filename = vidFileNames[i];
    if (filename.indexOf("Store") == -1) {
      Movie temp = new Movie(this, "b/"+filename); 
      //temp.resize(width, height);
      videos[i] = temp;
      videos[i].loop();
    }
  }
}


void draw() {
    
    background(250);
  
    if(yes == 1) { 
      yes = int(random(100) < 0.1);

      for (int i = currentMovies.size() - 1; i >= 0; i--) {
          currentMasks.remove(i);
          currentMovies.remove(i);
      }
    
    for (int i = 0; i < random(videos.length); i++) {
      if (random(1) < 1) {
        Movie pik = videos[i];
        PGraphics mask = createGraphics(pik.width, pik.height);
        mask.beginDraw();
        mask.rectMode(CENTER);
        mask.background(0);
        mask.noStroke();
        mask.fill(#ffffff);
        float x = random(pik.width);
        float y = random(pik.height);
        float w = random(pik.width);
        float h = random(pik.height);
        mask.rect(x,y,w,h);
        //currentMasks[i] = mask;
        //pik.mask(mask);
        
        //currentMovies[i] = pik;
        currentMovies.add(pik);
        currentMasks.add(mask);

        tint(255, random(255));
        rectMode(CENTER);
        //rotate(PI/random(3.0));
        //pik.resize(int(random(0,pik.width)), int(random(0,pik.height)));
       // noStroke();
        //image(pik, -100, -100);
       
       //if(frameCount%4==0)
       //blendMode(DIFFERENCE);
       //else
       //blendMode(BURN);
  
        //fill(#ffff00);
        //noStroke();
        
        print("One");
        
      }

    }
    }
    else{
      for (int i = 0; i < currentMovies.size(); i++) {
       yes = int(random(100) < 0.1);
       currentMovies.get(i).mask(currentMasks.get(i));
       image(currentMovies.get(i), 0, 0);
      }
    }
    
    rec();
    
    saveFrame("snapsCol/##########.png"); 

}

void movieEvent(Movie m) {
  m.read();
}

void rec() {
  if (frameCount == 1) {
    videoExport = new VideoExport(this, "vids.mp4");
    videoExport.setFrameRate(30);  
    videoExport.startMovie();
  }
  videoExport.saveFrame();
}
