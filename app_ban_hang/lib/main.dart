// ignore_for_file: must_be_immutable, sort_child_properties_last

import 'package:app_ban_hang/Home/home_screen.dart';
import 'package:app_ban_hang/address/address_screem.dart';
import 'package:app_ban_hang/cart/cart_screen.dart';
import 'package:app_ban_hang/component/const.dart';
import 'package:app_ban_hang/firebase_options.dart';
import 'package:app_ban_hang/login_resiger/login_screen.dart';
import 'package:app_ban_hang/login_resiger/resiger_screen.dart';
import 'package:app_ban_hang/ordered/ordered_screen.dart';
import 'package:app_ban_hang/pay/pay_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
        LOGIN_SCREEN: (context) => Login(),
        RESIGER_SCREEN: (context) => Resiger(),
        PAY_SCREEN: (context) => const PayScreen(),
        CART_SCREEN: (context) => const CartScreen(),
        ADDRESS_SCREEN: (context) => const AddressSCreen(),
        ORDERED_SCREEN: (context) => OrderedScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
