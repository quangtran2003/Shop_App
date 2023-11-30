// ignore_for_file: must_be_immutable, sort_child_properties_last

import 'package:app_ban_hang/Home/home_screen.dart';
import 'package:app_ban_hang/address/address_screem.dart';
import 'package:app_ban_hang/cart/cart_screen.dart';
import 'package:app_ban_hang/component/const.dart';
import 'package:app_ban_hang/pay/pay_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: HOME_SCREEN,
      routes: {
        HOME_SCREEN: (context) => const HomeScreen(),
        PAY_SCREEN: (context) => PayScreen(),
        CART_SCREEN: (context) => const CartScreen(),
        ADDRESS_SCREEN: (context) => AddressSCreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
