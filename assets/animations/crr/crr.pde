int numGen = 4;
int totPob = 1;
ArrayList<Node> nodos;
int current = 0;
int newnode;
int outerloop = 1;
int innerloop = 0;
float[] ax = new float[numGen];
float[] ay = new float[numGen];
PFont f;

void setup(){
  size(600, 600);
  nodos = new ArrayList<Node>();
  int myid = 0;
  for (int i = 0; i < numGen; i++) {
    for(int j = 0; j < totPob; j++) {
      if (myid == 0) {
        nodos.add(new Node(i, myid, 1, nodos));
      } else {
        nodos.add(new Node(i, myid, 0, nodos));
      }
      myid++;
    }
    totPob *= 2;
  }
  totPob -= 1;
  for (int i = 0; i < totPob; i++) {
    Node mynodo = nodos.get(totPob - 1 - i);
    mynodo.setXY();
  }
  for (int i = 0; i < numGen; i++) {
    Node mynodo = nodos.get(0);
    ax[i] = mynodo.x;
    ay[i] = mynodo.y;
  }
  f = createFont("TimesNewRomanPSMT", 30);
  textFont(f);
  textAlign(LEFT, BOTTOM);
}

void draw(){
  background(0, 43, 54);
  if ( (innerloop == 0) & (outerloop < numGen) ) {
    newnode = selectNode(current);
  }
  if (outerloop < numGen) {
    updateTraj();
  }
  for (Node nodo : nodos){
    nodo.drawLine();
    nodo.drawNode();
  }
  drawTraj();
  String algo = "N = " + numGen;
  fill(255);
  text(algo, 10, 580);
  innerloop++;
  if (innerloop == 120) {
    if (outerloop< numGen) {
      current = newnode;
      Node mynodo = nodos.get(current);
      mynodo.selected = 1;
    }
    outerloop++;
    if (outerloop == numGen + 3) {
      resetDraw();
    }
    innerloop = 0;
  }
}

class Node {
  float x, y;
  float diameter;
  int gen;
  int id;
  int selected;
  //int father;
  ArrayList<Node> others;

  Node(int genin, int idin,int selectedin, ArrayList<Node> oin) {
    //diameter = diameterin;
    gen = genin;
    id = idin;
    selected = selectedin;
    others = oin;
  }

  void setXY() {
    x = 20 + 560 * float(gen) / float(numGen - 1);
    float gaux = 1;
    for (int j = 0; j < numGen - 1; j++) {
      gaux *= 2;
    }
    if ( gen == numGen - 1 ) {
      y = 20 + 560 * (float(id) + 1 - gaux) / (gaux - 1);
    } else {
      Node otro1 = others.get(2*id+1);
      Node otro2 = others.get(2*id+2);
      y = (otro1.y + otro2.y) / 2;
    }
    diameter = min(30, 0.9 * 560 / (gaux - 1));
  }

  void drawNode() {
    noStroke();
    if(selected == 0){
      fill(255, 100);
    } else {
      fill(255);
    }
    ellipse(x, y, diameter, diameter);
  }

  void drawLine() {
    if( gen < numGen - 1 ){
      Node otro1 = others.get(2*id+1);
      Node otro2 = others.get(2*id+2);
      stroke(255, 50);
      strokeWeight(18 / float(numGen));
      line(x, y, otro1.x, otro1.y);
      line(x, y, otro2.x, otro2.y);
    }
  }
}

int selectNode(int lastid) {
  float u = random(1);
  int newid;
  if (u < 0.5){
    newid = 2 * lastid + 1;
  } else {
    newid = 2 * lastid + 2;
  }
  return newid;
}

void drawTraj() {
  stroke(255);
  for (int j = 0; j < numGen - 1; j++) {
    line(ax[j], ay[j], ax[j+1], ay[j+1]);
  }
}

void updateTraj() {
  if (innerloop == 0) {
    for (int i = 1; i < numGen; i++) { ax[i-1] = ax[i]; ay[i-1] = ay[i]; }
  }
  Node nuevonodo = nodos.get(newnode);
  float dx = (nuevonodo.x - ax[numGen-2]) / 120;
  float dy = (nuevonodo.y - ay[numGen-2]) / 120;
  ax[numGen-1] += dx;
  ay[numGen-1] += dy;
}

void resetDraw() {
  current = 0;
  for(int i = 1; i < totPob; i++) {
    Node mynode = nodos.get(i);
    mynode.selected = 0;
  }
  for (int i = 0; i < numGen; i++) {
    Node mynodo = nodos.get(0);
    ax[i] = mynodo.x;
    ay[i] = mynodo.y;
  }
  outerloop = 1;
}

void mousePressed() {
  numGen++;
  if (numGen > 7) {
    numGen = 2;
  }
  totPob = 1;
  current = 0;
  innerloop = 0;
  outerloop = 1;
  float[] ax = new float[numGen];
  float[] ay = new float[numGen];
  nodos = new ArrayList<Node>();
  int myid = 0;
  for (int i = 0; i < numGen; i++) {
    for(int j = 0; j < totPob; j++) {
      if (myid == 0) {
        nodos.add(new Node(i, myid, 1, nodos));
      } else {
        nodos.add(new Node(i, myid, 0, nodos));
      }
      myid++;
    }
    totPob *= 2;
  }
  totPob -= 1;
  for (int i = 0; i < totPob; i++) {
    Node mynodo = nodos.get(totPob - 1 - i);
    mynodo.setXY();
  }
  for (int i = 0; i < numGen; i++) {
    Node mynodo = nodos.get(0);
    ax[i] = mynodo.x;
    ay[i] = mynodo.y;
  }
  resetDraw();
  redraw();
}
