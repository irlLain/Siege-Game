public abstract class Attacker
{
  int x = 200;
  int y = 750;
  int YSpeed = 1;
  int c = 0;
  String special = "false";

  Attacker(int x, int y, String special, int YSpeed)
  {
    this.x = x;
    this.y = y;
    this.special = special;
    this.YSpeed =YSpeed;
  }
  //constructors for the Attacker class

  void render()
  {
    if (c <= 45)
    {
      image(worm[0], x, y);
      c+=1;
    }
    if (c >= 46)
    {
      image(worm[1], x, y);
      c+=1;
      if (c >90)
      {
        c=0;
      }
    }
    //changes the sprite of the worm
    move();
  }

  void move()
  {
    y -= YSpeed;
  }
  //moves the attacker up the screen
}
