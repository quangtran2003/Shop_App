// ignore_for_file: must_be_immutable, depend_on_referenced_packages, avoid_types_as_parameter_names

import 'package:app_ban_hang/Home/bloc.dart';
import 'package:app_ban_hang/component/const.dart';
import 'package:app_ban_hang/component/inf_product_screen.dart';
import 'package:app_ban_hang/component/text.dart';
import 'package:app_ban_hang/data/model.dart';
import 'package:flutter/material.dart';

class MyProduct extends StatelessWidget {
  BlocHome? bloc;
  ProductModel product;
  String? image;
  String? name;
  int? price;
  int? sale;
  bool hot;
  bool hasCart;
  double witdh;
  MyProduct({
    Key? key,
    this.bloc,
    required this.product,
    this.image,
    this.name,
    this.price,
    this.sale,
    required this.hot,
    required this.hasCart,
    this.witdh = 60,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        bloc?.countProduct = 1;
        if (hasCart) {
          showModalBottomSheet(
              context: context,
              builder: (builderContext) {
                return InforProductScreen(
                    context: context, product: product, bloc: bloc!);
              });
        }
      },
      child: ListTile(
          leading: Stack(
            alignment: Alignment.topLeft,
            children: [
              Container(
                width: witdh,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: AssetImage(image ?? ''), fit: BoxFit.cover)),
              ),
              if (hot == true)
                Container(
                  height: 25,
                  width: 18,
                  decoration: const BoxDecoration(
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(10)),
                    image: DecorationImage(
                        image: AssetImage('assets/hot.png'), fit: BoxFit.cover),
                  ),
                ),
            ],
          ),
          title: Container(
              alignment: Alignment.centerLeft, child: MyText(text: name ?? '')),
          subtitle: Row(children: [
            Container(
              width: 100,
              alignment: Alignment.centerLeft,
              child: MyText(
                text: '${format(price ?? 0)} vnđ',
                color: Colors.red,
                fontSize: 16,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 0),
              child: MyText(
                text: format(sale ?? 0),
                decoration: TextDecoration.lineThrough,
              ),
            ),
          ]),
          trailing: hasCart
              ? ElevatedButton(
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.black87),
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color.fromARGB(255, 255, 255, 255)),
                  ),
                  onPressed: () {
                    bloc?.addCart(product, bloc?.countProduct ?? 1);
                    bloc?.countCart();
                  },
                  child: const Icon(Icons.add_shopping_cart_rounded))
              : MyText(text: 'X${product.number}')),
    );
  }
}
