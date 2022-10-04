enum GameMode {
  GAMEPLAYING, GAMEOVER
}
GameMode game;
final Player Player1 = new Player();
ArrayList<Attacker> AttackerList;
ArrayList<Leaf> LeafList;
//array for attackers and leaves
PImage flower;
PImage leaf;
final PImage[] worm = new PImage[2];
final PImage[] purpleworm = new PImage[2];
final PImage[] blueworm = new PImage[2];
PImage death;
//array of images for worm movement
int PlantHealth = 100;
int Score = 0;
int HighScore = 0;
boolean LeafPresent = false;
Leaf Player1_Leaf = new Leaf(Player1.x, Player1.y);


void setup()
{
  game = game.GAMEPLAYING;
  //sets the current game to playing
  imageMode(CENTER);
  size(400, 800);
  flower = loadImage("Flower.png");
  leaf = loadImage("Leaf.png");
  //sets the window and loads images

  String[] Scores = loadStrings("Score.txt");
  HighScore =int( Scores[Scores.length-1]);
  //loads the high scorefrom file and displays it on the screen

  death = loadImage("Death2.png");
  worm[0] = loadImage("Worm.png");
  worm[1] = loadImage("Worm2.png");
  purpleworm[0] = loadImage("SpecialWorm.png");
  purpleworm[1] = loadImage("SpecialWorm2.png");
  blueworm[0] = loadImage("MovingWorm.png");
  blueworm[1] = loadImage("MovingWorm2.png");
  //adds the different worm sprites to an array
  AttackerList = new ArrayList<Attacker>();
  AttackerList.add(new BasicAttacker(200, 750, "false", 1));
  AttackerList.add(new MovingAttacker(100, 750, "moving", 1));
  AttackerList.add(new SpecialAttacker(300, 750, "special", 2));
  //creates first 3 instances of attackers

  LeafList = new ArrayList<Leaf>();
}

void keyPressed()
{
  if (key == CODED)
  {
    if (keyCode == LEFT)
    {
      Player1.x = Player1.x-5;
    }
    //left movement
    if (keyCode == RIGHT)
    {
      Player1.x = Player1.x+5;
    }
    //right movement
    if (keyCode == DOWN)
    {
      LeafList.add(new Leaf(Player1.x, 100));
      LeafPresent = true;
      Player1_Leaf = new Leaf(Player1.x, Player1.y);
    }
    //fires leaves
  }
}

void draw()
{
  switch(game) {
  case GAMEPLAYING:
    background(211, 236, 242);
    Player1.render();
    Player1.position();
    textSize(15);
    fill(240, 134, 194);
    text("Base Health remaining: "+PlantHealth, 5, 10);
    text("Score: " +Score, 200, 10);
    text("High Score: " +HighScore, 300, 10);
    //displays the background, highscore, current score and current health

    HighScore();
    //loads and displays the highscore

    for (int i = AttackerList.size()-1; i >= 0; i--)
    {
      Attacker present = AttackerList.get(i);
      present.render();
    }
    //renders each instance of an attacker thats present in the array


    for (int i = LeafList.size()-1; i >0; i--)
    {
      Leaf fired = LeafList.get(i);
      fired.render();
      //renders each leaf fired
      if (fired.y > height)
      {
        LeafList.remove(fired);
        //removes leaves once they have left the screen
      }
    }

    hit();
    //checks if leaf has collided with attacker

    if (collision() == true)
    {
      image(death, Player1.x, Player1.y);
      game = game.GAMEOVER;
    }
    //checks if an attacker has collided with a player leading to a game over

    Passed();
    //checks attackers are still in playable area
    if (PlantHealth <=0)
    {
      game = game.GAMEOVER;
    }
    //checks the base health, if its 0 or below the game ends

    //checks for game over
    break;
  case GAMEOVER:
    GameOver();
    //if the current game state is over, displays game over screen
    break;
  }
}

void HighScore()
{
  if (Score > HighScore)
  {
    HighScore = Score;
  }
  //updates high score on screen if suitable
}

boolean collision()
{
  for (int a =  AttackerList.size()-1; a>=0; a--)
  {
    Attacker current = AttackerList.get(a);
    if (dist(Player1.x, Player1.y, current.x, current.y) < 50)
    {
      if (current.special == "special")
      {
        AttackerList.remove(current);
        return true;
      }
      if (current.special == "moving")
      {
        AttackerList.remove(current);
        return true;
        //checks for a collision between special attackers ans the player leading to a game over
      }
    }
  }
  return false;
}


void hit()
{
  for (int i = LeafList.size()-1; i >=0; i--)
  {
    Leaf fired = LeafList.get(i);
    //checks each leaf in the array
    for (int c = AttackerList.size()-1; c >= 0; c--)
    {
      Attacker present = AttackerList.get(c);
      //checkseach attacker in the array
      if (dist(fired.x, fired.y, present.x, present.y) < 20)
      {
        LeafList.remove(fired);
        if (present.special == "special")
        {
          int x;
          x =int( random(350));
          AttackerList.add( new SpecialAttacker(x, 750, "special", 2));
        }
        if (present.special == "false")
        {
          int x;
          x =int( random(350));
          AttackerList.add( new BasicAttacker(x, 750, "false", 1));
        }
        if (present.special == "moving")
        {
          int x;
          x =int( random(350));
          AttackerList.add( new MovingAttacker(x, 750, "moving", 1));
        }
        //replaces each remove attacker with a new one of the same type
        AttackerList.remove(present);
        //if a collision occurs both leaf and attacker are removed
        Score += 2;
        //updates score
      }
    }
  }
}

void Passed()
{
  int x;
  x =int( random(350));
  for (int a = AttackerList.size()-1; a>=0; a--)
  {
    Attacker current = AttackerList.get(a);
    //checks through each attack in the array
    if (current.y <= 0)
    {
      PlantHealth -= 5;
      //if attacker makes it past the player, health is reduced
      if (current.special == "special")
      {
        AttackerList.add( new SpecialAttacker(x, 750, "special", 2));
      }
      if (current.special == "false")
      {
        AttackerList.add( new BasicAttacker(x, 750, "false", 1));
      }
      if (current.special == "moving")
      {
        AttackerList.add( new BasicAttacker(x, 750, "moving", 1));
      }
      AttackerList.remove(current);
      //removes the old attacker and replaces it with a new one of the same type in a random position
    }
  }
}
//if the attacker leaves the playable area they are removed from the array and health goes down

void GameOver()
{
  background(240, 134, 194);
  textSize(50);
  fill(0, 0, 0);
  text("GAME OVER!\nscore: " + Score, 50, 400);
  //displays game over message with the current score

  String[] Scores = {""};
  Scores[0] = str(HighScore);
  saveStrings("Score.txt", Scores);
  //saves highscore in a file
  game = game.GAMEOVER;
  //sets the game as over
}
//displays the gameover screen
