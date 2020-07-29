PFont f;
int numBalls = 1;
float spring = 0.1;
float gravity = 0.1;
float friction = -0.3;
Ball[] balls = new Ball[numBalls];
int conteo = 0;
int[] lado = new int[numBalls];
int mover;
int loopcount = 0;

void setup() {
  size(640, 450);
  for (int i = 0; i < numBalls; i++) {
    lado[i] = chooseSide();
    if ( lado[i] == 0 ){
      conteo++;
    }
    if (lado[i] == 0) {
      balls[i] = new Ball(random(width/2 - 30), random(360), 30, i, balls);
    } else {
      balls[i] = new Ball(width - random(width/2 - 30), random(360), 30, i, balls);
    }
  }
  f = createFont("TimesNewRomanPSMT", 30);
  textFont(f);
  textAlign(CENTER, CENTER);
}

void draw() {
  background(0, 43, 54);
  stroke(255);
  line(0, 0, 295, 0);
  line(295, 0, 295, 160);
  line(295, 160, 345, 160);
  line(345, 160, 345, 0);
  line(345, 0, 640, 0);
  line(639, 0, 639, 360);
  line(640, 360, 345, 360);
  line(295, 360, 295, 200);
  line(295, 200, 345, 200);
  line(345, 200, 345, 360);
  line(0, 0, 0, 360);
  line(0, 360, 295, 360);
  fill(255);
  textSize(30);
  text("A", 15, 375);
  text("B", 625, 375);
  String bolas = "N = " + numBalls;
  String cadena = "Valor de la cadena: " + conteo;
  text(bolas, width/2, 385);
  text(cadena, width/2, 425);
  if ( loopcount == 0 ) { mover = chooseBall(); }
  for (Ball ball : balls) {
    ball.collide();
    ball.move();
    ball.display();
  }
  loopcount++;
  if (loopcount == 160) {
    if ( lado[mover] == 0 ) {
      conteo -= 1;
    } else {
      conteo += 1;
    }
  }
  if (loopcount == 180) {
    if ( lado[mover] == 0 ) {
      lado[mover] = 1;
    } else {
      lado[mover] = 0;
    }
    loopcount = 0;
  }
}

class Ball {

  float x, y;
  float diameter;
  float vx = 0;
  float vy = 0;
  int id;
  Ball[] others;

  Ball(float xin, float yin, float din, int idin, Ball[] oin) {
    x = xin;
    y = yin;
    diameter = din;
    id = idin;
    others = oin;
  }

  void collide() {
    for (int i = id + 1; i < numBalls; i++) {
      float dx = others[i].x - x;
      float dy = others[i].y - y;
      float distance = sqrt(dx*dx + dy*dy);
      float minDist = others[i].diameter/2 + diameter/2;
      if (distance < minDist) {
        float angle = atan2(dy, dx);
        float targetX = x + cos(angle) * minDist;
        float targetY = y + sin(angle) * minDist;
        float ax = (targetX - others[i].x) * spring;
        float ay = (targetY - others[i].y) * spring;
        if ( id != mover ){
          vx -= ax;
          vy -= ay;
        }
        if ( i != mover ){
          others[i].vx += ax;
          others[i].vy += ay;
        }
      }
    }
  }

  void move() {
    if (id != mover) {
      x += vx;
      y += vy;
      if (x + diameter/2 > width) {
        x = width - diameter/2;
        vx *= friction;
      } else if (x - diameter/2 < 0) {
        x = diameter/2;
        vx *= friction;
      } else if ( (x - vx < width/2 - 25) & (x - vx + diameter/2 > width/2 - 25) ) {
        x = width/2 - diameter/2 - 25;
        vx *= friction;
      } else if ( (x - vx > width/2 + 25) & (x - vx - diameter/2 < width/2 + 25) ) {
        x = width/2 + diameter/2 + 25;
        vx *= friction;
      }
      if (y - vy + diameter/2 > 360) {
        y = 360 - diameter/2;
        vy *= friction;
      } else if (y - diameter/2 < 0) {
        y = diameter/2;
        vy *= friction;
      }
    } else {
      if (loopcount == 0) {
        vy = (180 - y) / 60;
        vx = 0;
      } else if (loopcount == 60) {
        vy = 0;
        if (lado[id] == 0) { vx = (380 - x) / 100; } else { vx = (260 - x) / 100; }
      } else if (loopcount == 160) {
        if (lado[id] == 0) { vx = random(1); } else { vx = -random(1); }
        vy = getYVel();
      }
      y += vy;
      x += vx;
    }
  }

  void display() {
    noStroke();
    if ( id != mover ){
      fill(255, 150);
    } else {
      fill(255, 0, 0, 150);
    }
    ellipse(x, y, diameter, diameter);
    textSize(0.5 * diameter);
    fill(0);
    text(id, x, y);
  }
}

int chooseSide() {
  float u = random(1);
  int side;
  if (u < 0.5) {
    side = 0;
  } else {
    side = 1;
  }
  return side;
}

int chooseBall() {
  float u = float(numBalls) * random(1);
  return int( floor(u));
}

float getYVel() {
  return random(-1, 1);
}

void mousePressed() {
  numBalls++;
  conteo = 0;
  loopcount = 0;
  for (int i = 0; i < numBalls; i++) {
    lado[i] = chooseSide();
    if ( lado[i] == 0 ){
      conteo++;
    }
    if (lado[i] == 0) {
      balls[i] = new Ball(random(width/2 - 30), random(360), 30, i, balls);
    } else {
      balls[i] = new Ball(width - random(width/2 - 30), random(360), 30, i, balls);
    }
  }
  redraw();
}
