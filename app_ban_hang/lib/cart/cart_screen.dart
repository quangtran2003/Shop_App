// ignore_for_file: prefer_is_empty

import 'package:app_ban_hang/Home/bloc.dart';
import 'package:app_ban_hang/address/bloc.dart';
import 'package:app_ban_hang/cart/bloc.dart';
import 'package:app_ban_hang/component/const.dart';
import 'package:app_ban_hang/component/container.dart';
import 'package:app_ban_hang/component/icon.dart';
import 'package:app_ban_hang/component/text.dart';
import 'package:app_ban_hang/data/model.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final _blocCart = BlocCart();
  final _blocAddress = BlocAddress();
  @override
  void dispose() {
    super.dispose();
    _blocCart.dispose();
  }

  @override
  Widget build(BuildContext context) {
    BlocHome blocHome = ModalRoute.of(context)?.settings.arguments as BlocHome;
    blocHome.payCart();
    List<int> listProd = blocHome.listNumber;
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: const MyIcon(
            icon: Icons.arrow_back_ios_rounded,
            size: 25,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: MyText(
                text: 'Giỏ hàng', fontWeight: FontWeight.bold, fontSize: 17),
          )
        ],
      ),
      body: MyContainer(
        child: Column(children: [
          const Divider(),
          Expanded(
              child: StreamBuilder<List<ProductModel>>(
            initialData: blocHome.cart,
            stream: blocHome.streamCart,
            builder: (context, snapshot) {
              if (snapshot.data?.length == 0) {
                return SizedBox(
                  height: 400,
                  child: Center(
                    child: MyText(text: 'Bạn không có đơn hàng nào!'),
                  ),
                );
              } else {
                return ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index) {
                      if (snapshot.data != null) {
                        return Column(
                          children: [
                            ListTile(
                              leading: Container(
                                width: 60,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                        image: AssetImage(
                                            snapshot.data?[index].image ?? ''),
                                        fit: BoxFit.cover)),
                              ),
                              title: Container(
                                  alignment: Alignment.centerLeft,
                                  child: MyText(
                                      text: snapshot.data?[index].name ?? '')),
                              subtitle: Row(children: [
                                Container(
                                  width: 100,
                                  alignment: Alignment.centerLeft,
                                  child: MyText(
                                    text:
                                        '${format(snapshot.data?[index].price ?? 0)} vnđ',
                                    color: Colors.red,
                                    fontSize: 16,
                                  ),
                                ),
                              ]),
                              trailing: SizedBox(
                                width: 150,
                                child: Row(
                                  children: [
                                    MyContainer(
                                      height: 50,
                                      boder: 10,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  if (listProd[index] <= 1) {
                                                    return;
                                                  }
                                                  listProd[index]--;
                                                  blocHome.updateNumber(
                                                      index, listProd[index]);
                                                });
                                              },
                                              icon: const Icon(
                                                Icons.remove_circle_outlined,
                                                color: Colors.grey,
                                              )),
                                          MyText(
                                              text: listProd[index].toString()),
                                          IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  listProd[index] += 1;
                                                  blocHome.updateNumber(
                                                      index, listProd[index]);
                                                });
                                              },
                                              icon: const Icon(
                                                Icons.add_circle_outlined,
                                                color: Colors.red,
                                              ))
                                        ],
                                      ),
                                    ),
                                    Expanded(child: Container()),
                                    GestureDetector(
                                        onTap: () {
                                          blocHome.removeCart(index);
                                          blocHome.payCart();
                                        },
                                        child:
                                            const MyIcon(icon: Icons.delete)),
                                  ],
                                ),
                              ),
                            ),
                            if (index < snapshot.data!.length - 1)
                              Container(
                                height: 0.7,
                                color: constColor.withOpacity(0.5),
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 20),
                              )
                          ],
                        );
                      }
                      return null;
                    });
              }
            },
          )),
          MyContainer(
              height: 220,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StreamBuilder<bool>(
                      stream: blocHome.stremsideDishes,
                      initialData: blocHome.sideDishes,
                      builder: (context, snapshot) {
                        if (snapshot.data == true) {
                          return Container(
                            margin: const EdgeInsets.only(left: 20),
                            child: MyText(
                              text: 'Món đi kèm',
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        }
                        return Container();
                      }),
                  Expanded(
                    child: ListView.builder(
                        itemExtent: 40,
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          switch (index) {
                            case 0:
                              return StreamBuilder<bool>(
                                  stream: blocHome.streamDippingSauce,
                                  initialData: blocHome.dippingSauce,
                                  builder: (context, snapshot) {
                                    if (snapshot.data == true) {
                                      return ListTile(
                                        trailing: GestureDetector(
                                            onTap: () {
                                              blocHome.checkDippingSauce();
                                              blocHome.payCart();
                                              blocHome.hasSideDishes();
                                            },
                                            child: const MyIcon(
                                                icon: Icons.delete)),
                                        shape: BeveledRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        title: Container(
                                            alignment: Alignment.centerLeft,
                                            child: MyText(
                                                text:
                                                    '+Sốt chấm đặc biệti! (+20.000 vnđ)')),
                                      );
                                    }

                                    return Container();
                                  });
                            case 1:
                              return StreamBuilder<bool>(
                                  stream: blocHome.streamSoup,
                                  initialData: blocHome.soup,
                                  builder: (context, snapshot) {
                                    if (snapshot.data == true) {
                                      return ListTile(
                                        trailing: GestureDetector(
                                            onTap: () {
                                              blocHome.checkSoup();
                                              blocHome.payCart();
                                              blocHome.hasSideDishes();
                                            },
                                            child: const MyIcon(
                                                icon: Icons.delete)),
                                        shape: BeveledRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        title: Container(
                                            alignment: Alignment.centerLeft,
                                            child: MyText(
                                                text:
                                                    '+Nước chấm thần thánh! (+10.000 vnđ)')),
                                      );
                                    }

                                    return Container();
                                  });
                            case 2:
                              return StreamBuilder<bool>(
                                  stream: blocHome.streamCucumberSalad,
                                  initialData: blocHome.cucumberSalad,
                                  builder: (context, snapshot) {
                                    if (snapshot.data == true) {
                                      return ListTile(
                                        trailing: GestureDetector(
                                            onTap: () {
                                              blocHome.checkCucumberSalad();
                                              blocHome.payCart();
                                              blocHome.hasSideDishes();
                                            },
                                            child: const MyIcon(
                                                icon: Icons.delete)),
                                        shape: BeveledRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        title: Container(
                                            alignment: Alignment.centerLeft,
                                            child: MyText(
                                                text:
                                                    '+Nộm dưa chuột siêu hot! (+20.000 vnđ)')),
                                      );
                                    }

                                    return Container();
                                  });
                          }
                          return null;
                        }),
                  ),
                ],
              ))
        ]),
      ),
      bottomNavigationBar: MyContainer(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: MyContainer(
            height: 50,
            child: Row(children: [
              StreamBuilder(
                stream: blocHome.stremPrice,
                initialData: blocHome.priceProduct,
                builder: (context, snapshot) {
                  // print('${snapshot.data}aksdja');
                  if (snapshot.data != null) {
                    return MyContainer(
                      height: 50,
                      color: const Color.fromARGB(255, 211, 214, 216),
                      boder: 10,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Center(
                            child: MyText(
                          text: '${(snapshot.data ?? 0) ~/ 1000}.000 vnđ',
                          fontSize: 17,
                        )),
                      ),
                    );
                  }
                  return Container();
                },
              ),
              Expanded(
                child: StreamBuilder(
                  initialData: blocHome.cart,
                  stream: blocHome.streamCart,
                  builder: (context, snapshot) {
                    return GestureDetector(
                        onTap: () {
                          if (snapshot.data?.length != 0) {
                            !_blocAddress.checkAddress
                                ? Navigator.of(context).pushNamed(
                                    ADDRESS_SCREEN,
                                    arguments: blocHome)
                                : Navigator.of(context)
                                    .pushNamed(PAY_SCREEN, arguments: blocHome);
                          }
                        },
                        child: Container(
                          margin: const EdgeInsets.only(left: 10),
                          decoration: BoxDecoration(
                              color: snapshot.data?.length == 0
                                  ? Colors.grey
                                  : constColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: StreamBuilder<bool>(
                                stream: _blocAddress.streamCheck,
                                builder: (context, snapshot) {
                                  return MyText(
                                    text: snapshot.data == true
                                        ? 'Tới trang thanh toán'
                                        : 'Địa chỉ nhận hàng',
                                    fontSize: 17,
                                    color: Colors.white,
                                  );
                                }),
                          ),
                        ));
                  },
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
