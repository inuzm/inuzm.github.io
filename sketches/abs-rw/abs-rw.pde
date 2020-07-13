int mm = minute();
int ss = second();
int hh = hour();
randomSeed(mm + ss + hh);
int i = 0;
PFont f;
int[] marcasx;
int[] marcasy;
int a1 = -1;
int b1 = 7;
int a2 = 0;
int b2 = 10;
float xpart = 30;
float ypart = 300;
float posx;
float posy;
float[] ax = new float[8];
float[] ay = new float[8];
boolean moverx = false;
int count = 5;
float prob = float(count) / 10;
int dir1 = getdir(prob);

void setup () {
  size(600, 650);
  f = createFont("TimesNewRomanPSMT", 20);
  textFont(f);
  textAlign(CENTER, CENTER);

  for (int j = 0; j < 8; j++) {
    ax[j] = 30;
    ay[j] = 300;
  }
}

void draw () {
  background(0, 43, 54);
  stroke(255);
  String probita = "p = 0." + count;
  text(probita, width/2, 625);
  line(30, 30, 570, 30);
  line(30, 570, 570, 570);
  drawticks();
  noStroke();
  ellipse(xpart, ypart, 15, 15);
  stroke(255);
  drawtraj();
  updateparticle();
  updatextraj();
  updateytraj();
  i++;
  if ( i == 60 ) {
    i = 0;
    if (moverx) { a1++; b1++; }
    ypart = round(ypart);
    dir1 = getdir(prob);
  }
}

void updateparticle() {
  if (xpart + 1.5 > 570) {
    moverx = true;
  }
  if (xpart < 570) {
    xpart += 1.5;
  }
  if( (ypart < 570) & (ypart > 30) ){
    ypart -= 0.9 * float(dir1);
  }
}

void drawticks() {
  if (i == 0) {
    marcasx = generarsuc(a1, b1);
    marcasy = generarsuc(a2, b2);
  }
  posx = -60;
  posy = 30;
  if ( xpart == 570 ) {
    posx -= 1.5 * float(i);
  }
  stroke(255, 50);
  fill(255);
  int j = 0;
  while ( posx <= 570 ){
    if (posx >= 30) { line(posx, 30, posx, 570); text(marcasx[j], posx, 585); }
    posx += 90;
    j++;
  }
  j = 0;
  while ( posy <= 570 ){
    if (posy >= 30 ) { line(30, 600-posy, 570, 600-posy); text(marcasy[j], 15, 600-posy); }
    posy += 54;
    j++;
  }
}

void drawtraj() {
  for (int j = 0; j < 7; j++) {
    line(ax[j], ay[j], ax[j+1], ay[j+1]);
  }
}

void updatextraj() {
  if ( xpart < 570 ){
    if (i == 0) {
      for (int j = 1; j < 8; j++) { ax[j-1] = ax[j]; }
    }
    ax[7] = xpart;
  } else {
    for (int j = 1; j < 7; j++) { ax[j] = 30 - 1.5 * float(i) + 90 * float(j); }
  }
}

void updateytraj() {
  if (i == 0) {
      for (int j = 1; j < 8; j++) { ay[j-1] = ay[j]; }
    }
  if( (ypart < 570) & (ypart > 30) ){
    ay[0] += 0.9 * float(getsign(ay[0], ay[1]));
    ay[7] = ypart;
  } else {
    //for (int j = 0; j < 8; j++) { ay[j] += 0.75 * float(dir1); }
    ay[0] += 0.9 * float(getsign(ay[0], ay[1]));
    ay[7] = ypart;
  }
}

int getsign(float a, float b) {
  int signo;
  if (b - a < 0) {
    signo = -1;
  } else {
    if (b - a > 0) {
      signo = 1;
    } else {
      signo = 0;
    }
  }
  return signo;
}

int[] generarsuc(int a, int b) {
  int n = b - a;
  int[] suc;
  suc = new int[n+1];
  for (int k = 0; k < n + 1; k++) {
    suc[k] = a + k;
  }
   return suc;
}

int getdir(float p) {
  float u = random(1);
  int mydir;
  if (u < p) {
    mydir = 1;
  } else {
    mydir = -1;
  }
  return mydir;
}

void mousePressed() {
 count++;
 if (count > 9) {
  count = 1;
 }
 prob = float(count) / 10;
 i = 0;
 a1 = -1;
 b1 = 7;
 a2 = -7;
 b2 = 7;
 xpart = 30;
 ypart = 300;
 moverx = false;
 movery = false;
 for (int j = 0; j < 8; j++) {
   ax[j] = 30;
   ay[j] = 300;
 }
 dir1 = getdir(prob);
}
