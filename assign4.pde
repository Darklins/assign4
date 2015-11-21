/* please implement your assign2 code in this file. */
PImage bg1, bg2, start1, start2, end1, end2;
PImage enemy, fighter, hpimage, treasure,shoot;
float hp, fx, fy, tx, ty;
float [][] ex = new float [4][10];
float [][] ey = new float [4][10];
float [] boomx = new float [10];
float [] boomy = new float [10];
float [] bullet = new float [6];
float [] bulletY = new float[6];
int [] flamenum = new int [10];
PImage[] boom = new PImage[7];
Boolean [] ifboom = new Boolean[10];
Boolean [] boomfinish = new Boolean[10];
Boolean [][] enemyshowup = new Boolean[4][10];
Boolean [] bulletshowup = new Boolean[6];

final int GAME_START = 1, GAME_RUN = 2, GAME_OVER = 3;
int background_speed, state = GAME_START,i,j,k = 1,p = 1,l =1,bn =1,level,standard=-120,s = second();
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
  shoot = loadImage("img/shoot.png");
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
          ex[i][j]=-120;
          ey[i][j]=ey[i][1];
          enemyshowup[i][j] = true;
        }
      }
  for(i =1;i<=5;i++){
    bulletshowup[i] = false;
}
  for(i=1;i<=8;i++){
    ifboom[i] =false;
    flamenum[i] = 1;
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
  
      //hp
      fill(256,0,0);
      rect(11,6,hp,29);
      image(hpimage,5,5);
  
      image(treasure,tx,ty);//treasure
      image(fighter,fx,fy);//fighter
      for(k=1;k<=8;k++){
        if(ifboom[k]==true){
          image(boom[flamenum[k]],boomx[k],boomy[k]);
          if(frameCount%6==0){
            flamenum[k]++;
            if(flamenum[k]==6){
              flamenum[k] = 1;
              ifboom[k] = false;
            }
          }
        }
      }
      for(k = 1;k<=5;k++){
        if(bulletshowup[k]==true){
          image(shoot,bullet[k],bulletY[k]);
        }
      }
       //enemy wave
      if(i==1){
      for(int j=1; j<=5;j++){        //enemyC
        ex[i][j+1] = ex[i][j]-90;
        if(fx > ex[i][j]-50 && fx < ex[i][j]+50){
        if(fy > ey[i][j]-50 && fy < ey[i][j]+50){
            if(enemyshowup[i][j]==true){
             hp-=40;
             enemyshowup[i][j]=false;
             ifboom[bn]=true;
             boomx[bn] = ex[i][j];
              boomy[bn] = ey[i][j];
              bn++;
              if(bn==6){
              bn =1;
              }
           }

           if(hp <= 5){
             state = GAME_OVER;
           }

           continue;
        }
      }
      for(k=1;k<=5;k++){
        if(bullet[k] > ex[i][j]-50 && bullet[k] < ex[i][j]+50){
        if(bulletY[k] > ey[i][j]-50 && bulletY[k] < ey[i][j]+50){
            if(enemyshowup[i][j]==true&&bulletshowup[k]==true){
              ifboom[bn]=true;
              boomx[bn] = ex[i][j];
              boomy[bn] = ey[i][j];
              bn++;
              if(bn==9){
                bn =1;
              }
              enemyshowup[i][j]=false;
              bulletshowup[k]=false;
           }     
           continue;
        }
      }
      }
        if(enemyshowup[i][j]==true){
        image(enemy,ex[i][j],ey[i][j]);
        }
         if(ex[i][1] == 1000){
           ex[i][1] = -120;
           ey[i][1] = random(90,410);
           for(j=1;j<=5;j++){
             ey[i][j] = ey[i][1];
             enemyshowup[i][j]=true;
           }
           i = 2;
           break;
         }
      }
     }
     else if(i==2){
      for(int j=1; j<=5;j++){        //enemyB
        ex[i][j+1] = ex[i][j]-50;
        ey[i][j+1] = ey[i][j]+50;
        if(fx > ex[i][j]-50 && fx < ex[i][j]+50){
        if(fy > ey[i][j]-50 && fy < ey[i][j]+50){
            if(enemyshowup[i][j]==true){
             hp-=40;
             enemyshowup[i][j]=false;
             ifboom[bn]=true;
             boomx[bn] = ex[i][j];
              boomy[bn] = ey[i][j];
              bn++;
              if(bn==6){
              bn =1;
              }
           }
     
           if(hp <= 5){
             state = GAME_OVER;
           }
            continue;
        }
      }
      for(k=1;k<=5;k++){
        if(bullet[k] > ex[i][j]-50 && bullet[k] < ex[i][j]+50){
        if(bulletY[k] > ey[i][j]-50 && bulletY[k] < ey[i][j]+50){
            if(enemyshowup[i][j]==true&&bulletshowup[k]==true){
              ifboom[bn]=true;
              boomx[bn] = ex[i][j];
              boomy[bn] = ey[i][j];
              bn++;
              if(bn==9){
                bn =1;
              }
              enemyshowup[i][j]=false;
              bulletshowup[k]=false;
           }     
           continue;
        }
      }
      }
        if(enemyshowup[i][j]==true){
        image(enemy,ex[i][j],ey[i][j]);
        }
         if(ex[i][1] == 1000){
           ex[i][1] = -120;
           ey[i][1] = random(90,120);
           for(j=1;j<=8;j++){
             enemyshowup[i][j]=true;
           }
           i = 3;
           break;
         }
      }
     }
     else if(i==3) {
      for(int j=1; j<=8;j++){        //enemyA
            if(j==2){
               ex[i][j] = ex[i][1] - 50;
               ey[i][j] = ey[i][1] - 50;
            }
            else if(j==3){
               ex[i][j] = ex[i][1] - 50;
               ey[i][j] = ey[i][1] + 50;
            }
            else if(j==6){
               ex[i][j] = ex[i][1] - 150;
               ey[i][j] = ey[i][1] - 50;
            }
            else if(j==7){
               ex[i][j] = ex[i][1] - 150;
               ey[i][j] = ey[i][1] + 50;
            }
         
        
            else if(j==4){
               ex[i][j] = ex[i][1] - 100;
               ey[i][j] = ey[i][1] - 100;
            }
            else if(j==5){
               ex[i][j] = ex[i][1] - 100;
               ey[i][j] = ey[i][1] + 100;
            }
          
          
            else if(j==1){
               ex[i][j] = ex[i][1] ;
               ey[i][j] = ey[i][1] ;
            }
            else if(j==8){
               ex[i][j] = ex[i][1] - 200;
               ey[i][j] = ey[i][1];
            }
          
        if(fx > ex[i][j]-50 && fx < ex[i][j]+50){
        if(fy > ey[i][j]-50 && fy < ey[i][j]+50){
            if(enemyshowup[i][j]==true){
             hp-=40;
             enemyshowup[i][j]=false;
             ifboom[bn]=true;
             boomx[bn] = ex[i][j];
              boomy[bn] = ey[i][j];
              bn++;
              if(bn==9){
              bn =1;
              }
           }
     
           if(hp <= 5){
             state = GAME_OVER;
           }
            continue;
        }
      }
      for(k=1;k<=5;k++){
        if(bullet[k] > ex[i][j]-50 && bullet[k] < ex[i][j]+50){
        if(bulletY[k] > ey[i][j]-50 && bulletY[k] < ey[i][j]+50){
            if(enemyshowup[i][j]==true&&bulletshowup[k]==true){
              ifboom[bn]=true;
              boomx[bn] = ex[i][j];
              boomy[bn] = ey[i][j];
              bn++;
              if(bn==9){
                bn =1;
              }
              enemyshowup[i][j]=false;
              bulletshowup[k]=false;
           }     
     
           continue;
        }
      }
      }
       
        if(enemyshowup[i][j]==true){
          image(enemy,ex[i][j],ey[i][j]);
        }
         if(ex[i][1] == 1000){
           ex[i][1] = -120;
           ey[i][1] = random(200,300);
           for(j=1;j<=8;j++){
             enemyshowup[i][j]=true;
           }
           i = 1;
           break;
         }
      }
     }
      
      
      for(j=1;j<=8;j++)
      {
        ex[i][j]+=4;
      }
      for(j=1;j<=5;j++){
        bullet[j]-=4;
        if(bullet[j] < -32)
          bulletshowup[j] = false;
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
      fx= 589;
      fy = random(30,431);
      tx = random(0,599);
      ty = random(30,431);
      ey[1][1] = random(90,410);
      ey[2][1] = random(30,120); 
      ey[3][1]= random(200,300); 
      for(i=1;i<=3;i++){
        for(j=1;j<=8;j++){
          ex[i][j]=-120;
          ey[i][j]=ey[i][1];
          enemyshowup[i][j] = true;
          ifboom[j] = false;
          boomfinish[j] = true;
          bulletshowup[j]=false;
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
  if(key==' '){
       if(bullet[p]<0){
       bulletshowup[p] = true;
       bullet[p]= fx-30;
       bulletY[p] = fy;
       p++;
       if(p==6)
         p=1;
       }
    }
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
