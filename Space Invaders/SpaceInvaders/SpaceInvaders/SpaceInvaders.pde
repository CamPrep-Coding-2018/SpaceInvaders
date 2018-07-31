float diff = 3;
int rows = 5;
int cols = 9; 
int count = 0; 
int pcount = 0;
boolean move; 
boolean leftright; 
ArrayList<Integer> time = new ArrayList<Integer>(); 
Alien[][] enemies = new Alien[cols][rows];  
Agent player = new Agent(); 
ArrayList<Bullet> b = new ArrayList<Bullet>(); 
ArrayList<Bullet> alienb = new ArrayList<Bullet>(); 
ArrayList<Bullet> remove = new ArrayList<Bullet>();
ArrayList<Bullet> alienremoveb = new ArrayList<Bullet>();
boolean aliveEnemies; 
boolean loss = false; 
boolean timeCheck = true;
int milis;

PImage alien1;
PImage alien2;
PImage alien3;
PImage alien4;

void setup() {
  size(1300, 800, P2D);
  alien1 = loadImage("alien1.png");
  alien2 = loadImage("alien2.png");
  alien3 = loadImage("alien3.png");
  alien4 = loadImage("alien4.png");
  for (int k = 0; k < cols; k ++) {
    for (int r = 0; r < rows; r ++) {
      enemies[k][r] = new Alien(k, r);
      enemies[k][r] = new Alien(k, r);
    }
  }
  time.add(0);
}

void draw() {
  noStroke();
  if (!aliveEnemies) { 
    fill(0, 40);
  } else {
    fill(0, 90);
  }
  rect(0, 0, width, height);
  fill(255);
  aliveEnemies = false; 
  pcount = count; 
  count = 0; 
  for (int i = 0; i < cols; i ++) {
    for (int j = 0; j < rows; j ++) {

      if (enemies[i][j].isAlive) {
        aliveEnemies = true; 
        count++;
      }
      if (frameCount % ((55 - ((diff * 6) + Math.floor(0.4 *(45 - pcount))))) == 0 || (loss && frameCount % 3 == 0) ) {
        enemies[i][j].update();
      }
      if (enemies[i][j].shoot()) {
        alienb.add(new Bullet(PVector.add(enemies[i][j].pos, new PVector(0, random(40)))));
      }
      enemies[i][j].draw();
      if (enemies[i][j].pos.y > 660 && enemies[i][j].isAlive) { 
        textAlign(CENTER, CENTER);
        textSize(78);
        text("YOU HAVE BEEN INVADED", width/2, height/2 + 100);
        loss = true;
      }
    }
  }
  pcount = 0; 
  if (move) {
    player.update(leftright);
  }

  player.draw(); 

  if (!player.isAlive || loss) {
    textAlign(CENTER, CENTER);
    textSize(128);
    text("YOU LOSE", width/2, height/2); 
    loss = true;
  }

  for (Bullet bs : b) {
    if (bs.pos.y <= 0) {
      remove.add(bs);
    } else if (player.isAlive) {
      bs.update();
      bs.draw();
    }
  }


  for (Bullet shots : alienb) {
    if (shots.pos.y >= 800) {
      alienremoveb.add(shots);
    } else {
      shots.alienupdate();
      shots.draw();
    }
    if ((player.pos.x - shots.pos.x) * (player.pos.x - shots.pos.x) < 16000 
      && shots.pos.y < player.pos.y + 50 && shots.pos.y + 100 > player.pos.y ) {
      if (player.hitChecks(shots.pos)) {
        // remove bs here
        alienremoveb.add(shots);
      }
    }
  }

  for (int i = 0; i < cols; i ++) {
    for (int j = 0; j < rows; j ++) { 
      for (Bullet bs : b) {
        if (((enemies[i][j].pos.x - bs.pos.x) * (enemies[i][j].pos.x - bs.pos.x) < 4901) 
          && (bs.pos.y > enemies[i][j].pos.y) && (bs.pos.y < enemies[i][j].pos.y + 110)) {
          if (enemies[i][j].hitCheck(bs.pos)) {
            remove.add(bs);
          }
        }
      }
    }
  }

  for (Bullet toRemove : remove) {
    b.remove(toRemove);
  }

  for (Bullet toRemove : alienremoveb) {
    alienb.remove(toRemove);
  }

  if (!aliveEnemies) { 
    if (timeCheck) {
      timeCheck = false;
      milis = millis();
    }
    textAlign(CENTER, CENTER);
    textSize(120);
    text("YOU WIN!", width/2, height/2); 
    diff = -4;
    for (int i = 0; i * i < (millis() - milis)/1000; i++) {
      b.add(new Bullet(new PVector(random(1300), random(200, 800))));
    }
  }
}


void keyReleased() {
  if (!keyPressed) { 
    move = false;
  } else if (keyCode == LEFT || keyCode == RIGHT) {
    move = false;
  }
}

void keyPressed() {
  if (keyCode == LEFT || keyCode == RIGHT) {
    move = true;
    if (keyCode == RIGHT) {
      leftright = false;
    } else if (keyCode == LEFT) {
      leftright = true;
    }
  } else if (key == ' ') {
    if (millis() - time.get(time.size() - 1) > (diff * 55) + 140) {
      b.add(new Bullet((player.pos).copy()));
      time.add(millis());
    }
  }
}


void mousePressed() {
  if (millis() - time.get(time.size() - 1) > (diff * 55) + 180) {
    b.add(new Bullet((player.pos).copy()));
    time.add(millis());
  }
}
