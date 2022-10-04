private class Leaf
{
  int x;
  int y;
  int SpeedY = 5;

  Leaf(int y, int x)
  {
    this.y =100;
    this.x = Player1.x;
    this.SpeedY = 5;
  }
  //leaf constructors

  void render()
  {
    image(leaf, x, y);
    move();
  }
  //renders the leaf onto the screen

  void move()
  {
    y += SpeedY;
  }
  //allows the leaf to move down the screen
}
