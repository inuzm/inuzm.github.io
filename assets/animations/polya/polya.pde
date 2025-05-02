PFont f;
int outerloop = 0;
int rojas = 1;
int azules = 1;
int numBalls = rojas + azules;
float spring = 1;
float gravity = 0.05;
float friction = -0.01;
ArrayList<Ball> balls;
int mybcolor;
int bolaanterior;
int labola;

void setup() {
  size(640, 550);
  balls = new ArrayList<Ball>();
  for (int i = 0; i < numBalls; i++) {
    if(i == 0){
      mybcolor = 0;
    } else {
      mybcolor = 1;
    }
    balls.add(new Ball(random(width), 40 + random(360), 40, i, mybcolor, balls));
  }
  noStroke();
  fill(255, 204);

  f = createFont("TimesNewRomanPSMT", 20);
  textFont(f);
  textAlign(LEFT, CENTER);
}

void draw() {
  background(0, 43, 54);
  stroke(255);
  line(0, 40, 0, 400);
  line(0, 400, width-1, 400);
  line(width-1, 400, width-1, 40);
  fill(255, 0, 0);
  noStroke();
  rect(0, 425, width * float(rojas) / float(numBalls), 50);
  fill(153, 255, 255);
  rect(width * float(rojas) / float(numBalls), 425, width - width * float(rojas) / float(numBalls), 50);
  fill(255);
  String cuentitasr = "R(" + (numBalls-2) + ") = " + rojas;
  String cuentitasa = "A(" + (numBalls-2) + ") = " + azules;
  String peso = "W(" + (numBalls-2) + ") = " + float(rojas) / float(numBalls);
  text(cuentitasr, 30, 490);
  text(cuentitasa, 30, 510);
  text(peso, 30, 530);
  if (outerloop == 0) { labola = chooseBall(); }
  for (Ball ball : balls) {
    ball.collide();
    ball.move();
    ball.display();
  }
  outerloop++;
  if (outerloop == 120) {
    Ball otra = balls.get(labola);
    mybcolor = otra.bcolor;
    if(mybcolor == 0){
      rojas++;
    } else {
      azules++;
    }
    otra.x = random(width);
    otra.vx = 0;
    otra.vy = 0;
    otra.y = 20;
    balls.add(new Ball(random(width), 20, 40, numBalls, mybcolor, balls));
    numBalls++;
    outerloop = 0;
    bolaanterior = labola;
  }
}

class Ball {

  float x, y;
  float diameter;
  float vx = random(-1,1);
  float vy = 0;
  int id;
  int bcolor;
  ArrayList<Ball> others;

  Ball(float xin, float yin, float din, int idin, int bcolorin, ArrayList<Ball> oin) {
    x = xin;
    y = yin;
    diameter = din;
    id = idin;
    bcolor = bcolorin;
    others = oin;
  }

  void collide() {
    for (int i = id + 1; i < numBalls; i++) {
      Ball other = balls.get(i);
      float dx = other.x - x;
      float dy = other.y - y;
      float distance = sqrt(dx*dx + dy*dy);
      float minDist = other.diameter/2 + diameter/2;
      if (distance < minDist) {
        float angle = atan2(dy, dx);
        float targetX = x + cos(angle) * minDist;
        float targetY = y + sin(angle) * minDist;
        float ax = (targetX - other.x) * spring;
        float ay = (targetY - other.y) * spring;
        vx -= ax;
        vy -= ay;
        other.vx += ax;
        other.vy += ay;
      }
    }
  }

  void move() {
    vy += gravity;
    x += vx;
    y += vy;
    if (x + diameter/2 > width) {
      x = width - diameter/2;
      vx *= friction;
    }
    else if (x - diameter/2 < 0) {
      x = diameter/2;
      vx *= friction;
    }
    if (y + diameter/2 > 400) {
      y = 400 - diameter/2;
      vy *= friction;
      vx *= friction;
    }
    else if (y - diameter/2 < 40) {
      if ( ((id != numBalls - 1) & (id != bolaanterior) ) | ( outerloop > 80 ) ){
        y = diameter/2 + 40;
        vy *= friction;
      }
    }
  }

  void display() {
    if (id == labola) { stroke(255, 120 - outerloop); } else {noStroke();}
    if (bcolor == 0){
      if (id == labola) { fill(255, 0, 0, 120 - outerloop); } else { fill(255, 0, 0, 150); }
    } else {
      if (id == labola) { fill(153, 255, 255, 120 - outerloop); } else { fill(153, 255, 255, 150); }
    }
    ellipse(x, y, diameter, diameter);
  }
}

int getColor() {
  float u = random(1);
  int mycolor;
  if ( u < 0.5 ) {
    mycolor = 0; // rojo
  } else {
    mycolor = 1; // azul
  }
  return mycolor;
}

int chooseBall() {
  float u = random(numBalls);
  return int(floor(u));
}

void mousePressed() {
rojas = 1;
azules = 1;
numBalls = rojas + azules;
balls = new ArrayList<Ball>();
for (int i = 0; i < numBalls; i++) {
  if(i == 0){
    mybcolor = 0;
  } else {
    mybcolor = 1;
  }
  balls.add(new Ball(random(width), 40 + random(360), 40, i, mybcolor, balls));
}
outerloop = 0;
redraw();
}
