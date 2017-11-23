class Noise {
  float value;
  float posX, posY, posZ;
  float stepX, stepY, stepZ;
  float minValue = 0.0, maxValue = 1.0;

  Noise(float posX, float stepX) {
    setPosXYZ(posX, 0, 0);
    setStepXYZ(stepX, 0, 0);
  }

  Noise(float posX, float posY, float stepX, float stepY) {
    setPosXYZ(posX, posY, 0);
    setStepXYZ(stepX, stepY, 0);
  }

  Noise(float posX, float posY, float posZ, float stepX, float stepY, float stepZ) {
    setPosXYZ(posX, posY, posZ);
    setStepXYZ(stepX, stepY, stepZ);
  }

  Noise setRange(float minValue, float maxValue) {
    this.minValue = minValue;
    this.maxValue = maxValue;
    return this;
  }

  Noise update() {
    posX += stepX;
    posY += stepY;
    posZ += stepZ;
    value = minValue + noise(posX, posY, posZ) * (maxValue - minValue);
    return this;
  }

  float getValue() {
    return value;
  }

  void setPosX(float posX) {
    this.posX = posX;
  }
  void setPosXY(float posX, float posY) {
    this.posX = posX;
    this.posY = posY;
  }
  void setPosXYZ(float posX, float posY, float posZ) {
    this.posX = posX;
    this.posY = posY;
    this.posZ = posZ;
  }

  void setStepX(float stepX) {
    this.stepX = stepX;
  }
  void setStepXY(float stepX, float stepY) {
    this.stepX = stepX;
    this.stepY = stepY;
  }
  void setStepXYZ(float stepX, float stepY, float stepZ) {
    this.stepX = stepX;
    this.stepY = stepY;
    this.stepZ = stepZ;
  }
}
