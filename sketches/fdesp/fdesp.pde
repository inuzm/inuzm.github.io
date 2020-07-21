int totClients = 0;
int innerloop = 0;
int outerloop = 1;
int otroloop = 0;
ArrayList<Cliente> clientes;
float lambda1 = 1;
PFont f;
String cadena;
boolean quitar = true;

void setup() {
  size(600,700);

  clientes = new ArrayList<Cliente>();
  clientes.add(new Cliente(totClients, 30, 255, clientes));
  totClients++;
  f = createFont("TimesNewRomanPSMT", 30);
  textFont(f);
  textAlign(LEFT, CENTER);
  cadena = "X(" + otroloop + ") = " + totClients;
}

void draw() {
  background(0, 43, 54);
  drawQueu();
  String lambdas = "λ = " + lambda1;
  fill(255);
  text(lambdas, 10, 625);
  text(cadena, 10, 675);
  if (innerloop == 0){
    int agregar = rpois(lambda1);
    for (int i = 0; i < agregar; i++) {
        clientes.add(new Cliente(totClients, 30, 0, clientes));
        totClients++;
    }
  }
  for (int i = clientes.size() - 1; i >= 0; i--) {
    Cliente client = clientes.get(i);
    if ( outerloop == 2 & quitar ) {
      client.reducerelleno();
    } else {
      client.aumentarelleno();
    }
    if (outerloop == 3) {
      client.updatepos();
    }
    client.display();
  }
  innerloop++;
  if (innerloop % 60 == 0) {
    if (innerloop == 60) {
      outerloop++;
    } else if (innerloop == 120) {
      for (int i = clientes.size() - 1; i >= 0; i--) {
        Cliente client = clientes.get(i);
        if (client.finished()) { clientes.remove(i); totClients--; }
      }
      otroloop++;
      cadena = "X(" + otroloop + ") = " + totClients;
      outerloop++;
    } else if (innerloop == 240) {
      for(Cliente client : clientes) {
        client.reseteo();
      }
      if (totClients == 0) {quitar = false;} else {quitar = true;}
      innerloop = 0;
      outerloop = 1;
    }
  }
}

class Cliente {
  float x, y, xn, yn;
  int id, idn;
  float dx, dy;
  float diameter;
  ArrayList<Cliente> others;
  float relleno;

  Cliente(int idin, float diamin, float rellin, ArrayList<Cliente> oin){
    id = idin;
    idn = idin - 1;
    diameter = diamin;
    x = setx(id);
    xn = setx(id-1);
    y = sety(id);
    yn = sety(id-1);
    dx = (xn - x) / 120;
    dy = (yn - y) / 120;
    others = oin;
    relleno = rellin;
  }

  void reducerelleno() {
    if (id == 0){
      relleno -= 255 / 60;
    } else {
      relleno = min(255, relleno + 255/120);
    }
  }

  void aumentarelleno() {
    relleno = min(255, relleno + 255/120);
  }

  boolean finished() {
    if ( (id == 0) & quitar ){
      return true;
    } else {
      return false;
    }
  }

  void reseteo() {
    if (quitar) {
      id--;
      idn--;
      x = setx(id);
      xn = setx(id-1);
      y = sety(id);
      yn = sety(id-1);
      dx = (xn - x) / 120;
      dy = (yn - y) / 120;
    }
  }

  void updatepos() {
    if (quitar) {
      x += dx;
      y += dy;
    }
  }

  void display() {
    noStroke();
    fill(255, relleno);
    ellipse(x, y, diameter, diameter);
  }
}

float setx(int idin) {
  float posx = 20;
  if ( idin <= 99 ) {
    if ( floor(idin / 10) % 2 == 0 ){
      posx += 560 * float(idin % 10) / 9;
    } else {
      posx += 560 * float(9 - (idin % 10)) / 9;
    }
  } else {
    posx += 560 * float(99-idin) / 9;
  }
  return posx;
}

float sety(int idin) {
  float posy = 20;
  if ( idin > 99 ) {
    idin = 99;
  }
  int ddy = floor(idin / 10);
  posy += 560 * float(ddy) / 9;
  return posy;
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

void drawQueu() {
  float anchor = 20 + 560 / 18;
  float ddx = 560 / 9;
  float yy = 20 + 560 / 18;
  int myid = 0;
  noStroke();
  fill(108, 113, 196);
  rect(0,0,anchor,anchor);
  stroke(255);
  while (yy < 600) {
    if (myid % 2 == 0) {
      line(0, yy, width-anchor, yy);
    } else {
      line(anchor, yy, width, yy);
    }
    yy += ddx;
    myid++;
  }
  line(0, 0, 0, yy-ddx);
  line(0, yy, width-1, yy);
  line(width-1, yy, width-1, 0);
  line(width-1, 0, 0, 0);
}

void mousePressed() {
  lambda1++;
  if(lambda1 > 9) {
    lambda1 = 1;
  }
  for (int i = clientes.size() - 1; i >= 0; i--) {
    clientes.remove(i);
  }
  totClients = 0;
  clientes.add(new Cliente(totClients, 30, 255, clientes));
  totClients++;
  innerloop = 0;
  outerloop = 1;
  otroloop = 0;
  cadena = "X(" + otroloop + ") = " + totClients;
}
