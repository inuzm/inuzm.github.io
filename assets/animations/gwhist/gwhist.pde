int framecounter = 0;
int ngen = 0;
ArrayList<PopGen> infect;
int npop = 1;
int maxpop = 1;
int maxant = 1;
int count = 0;
PFont f;

void setup () {
  size(600, 500);

  infect = new ArrayList();
  infect.add(new PopGen(ngen, npop));

  f = createFont("TimesNewRomanPSMT", 30);
  textFont(f);
  textAlign(CENTER, CENTER);
}

void draw () {
  background(0, 43, 54);
  fill(255, 255);
  float ll = 0.5 + float(count)/10;
  String Tinf = "λ = " + ll;
  text(Tinf, width/2, 0.9 * height);
  if (framecounter == 0) {
    ngen++;
    npop = nuevaGen(npop);
    if (npop > maxpop) {maxpop = npop;}
    infect.add(new PopGen(ngen, npop));
  }
  for (PopGen geni : infect) {
    geni.display(ngen, framecounter, maxpop, maxant);
  }
  framecounter++;
  if (framecounter == 60) {
    maxant = maxpop;
    framecounter = 0;
  }
}

class PopGen {
  int gen;
  int pop;

  PopGen (int genin, int popin) {
    gen = genin;
    pop = popin;
  }

  void display (int g, int framec, int maxp, int maxa) {
    float dx = width / ( float(g) + float(framec)/ 60);
    float dy = 0.95 * 60 * 0.8 * height * float(pop) / float(maxa * (60 - framec) + maxp * framec);
    fill(220, 20, 60);
    stroke(255, 150);
    rect(float(gen)*dx, 0.8 * height - dy, dx, dy);
  }
}

int nuevaGen (int popa) {
  int k = 0;
  if (popa > 0) {
    for (int i = 0; i < popa; i++) {
      float lambda = 0.5 + float(count)/10;
      k += rpois(lambda);
    }
  }
  return k;
}

int rpois(float lambda) {
  int n = 0;
  float fx = exp(-lambda);
  float u = random(1);
  float aux = exp(-lambda);
  while (u > fx) {
    aux *= lambda / float(n+1);
    fx += aux;
    n++;
  }
  return n;
}

void mousePressed() {
  count++;
  if (count > 10) {count = 0;}
  for (int i = infect.size() - 1; i > 0; i--) {
    infect.remove(i);
  }
  framecounter = 0;
  ngen = 0;
  npop = 1;
  maxpop = 1;
  maxant = 1;
  infect.add(new PopGen(ngen, npop));
  redraw();
}
