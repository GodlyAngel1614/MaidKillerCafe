import processing.sound.*;

class Game {
  boolean gameOver;
  boolean debounce = false;
  int timer = 0;
  boolean player2wasHit = false;
  boolean player1wasHit = false;
 
  ScoreBoard theScoreBoard;

  Game() {
    //all initializations go in here
    gameOver = false;
    player1 = new Player(width * 0.25, height * 0.7, false);
    player2 = new Player2(width * 0.75, height * 0.7, false);
    theScoreBoard = new ScoreBoard(player1.health, player2.health);
  }

  void display() {
    background(90);

    fill(#224411);
    rect(0, height * .7 + 200, width, height * 0.3);

    player1.update();
    player2.update();

    theScoreBoard.updateHealth1(player1.health);
    theScoreBoard.updateHealth2(player2.health);
    
    theScoreBoard.updateLevel(player1.level, player2.level);

    player1.display();
    player2.display();

    theScoreBoard.display();

    if ((player1.xPos - player2.xPos) >= -156 && (player1.xPos - player2.xPos) <= -128 ) {
      if (player2.currentAction == "Slice 1") {
        if (!debounce) {
          debounce = true;
          player1wasHit = player1.takeDamage(5);

          if (player1wasHit) {
            player2.score += 10;
          }
        };
      } else if (player1.currentAction == "Attack 1" && player2.currentAction != "Jumping") {
        if (!debounce) {
          debounce = true;
          player2wasHit =  player2.takeDamage(10);

          if (player2wasHit) {
            player1.score += 10;
          }
        };
      } else if (player2.currentAction == "Slice 2" && player1.currentAction != "Jumping") {
        if (!debounce) {
          debounce = true;
          player1wasHit = player1.takeDamage(15);

          if (player1wasHit) {
            player2.score += 10 * 1.3;
          }
        };
      }
    } else {
    }

    if (debounce) {
      timer ++;
      if (timer >= 60 * 2 ) {
        debounce = false;
        timer = 0;
      }
    }

    if (player1.health <= 0 || player2.health <= 0) {
      gameOver = true;
    }

    fill(255);
    textSize(40);
    text("action: " + player1.currentAction, 20, height - 20);
    text("action: " + player2.currentAction, width - 400, height - 20);
  }

  void keyPressed() {
    theScoreBoard.updateScore(player1.score, player2.score);
    player1.keyPressed();
    player2.keyPressed();

    text("action: " + player1.currentAction, 20, height - 20);
    text("action: " + player2.currentAction, width - 400, height - 20);
  }

  void keyReleased() {
    player1.keyReleased();
    player2.keyReleased();
  }
}
