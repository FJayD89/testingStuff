float e1X;                   // Horizontal coordinate of the enemy position
float e1Y;                   // Horizontal coordinate of the enemy position
boolean e1Alive;             // Is the first enemy still alive?
float eColR;                 // Red value of the enemy color
float eColG;                 // Green value of the enemy color
float eColB;                 // Blue value of the enemy color
float eSpeed;                // Enemy speed
float pSize;                 // Diameter of the player/enemy character
float pColR;                 // Red value of the player color
float pColG;                 // Green value of the player color
float pColB;                 // Blue value of the player color
float pX;                    // Horizontal coordinate of the player
float pY;                    // Vertical coordinate of the player
float pSpeed;                // Player speed
float BGcol;                 // The color of the background
int fps;                     // The set framerate, in frames per second
int score;                   // The current score based on timeElapsed
int timeElapsed;             // How many seconds have passed during gameplay
boolean gameOver;            // Is the game over yet?
boolean standStill;

boolean joyLocked;           // Is thejoystick currently locked?
float joyX;                  // Horizontal coordinate of the joystick 
float joyY;                  // Vertical coordinate of the joystick
float joyRad;                // Radius of the joystick
float joyPlayerX;            // Horizontal coordinate of the joystick mouse 
float joyPlayerY;            // Vertical coordinate of the joystick mouse
float joyMouseX;             // Horizontal coordinate of the mouse in relation to the joystick pad
float joyMouseY;             // Vertical coordinate of the mouse in relation to the joystick pad
float joyMouseRatio;         // Ratio of joyMouseX and joyMouseY
float joyPadRad;             // Radius of the joystick pad
float joyPadX;               // Horizontal coordinate of the center of the joystick
float joyPadY;               // Vertical coordinate of the center of the joystick

// ****************************************************

void setup() {
  size (800, 450);
  fps = 60;
  frameRate(fps);
  stroke(0);
  orientation(LANDSCAPE);

  // set up the "Comic Sans MS" font because you can never have enough Sans
  PFont sans;
  sans = loadFont("ComicSansMS-48.vlw");
  textFont(sans);

  pSize = width / 20;
  pColR = 255;
  pColG = 0;
  pColB = 0;
  eColR = 0;
  eColG = 0;
  eColB = 0;
  eSpeed = 50;
  pSpeed = 50;
  BGcol = 200;
  gameOver = false;
  standStill = true;

  joyPadRad  = height / 6;
  joyRad = joyPadRad / 2;
  joyPadX = (width / 100) + joyPadRad;
  joyPadY = height - (height / 100) - joyPadRad;

  init();
}

void init() {
  // initiatie enemy positions  
  e1X = pSize / 2;
  e1Y = pSize / 2;

  // initiate player positions
  pX = width / 2;
  pY = height / 2;
}

// ***************************************

void draw() {
  background(BGcol);
  joyMouseRatio = joyMouseX / joyMouseY;                                                                                                               
  setJoyX_Y();

  // check for gameOver
  if (varPytag(pX, pY, e1X, e1Y) < pSize) {
    gameOver = true;
  } else {
    gameOver = false;
  }

  if (!gameOver) {

    // draw joystick pad
    drawJoyPad(joyPadX, joyPadY, joyRad, joyPadRad);

    move();

    // draw player
    fill(pColR, pColG, pColB);
    ellipse(pX, pY, pSize, pSize);

    // draw ememy
    fill(eColR, eColG, eColB);
    ellipse(e1X, e1Y, pSize, pSize);

    // time stuff
    timeElapsed = millis() / 1000;

    // score
    score = timeElapsed;
    text(score, width / 2 - 50, 50);

    // joyLocked
    if (mousePressed && overJoyPad()) {
      joyLocked = true;
    } 

    // print some test logs
    println("e1X = " + e1X + " eiY = " + e1Y + " overJoyPad = " + overJoyPad() );
    println("joyMouseX = " + joyMouseX + " joyMouseY = " + joyMouseY + " joyX = " + joyX + " joyY = " + joyY);
    println("pX = " + pX + " pY = " + pY + " joyMouseRatio = " + joyMouseRatio);
    println("moveX = " + moveX(joyMouseRatio, pSpeed, (joyMouseX < joyPadX)) + " moveY = " + moveY(joyMouseRatio, pSpeed, (joyMouseY < joyPadY)));
  } else {
    gameOver();
  }
}

// ***************************************************

// reset joyLocked
public void mouseReleased() {
  joyLocked = false;
}

// what to do if player is dumb
void gameOver() {
  text("GAME OVER", width / 2 - 150, height / 2);
  text(score, width / 2 - 50, 50);
}

// ********************************************************



// ***************************************************************



// ***********************************************

public void drawJoyPad(float X, float Y, float rJS, float rJP) {  
  fill(100);
  // pole
  ellipse(X, Y, rJP * 2, rJP * 2);
  fill(0);

  // hlavica
  fill(0);
  ellipse(joyX, joyY, rJS * 2, rJS * 2);
}

// ****************************************************************

public void setJoyX_Y() {
  joyMouseY = (mouseY - joyPadY);  
  joyMouseX = (mouseX - joyPadX);

  if (joyLocked) {
    if (overJoyPad()) {
      joyX = mouseX;
      joyY = mouseY;
    } else {
      if (joyMouseY > 0) {
        joyY = joyPadY + pytagBezB(joyPadRad, joyMouseRatio);
        joyX = joyPadX + pytagB(joyPadRad, joyMouseRatio);
      } else if (joyMouseY < 0) {
        joyY = joyPadY - pytagBezB(joyPadRad, joyMouseRatio);
        joyX = joyPadX - pytagB(joyPadRad, joyMouseRatio);
      } else {
        if (joyMouseX < 0) {
          joyY = joyPadY;
          joyX = joyPadX - joyPadRad;
        } else {
          joyY = joyPadY;
          joyX = joyPadX + joyPadRad;
        }
      }
    }
  } else {
    joyX = joyPadX;
    joyY = joyPadY;
  }
}

// ***********************************************************************

public boolean overJoyPad() {
  if (varPytag(mouseX, mouseY, joyPadX, joyPadY) <= joyPadRad) return true;
  else return false;
}

// ******************************************************************************
