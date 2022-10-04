public class SpecialAttacker extends Attacker
{

  int YSpeed = 2;

  SpecialAttacker(int x, int y, String special, int YSpeed)
  {
    super(x, y, special, YSpeed);
    this.special = "special";
    this.YSpeed = 2;
    //allows the special worm to move faster
  }
  //special attacker contructors

  void render()
  {
    if (c <= 45)
    {
      image(purpleworm[0], x, y);
      c+=1;
    }
    if (c >= 46)
    {
      image(purpleworm[1], x, y);
      c+=1;
      if (c >90)
      {
        c=0;
      }
    }
    //changes the sprite of the worm and displays on screen
    move();
  }
}
