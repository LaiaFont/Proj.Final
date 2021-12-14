import processing.video.*;

Capture cam;
//color a buscar
color trackColor;
//valores de color
float trackRed, trackGreen, trackBlue;

PImage originImg;
PImage paint;

color track1 = color(254, 252, 187); //llum clauer + verd fosforito + paper de mocador
color track2 = color(177, 251, 249);
color track3 = color(134, 53, 211);

int time = 10000; //10 seg
int lastTime = 0;

float percent = 0;

float r = 0;
float g = 0;
float b = 0;

void setup() {
  size(640, 360);

  // The camera can be initialized directly using an element
    // from the array returned by list():
    cam = new Capture(this, "pipeline:autovideosrc");
    // Or, the settings can be defined based on the text in the list
    //cam = new Capture(this, 640, 480, "Built-in iSight", 30);

    // Start capturing the images from the camera
    //cam = new Capture(this, 640, 360, cameras[0], 30);
    // Start capturing the images from the camera
    cam.start();
    background(#ffffff);
    paint = loadImage("dibuix_negre.png");
    originImg = loadImage("dibuix.png");
    image(paint, 0, 0);
    noStroke();
    noSmooth();
   
}

void draw() {
  if (cam.available() == true) {
    cam.read();
  }
  //image(cam, 0, 0);
  //variables per guardar el valor més proper al color que busquem
  float recordDist= 1000;
  int recordX=0;
  int recordY=0;
  //Doble bucle
  for (int x=0; x<cam.width; x++) {
    for (int y=0; y<cam.height; y++) {
      //llegim el color del píxel
      color c = cam.get(x, y);
      //calculem la distancia al color que busquem
      float distanciaColors = dist(red(c), green(c), blue(c), trackRed, trackGreen, trackBlue);
      //si la distancia és menor a la que tenim guardada com a récord...
      if (distanciaColors <= recordDist) {
        //guardamos el valor d'ara
        recordDist = distanciaColors;
        //i la posició a X
        recordX = x;
        //i a Y
        recordY = y;
      }//fi del condicional
    }
  }//fi del bucle doble 
  
  recordX = width-recordX; //girar sentit dibuix
  
  //Dibuixem una ellipse al punt en qüestió
  //trackColor = #000000;
  
  if(millis()-lastTime > time){  
      compareImage(); //function to compare drawing with image
      int counter = 0;
      for (int i = 0; i < width; i++) {
        for (int j = 0; j < height; j++) {
          color actual = get(i,j);
          r += red(actual);
          g += green(actual);
          b += blue(actual);
          counter ++;
        }
      }
       
                
          fill(color(r/counter, g/counter, b/counter));
         // ellipse(width/2, height/2, 100, 100);
      r = 0;
      g = 0;
      b = 0;
      if (percent > 50) {
        println("Nice");
      } else {
        println("Lost");
      }
      lastTime = millis();
  } else {
   // println(millis()-lastTime);
    trackRed=red(track2);
    trackGreen=green(track2);
    trackBlue=blue(track2);
    //println("r:"+trackRed+"g:"+trackGreen+"b:"+trackBlue);
    
    fill(track2);
    ellipse(recordX, recordY, 10, 10);
  }
  
}

void mousePressed() {
  trackColor = get(mouseX, mouseY);
  trackRed=red(trackColor);
  trackGreen=green(trackColor);
  trackBlue=blue(trackColor);
  println("r:"+trackRed+"g:"+trackGreen+"b:"+trackBlue);
}

float compareImage() {
  percent = 0;
  int count = 0;
  
  for (int i = 0; i < width; i++) {
      for (int j = 0; j < height; j++) {
        color orig = originImg.get(i,j);
        if (red(orig) == 177) {
          count++; //3600
        }
        
        color actual = get(i,j);        
      
         if (red(orig) == red(actual) && red(orig) != 255) {
           percent ++;
        }
      }
    }
   return percent*100/count;
}
