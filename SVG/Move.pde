void move() {
  if (joyLocked) {
    pY += moveY(pSpeed, joyMouseRatio, (joyMouseY < joyPadY));
    pX += moveX(pSpeed, joyMouseRatio, (joyMouseX < joyPadX));
  }

  //e1X += moveX(eSpeed, (abs(e1X - pX) / abs(e1Y - pY)), (pX < e1X));
  //e1Y += moveY(eSpeed, (abs(e1X - pX) / abs(e1Y - pY)), (pY < e1Y));
}

float moveX(float speed, float xyRatio, boolean left) {
  float res;
  res = pytagB(speed / fps, xyRatio);
  if (left) res = res * (-1);
  return res;
}

float moveY(float speed, float xyRatio, boolean top) {
  float res;
  res = pytagBezB(speed / fps, xyRatio);
  if (top) res = res * (-1);
  return res;
}
