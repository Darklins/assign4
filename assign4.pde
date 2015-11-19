/* please implement your assign2 code in this file. */
PImage bg1, bg2, start1, start2, end1, end2;
PImage enemy, fighter, hpimage, treasure;
float hp, fx, fy, tx, ty;
float [][] ex = new float [4][10];
float [][] ey = new float [4][10];
PImage[] boom = new PImage[6];
final int GAME_START = 1, GAME_RUN = 2, GAME_OVER = 3;
int background_speed, state = GAME_START,i,j,k = 1,l = 1,level,standard=-60,s = second();
boolean upPressed = false, downPressed = false, leftPressed = false, rightPressed = false;

void setup () {
  size(640,480) ;
  background_speed = 0;
  frameRate(60);
  bg1 = loadImage("img/bg1.png");
  bg2 = loadImage("img/bg2.png");
  enemy = loadImage("img/enemy.png");
  fighter = loadImage("img/fighter.png");
  hpimage = loadImage("img/hp.png");
  treasure = loadImage("img/treasure.png");
  start2 = loadImage("img/start1.png");
  start1 = loadImage("img/start2.png");
  end2 = loadImage("img/end1.png");
  end1 = loadImage("img/end2.png");
  for(i=1;i<=5;i++){
   boom[i] =  loadImage("img/flame"+(i)+".png");
  }
  
  hp = 45;
  fx= 589;
  fy = random(30,431);
  tx = random(0,599);
  ty = random(30,431);
  ey[1][1] = random(90,410);
  ey[2][1] = random(30,120); 
  ey[3][1]= random(200,300); 
  for(i=1;i<=3;i++){
        for(j=1;j<=8;j++){
          ex[i][j]=-60;
          ey[i][j]=ey[i][1];
        }
      }
}
void draw() {

  switch(state){
    
    case GAME_START:
      image(start1,0,0);//start1
      if(mouseY > height/2+144 && mouseY < height/2+168)
      {
        if(mouseX > width/2-96 && mouseX < width/2+96){
          image(start2,0,0);//start2
          if(mousePressed)
            state = GAME_RUN; 
        }  
      }
      i = 1;
      break;
      
    case GAME_RUN:
      //background;
      image(bg2,-640 + (background_speed+640) % 1280,0);
      image(bg1,-640 + background_speed % 1280,0);
      //image(boom[1],250,250);
  
      //hp
      fill(256,0,0);
      rect(11,6,hp,29);
      image(hpimage,5,5);
  
      image(treasure,tx,ty);//treasure
      image(fighter,fx,fy);//fighter
      println(frameCount%120);
       //enemy wave
      if(i==1){
      for(int j=1; j<=5;j++){        //enemyC
        ex[i][j+1] = ex[i][j]-90;
        if(fx > ex[i][j]-50 && fx < ex[i][j]+50){
        if(fy > ey[i][j]-50 && fy < ey[i][j]+50){
        for(k=1;k<=5;k+=0){
          
          image(boom[k],ex[i][j],ey[i][j]);  
        }
     
               
               
           
           if(hp < 0){
             state = GAME_OVER;
           }
           ey[i][j]=9999;
           hp-=4;//enemy and hp
           continue;
        }
      }
        image(enemy,ex[i][j],ey[i][j]);
         if(ex[i][1] == 1000){
           i = 1;
           ex[i][1] = -60;
           ey[i][1] = random(90,410);
           for(j=1;j<=5;j++){
             ey[i][j] = ey[i][1];
           }
           break;
         }
      }
     }
     /*
      else if(i==2){        //enemyB
      for(int j=1; j<=5;j++){
         image(enemy,ex- j *60,ey_b+j*60);
          if(ex == 960){
           i = 3;
           ex = 0;
           ey_b = random(30,120); 
           break;
         }
      }
      }
      else{        //enemyA
        for(int j= 1; j<6; j++){
          if(j==2||j==4)
            level = 1;
          else if(j==3)
            level = 2;
          else
            level = 3;
           
          if(level==2||level==1){
            image(enemy,ex- j *60,ey_a+level*60);
            image(enemy,ex- j *60,ey_a-level*60);
          }
          else
            image(enemy,ex-(j%6)*60,ey_a);
          if(ex == 960){
             i = 1;
             ex = 0;
             ey_a = random(200,300); 
             break;
          }  
        }
      }*/
      
      
      for(j=1;j<=8;j++)
      {
        ex[i][j]+=4;
      }
      standard+=4;
      if(standard==1000){
      standard = -60;
      }
      background_speed++;
      
      // move of fighter
      if(upPressed){
        fy -= 4;
        if(fy < 0)
          fy = 0;
      }
      if(downPressed){
        fy += 4;
        if(fy > height-51)
          fy = height-51;
      }
      if(leftPressed){
        fx -= 4;
        if(fx < 0)
          fx = 0;
      }
      if(rightPressed){
        fx += 4;
        if(fx > width-51)
          fx = width-51;
      }
      
      //change of hp
      if(fx > tx-40 && fx < tx+41){
        if(fy > ty-40 && fy < ty+41){
           hp += 20;//treasure and hp
           tx = random(0,599);
           ty = random(30,431);
           if(hp > 200)
             hp = 200;
        }
      }
      
      
      break;
      
    case GAME_OVER:
      hp = 45;
      fx= random(0,599);
      fy = random(30,431);
      tx = random(0,599);
      ty = random(30,431);
      ey[1][1] = random(90,410);
      ey[2][1] = random(30,120); 
      ey[3][1]= random(200,300); 
      for(i=1;i<=3;i++){
        for(j=1;j<=8;j++){
          ex[i][j]=-60;
          ey[i][j]=ey[i][1];
        }
      }
      image(end1,0,0);//end1
      if(mouseY > height/2+80 && mouseY < height/2+90)
      {
        if(mouseX > width/2-84 && mouseX < width/2+84){
          image(end2,0,0);//end2
          if(mousePressed)
            state = GAME_RUN;
        }  
      }
      i = 1;
      break;
  }

}
void keyPressed(){
  if(key == CODED){
    switch(keyCode){
      case UP:
       upPressed = true;
      break;
      case DOWN:
        downPressed = true;
      break;
      case LEFT:
        leftPressed = true;
      break;
      case RIGHT:
        rightPressed = true;
      break;
    }
  }
}

void keyReleased(){
  if(key == CODED){
    switch(keyCode){
      case UP:
        upPressed = false;
      break;
      case DOWN:
        downPressed = false;
      break;
      case LEFT:
        leftPressed = false;
      break;
      case RIGHT:
        rightPressed = false;
      break;
    }
  }
}
