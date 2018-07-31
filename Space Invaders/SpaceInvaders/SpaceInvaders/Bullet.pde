class Bullet {

  PVector pos;
  PVector speed;
  PVector aspeed;

  Bullet(PVector position) {
    pos = position;
    pos.x += 45; 
    speed = new PVector(0.0, -7 + (int)(diff * 0.7)); 
    aspeed = new PVector(0, 6 + diff * 1.5);
  }

  void draw() {
    ellipse(pos.x, pos.y, 6, 12);
  }

  void update() {
    pos.add(speed);
  }

  void alienupdate() {
    pos.add(aspeed);
  }
}
