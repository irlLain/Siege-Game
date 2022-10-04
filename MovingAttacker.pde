private class MovingAttacker extends Attacker
{
  MovingAttacker(int x, int y, String special, int YSpeed)
  {
    super(x, y, special, YSpeed);
    this.special = "moving";
  }
  //Moving Attacker constructors


  void render()
  {
    if (c <= 45)
    {
      image(blueworm[0], x, y);
      c+=1;
    }
    if (c >= 46)
    {
      image(blueworm[1], x, y);
      c+=1;
      if (c >90)
      {
        c=0;
      }
    }
    //changes the sprite of the worm and displays it on screen
    move();
  }

  void move()
  {
    if (Player1.x > x)
    {
      x = x+1;
    } else
    {
      x = x-1;
    }
    y = y-1;
    //allows attacker to move towards the players direction
  }
}
