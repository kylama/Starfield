float galaxyX, galaxyY;
boolean isFirst = true;

class Star{
  int myC;
  float myX, myY, mySize, myGrowth;
  double myAngle, mySpeed;
  
  Star(){
    myX = myY = 250 + (float)(Math.random()*41-20);
    myC = color(255,255,255);
    mySize = 0;
    myAngle = Math.random()*(2*Math.PI);
    mySpeed = Math.random()*2+0.01;
    myGrowth = 0.05;
  }
  
  void move(){
    mySpeed += myGrowth;
    myX += Math.cos(myAngle)*mySpeed;
    galaxyX = myX;
    myY += Math.sin(myAngle)*mySpeed;
    galaxyY = myY;
    mySize += myGrowth;
    if((myX > 240)&&(myX < 260) && (myY > 240)&&(myY < 260))
      mySize = 0;
    if(((myX > (float)(Math.random()*100)+500)||(myX < (float)(Math.random()*100)-100)) || 
    ((myY > (float)(Math.random()*100)+500)||(myY < (float)(Math.random()*100)-100))){
      myX = 250;
      myY = 250;
      mySize = 0;
      mySpeed = Math.random()*2+0.01;
    }
  }
  
  void show(){
    fill(myC);
    ellipse(myX, myY, mySize, mySize);
  }
}//end of Star class

class Firework extends Star{
  Firework(){
    myX = myY = 250;
    myC = color((int)(Math.random()*256),(int)(Math.random()*256),(int)(Math.random()*256));
    mySize = 8;
    myAngle = Math.random()*(2*Math.PI);
    mySpeed = 3;
    myGrowth = 0.05;
  }
  
  void explode(){
    mySpeed += 0.05;
    myX += Math.cos(myAngle)*mySpeed;
    myY += Math.sin(myAngle)*mySpeed;
    mySize += myGrowth;
    
    if(((myX > 240)&&(myX < 260)) || ((myY > 240)&&(myY < 260)))
      mySize = 0;
    else
      mySize = 8;
      
    if(((myX > 500)||(myX < 0)) || ((myY > 500)||(myY < 0))){
      myX = 250;
      myY = 250;
      mySize = 8;
      mySpeed = 1;
    }
  }
  
  void reset(){
    myX = myY = 250;
  }
}//end of Firework class

class Oddball extends Star{
  Oddball(){
    myX = myY = 250;
    myC = color(135,180,195);
    mySize = 15;
  }
  
  void move(){
    myX += (int)(Math.random()*7)-3;
    myY += (int)(Math.random()*7)-3;
  }
  
  void show(){
    fill(myC);
    ellipse(myX, myY, 3*mySize/2, mySize/2);
    fill(210,190,120);
    ellipse(myX, myY, mySize, mySize);
    fill(myC);
    rect(myX-(mySize/2),myY+(mySize/14), mySize, mySize/8);
  }
}//end of Oddball class

Star [] galaxy1;
Star [] galaxy2;
Firework [] fireworks;

void setup(){
  size(500,500);
  noStroke();
  galaxy1 = new Star[100];
  galaxy2 = new Star[100];
  fireworks = new Firework[200];
  for(int i = 0; i < galaxy1.length; i++){
    if(i == 0)
      galaxy1[i] = new Oddball();
    else
      galaxy1[i] = new Star();
  }
  for(int i = 0; i < galaxy2.length; i++)
    galaxy2[i] = new Star();
  for(int i = 0; i < fireworks.length; i++)
    fireworks[i] = new Firework();
}

void draw(){
  background(0);
  for(int i = 0; i < galaxy1.length; i++){
    galaxy1[i].move();
    galaxy1[i].show();
  }
  if(isFirst == true){
    if(((galaxyX < 100)||(galaxyX > 400)) || ((galaxyY < 100)||(galaxyY > 400))){
      for(int i = 0; i < galaxy2.length; i++){
        galaxy2[i].move();
        galaxy2[i].show();
      }
    }
    isFirst = false;
  } else {
    for(int i = 0; i < galaxy2.length; i++){
      galaxy2[i].move();
      galaxy2[i].show();
    }
  }
  
  for(int i = 0; i < fireworks.length; i++){
    if(mousePressed == true){
      fireworks[i].reset();
    }
    fireworks[i].explode();
    fireworks[i].show();
  }
}
