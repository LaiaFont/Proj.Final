String text1="";

PFont font;

int interval = 1000;//timer's interval
int lastRecordedTime = 0;

int cText;
int step;
int jugador;

color track1 = color(254, 252, 187);
color track2 = color(177, 251, 249);
color track3 = color(134, 53, 211);
color track4 = color(255, 255, 255);

ArrayList<String> noms = new ArrayList<String>();
color[] colorsJ = {track1, track2, track3, track4};

void setup() {
  size(displayWidth, displayHeight);
  
  font = createFont("1942.ttf", 128);
  cText = 0;
  step = 1;
  jugador = 1;
}

void draw() {
  if(step == 1) {
    step1();
  } else if (step == 2) {
    step2();
  } else if (step == 3) {
    step3();
  } else if (step == 4) {
    step4();
  }
}

void keyPressed() {
  if(keyCode == ENTER && step == 1) {
    step = 2;
  } else if (step == 2 ) {
    text1+=key;
    if (jugador < 5) {
      if (keyCode == ENTER && !text1.equals("")) {
        noms.add(text1);
        text1 = "";
        jugador++;
      }
    } else {
      jugador = 0;
      step = 3;
    }
  } else if (keyCode == ENTER && step == 3) {
    step = 4;
  }
}

void step1() {
  background(0);
  fill(255);
  textSize(128);
  textAlign(CENTER);
  textFont(font);
  text("Benvinguts jugadors!", width/2, height/3-100);
  text("Ens agradaria saber", width/2, height/2);
  text("el vostre nom", width/2, height/2+150);
  
  if(millis()-lastRecordedTime>interval){
    //change FILL color
   if(cText == 0) {
     cText = 255;
   } else {
     cText = 0;
   }
   //and record time for next tick
   lastRecordedTime = millis(); 
  }
  fill(cText);
  text("Premeu 'Enter'", width/2, height/2+400);
}

void step2() {
  background(0);
  fill(255);
  textSize(128);
  textAlign(CENTER);
  textFont(font);
  
  if (jugador < 5) {
    text("Nom del jugador " + jugador, width/2, height/3-100);
    text(text1, width/2, height/2);
    if(millis()-lastRecordedTime>interval){
      //change FILL color
     if(cText == 0) {
       cText = 255;
     } else {
       cText = 0;
     }
     //and record time for next tick
     lastRecordedTime = millis(); 
    }
    fill(cText);
    text("Premeu 'Enter'", width/2, height/2+400);
  } else {
    jugador = 0;
    step = 3;
  }
}

void step3() {
  background(0);
  fill(255);
  textSize(128);
  textAlign(CENTER);
  textFont(font);
  
  text("Esteu preparats? ", width/2, height/3-150);
  for(int i = 0; i < 4; i++) {
    fill(colorsJ[i]);
    text(noms.get(i), width/2, height/3+(150*i));
    
    if(millis()-lastRecordedTime>interval){
      //change FILL color
     if(cText == 0) {
       cText = 255;
     } else {
       cText = 0;
     }
     //and record time for next tick
     lastRecordedTime = millis(); 
    }
    fill(cText);
    text("Premeu 'Enter'", width/2, height/2+400);
  }
}

void step4() {
  background(0);
}
