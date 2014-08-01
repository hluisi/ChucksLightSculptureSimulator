PixelMap[][] pMap;

void set_T_PixelMap(int index, int startX, int startY) {
  for (int y = 0; y < 20; y++) {
    for (int x = 0; x < 20; x++) {
      int i = (startX - y) + x;
      int j = (startY + y) + x;
      pMap[i][j].set(index, x, y);
      //println(i + "," + j + " - " + x + "," + y);
    }
  }
}

void set_B_PixelMap(int index, int startX, int startY) {
  for (int y = 0; y < 20; y++) {
    for (int x = 0; x < 20; x++) {
      int i = startX + (x * 2);
      int j = startY + (y * 2);
      pMap[i][j].set(index, x, y);
      //println(i + "," + j + " - " + x + "," + y);
    }
  }
}

void setupPixelMap() {
  pMap = new PixelMap [xSize][ySize];
  
  for (int i = 0; i < xSize; i++)
    for (int j = 0; j < ySize; j++)
      pMap[i][j] = new PixelMap();
  
  set_T_PixelMap(0, 19, 0);  // Screen 0
  set_B_PixelMap(1, 0, 26);  // Screen 1
  set_T_PixelMap(2, 59, 0);  // Screen 2
  set_B_PixelMap(3, 40, 26); // Screen 3
  set_T_PixelMap(4, 99, 0);  // Screen 4
  set_B_PixelMap(5, 80, 26); // Screen 5
}

class PixelMap {
  int i = -1;
  int x = -1;
  int y = -1;

  void set(int i, int x, int y) {
    this.i = i;
    this.x = x;
    this.y = y;
  }

  int pixelIndex() {
    return  x + (20 * y);
  }
}
