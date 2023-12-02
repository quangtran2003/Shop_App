// ignore_for_file: constant_identifier_names

import 'dart:ui';

const HOME_SCREEN = '/HomeScreen';
const CART_SCREEN = '/CartScreen';
const ADDRESS_SCREEN = '/AddressScreen';
const PAY_SCREEN = '/PayScreen';
const ORDERED_SCREEN = '/OrderScreen';

enum TRANSPORT { FASST, NORMAL, DEAFULT }

enum GIFT { FLOWER, BAG, DEAFULT }

const constColor = Color.fromARGB(255, 16, 111, 130);
String format(int price) {
  int value = price ~/ 1000;

  return '$value.000';
}
