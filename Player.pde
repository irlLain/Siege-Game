private class Player
{
  final int y = 50;
  int x = 10;
  
  void render()
  {
     image(flower,x,y);
  }
  //renders the image of the player
  
  void position()
  {
    if(x<=25)
    {
      x += 5;
    }
    if(x >= 375)
    {
      x =x- 5;
    }
  }
  //prevents the player from moving off the screen
  
}
