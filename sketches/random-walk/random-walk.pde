PFont f;
int i;
int dir1;
int a1 = -4;
int b1 = 4;
int[] marcas;
int count = 5;
float prob = float(count) / 10;

void setup() {
  size(600, 200);

  f = createFont("TimesNewRomanPSMT", 20);
  textFont(f);
  textAlign(CENTER, CENTER);

  i = 0;
}

void draw() {
  background(0, 43, 54);
  stroke(255);
  fill(255);

  if (i == 0) {
    dir1 = getdir(prob);
    marcas = generarsuc(a1, b1);
  }
  String probita = "p = 0." + count;
  text(probita, width/2, 3*height/4);
  line(0, height/4, width, height/4);
  float tx = -60 - float(dir1) * 1.5 * float(i);
  int j = 0;
  while (tx < width) {
    line(tx, height/4 + 5, tx, height/4 - 5);
    text(marcas[j], tx, height/4 + 25);
    tx += 90;
    j++;
  }
  noStroke();
  fill(255,90);
  ellipse(width/2, height/4, 30, 30);
  i += 1;
  if (i == 60) {
    i = 0;
    a1 += dir1;
    b1 += dir1;
  }
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
}
