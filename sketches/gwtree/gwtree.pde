int maxGen = 5;
int terminalNodes = 0;
int currIdTot = 0;
int currIdGen = 0;
int currGen = 0;
int outerLoop = 0;
int innerLoop = 0;
ArrayList<GalWat> tree;

void setup () {
  size(600, 600);
  tree = new ArrayList<GalWat> ();
  GenerateTree();
}

void draw () {
  background(0, 43, 54);
  for (GalWat node : tree) {
    node.DisplayNode(outerLoop);
    node.DisplayEdge(outerLoop, innerLoop);
  }
  innerLoop++;
  if (innerLoop == 60) {
    outerLoop++;
    if (outerLoop == currGen + 5) {
      ResetTree();
      outerLoop = 0;
    }
    innerLoop = 0;
  }
}

class GalWat {
  int idT, idG;
  int gen;
  int father;
  float x, y;
  boolean termina;
  int idTerm;

  GalWat (int genin, int idTin, int idGin, int fatherin) {
    gen = genin;
    idT = idTin;
    idG = idGin;
    father = fatherin;
  }

  void setTermina () {
    termina = true;
    idTerm = 0;
    for (int i = tree.size() - 1; i > 0; i--) {
      GalWat other = tree.get(i);
      if (other.father == idT) { termina = false; break; }
    }
  }

  void setTerminalId () {
    for (int i = idT+2; i < tree.size(); i++) {
      GalWat other = tree.get(i);
      if (termina & other.termina & (idT != other.idT)) {
        GalWat vnode = tree.get(i);
        GalWat vnode2 = tree.get(idT+1);
        int gen1 = gen;
        int gen2 = other.gen;
        while (gen1 != gen2) {
          if (gen1 < gen2) {
             vnode = tree.get(vnode.father + 1);
          } else {
             vnode2 = tree.get(vnode.father + 1);
          }
          gen1 = vnode2.gen;
          gen2 = vnode.gen;
        }
        if (vnode.idG < vnode2.idG) {idTerm++;} else {other.idTerm++;}
      }
    }
  }

  void setXY (int GG, int nT) {
    if (termina) {
      y = 20 + 560 * float(idTerm + 1) / float(nT + 1);
    } else {
      y = 0;
      int count = 0;
      for (int i = tree.size() - 1; i > 0; i--) {
        GalWat other = tree.get(i);
        if (idT == other.father) {
          y += other.y;
          count++;
        }
      }
      y *= 1/float(count);
    }
    x = 20 + 560 * float(gen + 1) / float(GG + 1);
  }

  void DisplayNode (int currIter) {
    if (gen <= currIter) {
      noStroke();
      fill(255);
      ellipse(x, y, 15, 15);
    }
  }

  void DisplayEdge (int currIter, int currFrame) {
    if ( gen <= currIter & gen > 0 ) {
      stroke(255);
      GalWat node = tree.get(father + 1);
      line(node.x, node.y, x, y);
    } else if (gen == currIter + 1) {
      float tt = float(currFrame) / 60;
      GalWat node = tree.get(father + 1);
      float dx = x * tt + node.x * (1 - tt);
      float dy = y * tt + node.y * (1 - tt);
      stroke(255);
      line(node.x, node.y, dx, dy);
    }
  }
}

void GenerateTree () {
  tree.add(new GalWat(currGen, currIdTot, currIdGen, -1));
  currIdTot = 1;
  for (int i = 0; i < maxGen; i++) {
    currIdGen = 0;
    int genTot = 0;
    for (int j = 1; j < tree.size(); j++) {
      GalWat node = tree.get(j);
      if (node.gen == currGen) {
        int desc = rpois(1.5);
        if (desc == 0) { terminalNodes++; }
        for (int k = 0; k < desc; k++) {
          tree.add(new GalWat(currGen + 1, currIdTot, currIdGen, node.idT));
          currIdTot++;
          currIdGen++;
          genTot++;
          if (i == maxGen - 1) {terminalNodes++;}
        }
      }
    }
    currGen++;
    if (genTot == 0) { break; }
  }

  for (GalWat node : tree) {
    node.setTermina();
  }

  for (GalWat node : tree) {
    node.setTerminalId();
  }

  for (GalWat node : tree) {
    if (node.termina) {
      node.setXY(currGen, terminalNodes);
    }
  }

  for (int ii = tree.size() - 1; ii >= 0; ii--) {
    GalWat node = tree.get(ii);
    node.setXY(currGen, terminalNodes);
  }
}

void ResetTree () {
  for (int i = tree.size() - 1; i > 0; i--) {
    tree.remove(i);
  }
  terminalNodes = 0;
  currIdTot = 0;
  currIdGen = 0;
  currGen = 0;
  GenerateTree();
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
