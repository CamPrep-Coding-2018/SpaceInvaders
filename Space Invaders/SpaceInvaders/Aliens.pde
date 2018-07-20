class Alien{
  
  PVector dims;
  PVector pos;
  
  PVector left;
  PVector right;
  PVector down; 
  
  
  boolean isAlive;
  int hp; 
  int health; 
  float colour; 
  
  int rw;
  int clmn; 
  int count;
  int moves;
  boolean rightleft; 
  boolean bulletLanded;
  
  Alien(int column, int row){
    rw = row;
    clmn = column;
    moves = 8; 
    dims = new PVector(70, 40); 
    pos = new PVector(50 + (column * 125), 80 + (row * 65));
    
    left = new PVector(-20, 0);
    right = new PVector(20, 0);
    down = new PVector(0, 30);
    
    isAlive = true; 
    hp = (int)Math.ceil((5 - row) * 0.6 * diff/2.5); 
    health = hp; 
    count = 0;
    rightleft = true; 
    
  }
  
  void update() {
    if ((count == 0 && rightleft == false) || (count == moves && rightleft == true)) {
      pos.add(down); 
      rightleft = !rightleft; 
    } else if (rightleft) {
      pos.add(right);
      count += 1; 
    } else {
      pos.add(left); 
      count -= 1; 
    }
    
    
  }
  
  void draw() {
   if (isAlive) {
     if (hp - health >= 2){
       fill(255,0,0);
     } else if (hp - health >= 1) {
       fill(255,124,124);
     } else {
       fill(255);
     }
     rect(pos.x, pos.y, dims.x, dims.y); 
     fill(255);
   }
  }
  
  boolean shoot() { 
    boolean shoots = false;
    
    if (isAlive && random(1) < 0.0002 + diff * 0.00025) {
      shoots = true;
    }
    
    return shoots;
  }
  
  
  boolean hitCheck(PVector bullet) {
    bulletLanded = false; 
    if (isAlive && circ_box_collide(bullet, 3, pos, dims)){
      bulletLanded = true; 
      health -= 1; 
    }
    
    if (health <= 0) {
      isAlive = false; 
    }
    
    return bulletLanded; 
  }
  
}
