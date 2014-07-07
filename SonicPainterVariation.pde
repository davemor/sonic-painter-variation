Maxim maxim;
AudioPlayer player;

class Node {
  int x, y;
  Node(int x, int y) {
    this.x = x;
    this.y = y;
  }
  void draw(int alpha) {    
    float pnx = noise(x + n, y + n) * 50;
    float pny = noise(x + 1 + n, y + 1 + n) * 50;
    strokeWeight(noise(x + n, y + n) * 16);
    
    stroke(colors[0], alpha);
    line(x, y, pnx + x, pny + y);     

    stroke(colors[1], alpha);
    line(-x + width, y, pnx -x + width, pny + y);
    
    stroke(colors[2], alpha);
    line(-x + width, -y + height, pnx -x + width, pny -y + height);

    stroke(colors[3], alpha);
    line(x, -y + height, pnx + x, pny -y + height);
  }
}

float n = 0;
float speed = 0.0f;
ArrayList<Node> line = new ArrayList<Node>();

color [] colors = {
  #F5C62C,
  #F56C2C,
  #89F52C,
  #2CCBF5
};

void setup() {
  size(640, 480);
  noStroke();
  maxim = new Maxim(this);
  player = maxim.loadFile("synth.wav");
  player.setLooping(true);
  player.volume(0.25);
}

void draw() {
  n += speed * speed * 0.2;
  player.setFilter(noise(n, n) * 5000, noise(n,n));
  background(0);
  for(int idx=0; idx < line.size(); ++idx) {
    int alpha = int(map(idx, 0, line.size(), 0, 255));
    line.get(idx).draw(alpha);
  }
}

void mouseDragged() {
  float dist = min(32, dist(mouseX, mouseY, pmouseX, pmouseY));
  line.add( new Node(mouseX, mouseY));
  if(line.size() > 64) {
    line.remove(0); 
  }
  speed = (float) mouseX/width/2;
  player.speed(speed);
  player.play();
}
