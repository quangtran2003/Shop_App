// ignore_for_file: must_be_immutable

import 'package:app_ban_hang/Home/bloc.dart';
import 'package:app_ban_hang/component/const.dart';
import 'package:app_ban_hang/component/container.dart';
import 'package:app_ban_hang/component/text.dart';
import 'package:app_ban_hang/data/model.dart';
import 'package:flutter/material.dart';

class InforProductScreen extends StatelessWidget {
  BuildContext context;
  ProductModel product;
  BlocHome bloc;

  InforProductScreen({
    Key? key,
    required this.context,
    required this.product,
    required this.bloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double x = MediaQuery.of(context).size.height;
    return SizedBox(
      height: x * 3 / 4,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: ListTile(
              leading: Container(
                width: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: AssetImage(product.image ?? ''),
                        fit: BoxFit.cover)),
              ),
              title: Container(
                  alignment: Alignment.centerLeft,
                  child: MyText(text: product.name ?? '')),
              subtitle: Row(children: [
                Container(
                  width: 100,
                  alignment: Alignment.centerLeft,
                  child: MyText(
                    text: '${format(product.price ?? 0)} vnđ',
                    color: Colors.red,
                    fontSize: 16,
                  ),
                ),
                MyText(
                  text: format(product.sale ?? 0),
                  decoration: TextDecoration.lineThrough,
                ),
              ]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText(
                  text: 'Món đi kèm',
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
                GestureDetector(
                  onTap: () {
                    bloc.checkDippingSauce();
                  },
                  child: _buildSpice(bloc.streamDippingSauce, bloc.dippingSauce,
                      'Sốt chấm đặc biệt! (+20.000 vnđ)'),
                ),
                GestureDetector(
                  onTap: () {
                    bloc.checkSoup();
                  },
                  child: _buildSpice(bloc.streamSoup, bloc.soup,
                      'Muối chấm thần thánh! (+10.000 vnđ)'),
                ),
                GestureDetector(
                  onTap: () {
                    bloc.checkCucumberSalad();
                  },
                  child: _buildSpice(
                      bloc.streamCucumberSalad,
                      bloc.cucumberSalad,
                      'Nộm dưa chuột siêu hot! (+20.000 vnđ)'),
                )
              ],
            ),
          ),
          Expanded(child: Container()),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: MyContainer(
              height: 50,
              child: Row(
                children: [
                  MyContainer(
                    height: 50,
                    color: const Color.fromARGB(255, 226, 234, 241),
                    boder: 10,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                            onPressed: () {
                              bloc.countRemoveHome(product);
                            },
                            icon: const Icon(
                              Icons.remove_circle_outlined,
                              color: Colors.grey,
                            )),
                        StreamBuilder<int>(
                            initialData: 1,
                            stream: bloc.stremCountCartProduct,
                            builder: (context, snapShot) {
                              return Text(snapShot.data.toString());
                            }),
                        IconButton(
                            onPressed: () {
                              bloc.countAddHome(product);
                            },
                            icon: const Icon(
                              Icons.add_circle_outlined,
                              color: Colors.red,
                            ))
                      ],
                    ),
                  ),
                  Expanded(
                      child: GestureDetector(
                    onTap: () {
                      bloc.addCart(product, bloc.countProduct);
                      bloc.countCart();
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      margin: const EdgeInsets.only(left: 20),
                      decoration: BoxDecoration(
                          color: constColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: MyText(
                          text: 'Thêm vào giỏ hàng',
                          fontSize: 17,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  StreamBuilder<bool> _buildSpice(Stream<bool> stream, bool init, String text) {
    return StreamBuilder<bool>(
        initialData: init,
        stream: stream,
        builder: (context, snapShoot) {
          return Container(
            margin: const EdgeInsets.only(top: 15),
            decoration: BoxDecoration(
                color: const Color.fromARGB(
                    255, 226, 234, 241), // Đặt màu nền của ListTile
                borderRadius: BorderRadius.circular(10),
                border: snapShoot.data == true
                    ? Border.all(color: Colors.red)
                    : null),
            child: ListTile(
              shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              title: Container(
                  alignment: Alignment.centerLeft, child: MyText(text: text)),
            ),
          );
        });
  }
}
