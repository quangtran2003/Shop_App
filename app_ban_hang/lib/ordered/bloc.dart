import 'dart:math';

class BlocOrdered {
  int generateRandomNumber() {
    Random random = Random();

    int min = 1000;
    int max = 9999;
    int randomNumber = min + random.nextInt(max - min + 1);

    return randomNumber;
  }
}
