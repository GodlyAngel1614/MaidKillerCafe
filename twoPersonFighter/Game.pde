import processing.sound.*;

class Game {
  boolean gameOver;
  Player player1;
  Player2 player2;
  ScoreBoard theScoreBoard;

  Game() {
    //all initializations go in here
    gameOver = false;
    player1 = new Player(width * 0.25, height * 0.7, false);
    player2 = new Player2(width * 0.75, height * 0.7, false);
    theScoreBoard = new ScoreBoard();
  }

  void display() {
    background(90);
    fill(#224411);
    rect(0, height * .7 + 200, width, height * 0.3);
    player1.update();
    player2.update();
    player1.display();
    player2.display();
    theScoreBoard.display();
    theScoreBoard.updateBar(player1.health);
    if (player1.health <= 0) {
      gameOver = true;
    }
  }

  void keyPressed() {
    theScoreBoard.updateScore(player1.score);
    player1.keyPressed();
    player2.keyPressed();
  }

  void keyReleased() {
    player1.keyReleased();
    player2.keyReleased();
  }
}
