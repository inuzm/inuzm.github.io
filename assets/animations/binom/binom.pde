int count = 1;
PFont f;
float prob = 0.5;
int xaux;
int maxt = 0;
int x = 0;
int i = 0;
ArrayList<Exper> trials;

void setup() {
  size(600, 300);

  f = createFont("TimesNewRomanPSMT", 30);
  textFont(f);
  textAlign(CENTER, CENTER);

  trials = new ArrayList<Exper>();
  for (int j = 0; j < count; j++) {
    xaux = rbern(0.5);
    trials.add(new Exper(j, xaux, 0));
    x += xaux;
  }
  setxyd();

  frameRate(2);
}

void draw () {
  background(0, 43, 54);
  textSize(30);
  fill(255, 255);
  String Tinf = "X = " + x + ",    n = " + count;
  text(Tinf, width/2, 50);
  if(i < count){
    Exper ntrial = trials.get(i);
    ntrial.rell = 255;
  }
  for (Exper tri : trials ){
    tri.display();
  }
  i++;
  if(i == count + 10) { i = 0; reseteo(); }
}

class Exper {
  float x, y;
  int idt;
  int succ;
  float rell;
  float diam;

  Exper(int idtin, int succin, int rellin) {
    idt = idtin;
    succ = succin;
    rell = rellin;
  }

  void display () {
    noStroke();
    if(succ == 0){
      fill(220, 20, 60, rell);
    } else {
      fill(41, 171, 135, rell);
    }
    ellipse(x, y, diam, diam);
    fill(255, rell);
    textSize(0.5 * diam);
    text(succ, x, y);
  }
}

void setxyd () {
  for (int j = trials.size()-1; j >= 0; j--) {
    Exper trial = trials.get(j);
    trial.y = 200;
    trial.x = width * float(trial.idt + 1) / float(count + 1);
    trial.diam = 0.8 * (min(80, 300 / float(count + 1), width/float(count + 1) ));
  }
}

void reseteo () {
  for(int j = trials.size() - 1; j >= 0; j--){
    trials.remove(j);
  }
  x = 0;
  for (int j = 0; j < count; j++) {
    xaux = rbern(0.5);
    trials.add(new Exper(j, xaux, 0));
    x += xaux;
  }
  setxyd();
}

int rbern(float p){
  int x = 0;
  float u = random(1);
  if (u < p) { x++; }
  return x;
}

void mousePressed() {
 count++;
 if (count > 10) {
  count = 1;
 }
 reseteo() ;
 i = 0;
 redraw();
}
