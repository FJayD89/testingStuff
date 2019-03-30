public float pytagBezB(float a, float b) {
  float res;
  res = a / ( sqrt( sq(b) + 1 ) );
  return res;
}

public float pytagB(float a, float b) {
  float res;
  res = (a * b) / (sqrt( sq(b) + 1 ));
  return res;
}

public float varPytag(float X1, float Y1, float X2, float Y2) {
  float res = sqrt(sq(X1 - X2) + sq(Y1 - Y2));
  return res;
}
