int count = 3;
PFont f;
float prob = float(count) / 10;
int x = getpruebas(prob);
int i = 0;
float stepx = 600 / float(x + 1);
int mm = minute();
int ss = second();
int hh = hour();
randomSeed(mm + ss + hh);

void setup() {
  size(600, 300);

  f = createFont("TimesNewRomanPSMT", 30);
  textFont(f);
  textAlign(CENTER, CENTER);

  frameRate(3);
}

void draw() {
  background(0, 43, 54);
  fill(255);

  String proba = "p = 0." + count;
  text(proba, 100, 50);

  String rvX = "X = " + x;
  text(rvX, 500, 50);

  float posx = 0;
  float radio = min(0.9 * 100, 0.9 * stepx);
  noStroke();
  fill(220, 20, 60);
  for (int j = 0; j < min(i, x); j++) {
    posx += stepx;
    if (j == x-1) {
      fill(41, 171, 135);
    }
    ellipse(posx, 200, radio, radio);
  }
  i++;

  if(i == x + 6) { i = 0; }
}

int getpruebas(float p) {
  int pruebas = 0;
  boolean exito = false;
  float u;
  while(!exito) {
    u = random(1);
    if(u < p) { exito = true; }
    pruebas += 1;
  }
  return pruebas;
}

void mousePressed() {
 count++;
 if (count > 9) {
  count = 1;
 }
 prob = float(count) / 10;
 x = getpruebas(prob);
 stepx = 600 / float(x + 1);
 i = 0;
 redraw();
}

void keyPressed() {
  if (key == ENTER) {
    prob = float(count) / 10;
    x = getpruebas(prob);
    stepx = 600 / float(x + 1);
    i = 0;
    redraw();
  }
}
