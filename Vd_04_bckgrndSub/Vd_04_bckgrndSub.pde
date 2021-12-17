import processing.video.*;

Capture cam;
//llindar (de diferència)
int llindar=10000;
//Array bidimensional per guardar el fons
color pixelsFons[][];

PImage idle;
PImage mirror;

void setup() {
  fullScreen();
  idle = loadImage("idle.png");
  mirror = loadImage("mirall.png");
  String[] cameras = Capture.list();

  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    println("Available cameras:");
    printArray(cameras);


    // The camera can be initialized directly using an element
    // from the array returned by list():
    cam = new Capture(this, cameras[0]);
    // Or, the settings can be defined based on the text in the list
    //cam = new Capture(this, 640, 480, "Built-in iSight", 30);

    // Start capturing the images from the camera
    //cam = new Capture(this, 640, 360, cameras[0], 30);
    // Start capturing the images from the camera
    cam.start();
  }
  //inicialitzem l'array que guardarà els colors de fons
  pixelsFons = new color[cam.width][cam.height];
  grabaElFons();
}

void draw() {
  if (cam.available() == true) {
    cam.read();
      //grabaElFons();

  }
  
  int count = 0;
  
    background(0);
    //carreguem a memòria les dades de color amb les que treballarem
    cam.loadPixels();
    loadPixels();
    //cambiem el llindar segons el ratolí
    llindar = mouseX;
    
    
  //doble bucle
      for (int x=0; x<cam.width; x++) {
      for (int y=0; y<cam.height; y++) {
        
        color c = cam.get(x,y);
        color fons =  pixelsFons[x][y];
        
        //calculem la distància entre el color de fons i el píxel actual
        float distanciaColors = dist(red(c), green(c), blue(c), red(fons), green(fons), blue(fons));
        //si la distància supera el llindar... 
        if (distanciaColors > llindar) {
          //dibuixem aquest píxel de color vermell
          set(x, y, color(255, 0, 0));
          count ++;
        }
      }
    }
    if (count>15000){
      image(mirror,0,0,1920,1080);
    }
    else{
    image(idle,0,0,1920,1080);
    }
    println("total: " + count);
}


void mousePressed() {
  grabaElFons();
  println("llindar --> " + llindar);
}


//Guardem el fotograma en aquest moment
void grabaElFons() {
  //Bucle doble
  for (int x=0; x<cam.width; x++) {
    for (int y=0; y<cam.height; y++) {
      //guardem el valor d'aquest píxel
      color c = cam.get(x,y); //mov.pixels[pos];
      pixelsFons[x][y]=c;
    }
  }
}
