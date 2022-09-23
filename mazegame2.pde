//VARIABLES
float xpos, ypos, trix, r, g, b;
boolean up, down, left, right, shuffle;
int score;
Wall[] walls;
int numWalls = 80;

void setup(){
  size(500,400);
  r = 15;
  g = 162;
  b = 219;
  background(r,g,b);
  score = 0;
  xpos = 250;
  ypos = 390;
  trix = int(random(3,497));
  
  walls = new Wall[numWalls];
  for(int i = 0; i < walls.length; i++){
    int x = int(random(0,2));
    if(x == 1){
      walls[i] = new Wall();
    } else {
      walls[i] = new Wall(random(15, 25));
    }
  }
}

void draw(){
  background(r,g,b);
  fill(255);
  stroke(255);
  ellipse(xpos, ypos, 10, 10);
  
  for(int i = 0; i < walls.length; i++){
    walls[i].display();
    walls[i].move();
    walls[i].touch();
  }
  
  movingBall();
  
  boundary();
  
  //DIAMOND / GOAL
  fill(255,237,41);
  stroke(255,237,41);
  strokeWeight(3);
  triangle(trix,0, trix-3,4, trix+3,4);
  triangle(trix,10, trix-3,6, trix+3,6);
  
  //RESTART BUTTON
  fill(255,34,18);
  stroke(255,34,18);
  rect(5,378, 105,15);
  textSize(11);
  fill(255);
  text("Press s to reshuffle", 6, 390);
  
  //SCORE
  fill(255,34,18);
  rect(445, 378, 50, 15);
  fill(255);
  text("Score: "+score, 446, 390);
  
  if(xpos >= trix-3 && xpos <= trix+3 && ypos <= 12){
    //YAY THAT'S A WIN
    xpos = 250;
    ypos = 390;
    for(int i = 0; i < walls.length; i++){
      walls[i].reshuffle();
    }
    score += 1;
    r= random(15,200);
    g = random(15,255);
    b = random(15,255);
  }
  
  if(shuffle){
    for(int i = 0; i < walls.length; i++){
      walls[i].reshuffle();
    } 
  }
}

class Wall{
  //Atributes
  float x1, y1;
  float speed;
  float size, tall;  
  
  //DEFAULT Constructor
  Wall() {
    size = int(random(15, 25));
    tall = 0;
    x1 = int(random(0,475));
    y1 = int(random(0,400));
    speed = 0.5;
  }
  
  //CUSTOM Constructor
  Wall(float high){
    tall = int(high);
    size = 0;
    x1 = int(random(0,500));
    y1 = int(random(25,400));
    speed = 0.5;
  }
  
  //Functions
  void display(){
    stroke(0);
    strokeWeight(4);
    line(x1, y1, x1+size, y1-tall);
  }
  
  void move(){
    y1 += speed;
    if((y1-tall) > 400){
      y1 -= 400;
    }
  }
  
  void touch(){   
    if(x1 <= (xpos-5)){
      if((xpos-5) <= (x1+size)){
        //X CHECKS
        if(y1 >= (ypos - 5)){
          if(y1 <= (ypos + 5)){
            //Y CHECKS
            //HIT
            xpos = 250;
            ypos = 390;
          }else if(y1 >= (ypos + 5)){
            if((ypos + 5) >= (y1-tall)){
              //Y CHECKS
              //HIT
              xpos = 250;
              ypos = 390;
            }
          }
        }
      }
    }
    if(x1 >= (xpos-5)){
      if(x1 <= (xpos+5)){
        //X CHECKS
        if(y1 >= (ypos - 5)){
          if(y1 <= (ypos + 5)){
            //Y CHECKS
            //HIT
            xpos = 250;
            ypos = 390;
          }else if(y1 >= (ypos + 5)){
            if((ypos + 5) >= (y1-tall)){
              //Y CHECKS
              //HIT
              xpos = 250;
              ypos = 390;
            }
          }
        }
      }
    }
  }
  
  void reshuffle(){
    x1 = int(random(0,475));
    y1 = int(random(0,400));
    trix = int(random(3,497));
  }
}

void keyPressed(){
  if(key == CODED){
    if(keyCode == UP){
      up = true;
    }else if(keyCode == DOWN){
      down = true;
    }else if(keyCode == RIGHT){
      right = true;
    }else if(keyCode == LEFT){
      left = true;
    }
  }else if(key == 's'){
    shuffle = true;
  }
}

void keyReleased(){
  if(key == CODED){
    if(keyCode == UP){
      up = false;
    }else if(keyCode == DOWN){
      down = false;
    }else if(keyCode == RIGHT){
      right = false;
    }else if(keyCode == LEFT){
      left = false;
    }
  }else if(key == 's'){
    shuffle = false;
  }
}

void movingBall(){
 if(up == true){
    ypos -= 1; 
  }if(down == true){
    ypos += 1;
  }if(right == true){
    xpos += 1;
  }if(left == true){
    xpos -= 1;
  } 
}

void boundary(){
  if(xpos >= 495){
    xpos -= 5;
  }if(xpos <= 5){
    xpos += 5;
  }if(ypos >= 395){
    ypos -= 5;
  }if(ypos <= 5){
    ypos += 5;
  }
}
