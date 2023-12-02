// ignore_for_file: must_be_immutable

import 'package:app_ban_hang/Home/bloc.dart';
import 'package:app_ban_hang/component/const.dart';
import 'package:app_ban_hang/component/icon.dart';
import 'package:app_ban_hang/component/product.dart';
import 'package:app_ban_hang/component/text.dart';
import 'package:app_ban_hang/data/model.dart';
import 'package:flutter/material.dart';

class ListProduct extends StatelessWidget {
  BuildContext context;
  double bottomSheetHeight;
  List<ProductModel> products;
  BlocHome bloc;

  ListProduct({
    Key? key,
    required this.context,
    required this.bottomSheetHeight,
    required this.products,
    required this.bloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: bottomSheetHeight,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            child: Row(
              children: [
                MyText(
                  text: 'ƯU ĐÃI HÔM NAY',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                Expanded(child: Container()),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const MyIcon(
                    icon: Icons.expand_more,
                    size: 35,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 15),
            color: const Color.fromARGB(255, 243, 125, 71),
            child: Center(
              child: MyText(
                text: 'Hôm nay bạn dùng gì?',
                fontSize: 17,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                bool hot = true;
                if (index >= 4) hot = false;
                return Column(
                  children: [
                    MyProduct(
                      hasCart: true,
                      bloc: bloc,
                      hot: hot,
                      product: products[index],
                      image: products[index].image,
                      name: products[index].name,
                      price: products[index].price,
                      sale: products[index].sale,
                    ),
                    if (index < products.length - 1)
                      Container(
                        height: 0.7,
                        color: constColor.withOpacity(0.5),
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                      )
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
