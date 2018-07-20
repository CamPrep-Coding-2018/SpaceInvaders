class Agent{
  PVector pos;
  PVector left;
  PVector right; 
  boolean bulletLanded = false; 
  PVector dims;
  int health;
  boolean isAlive = true; 
  
  Agent() {
    
    pos = new PVector(605, 740);
    left = new PVector(-6 + (-0.9 * (3-diff)),0); 
    right = new PVector(6 + (0.9 * (3-diff)),0); 
    dims = new PVector(90,40);
    health = 3; 
    
  }
  
  void draw() {
    if (isAlive){
      rect(pos.x, pos.y, dims.x, dims.y);
    }
    
    for(int i = 0; i < health; i++) {
      rect(30 + 50 * i, 730,dims.x / 2, dims.y / 2); 
    }
    textSize(40);
    textAlign(CENTER,CENTER);
    text("LIVES", 80, 700);
  }
  
  void update(boolean leftOrRight) {
    if (leftOrRight) {
      pos.add(left);
    } else {
      pos.add(right);
    }
  }
  
    boolean hitChecks(PVector bullet) {
    bulletLanded = false; 
    
    if (circ_box_collide(bullet, 3, pos, dims)){
      bulletLanded = true; 
      health -= Math.sqrt(2/diff); 
    }
    
    if (health <= 0) {
      isAlive = false; 
    }
    
    return bulletLanded; 
  }
  
}
