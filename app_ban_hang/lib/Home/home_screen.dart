// ignore_for_file: non_constant_identifier_names, avoid_types_as_parameter_names

import 'package:app_ban_hang/Home/bloc.dart';
import 'package:app_ban_hang/Home/list_product_screen.dart';
import 'package:app_ban_hang/address/bloc.dart';
import 'package:app_ban_hang/component/const.dart';
import 'package:app_ban_hang/component/icon.dart';
import 'package:app_ban_hang/component/product.dart';
import 'package:app_ban_hang/component/text.dart';
import 'package:app_ban_hang/data/data.dart';
import 'package:app_ban_hang/data/model.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final BlocHome _blocHome = BlocHome();
  @override
  void dispose() {
    super.dispose();
    _blocHome.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<ProductModel> products = List<ProductModel>.from(
        data.map((item) => ProductModel.fromJson(item)));
    ModalRoute.of(context)?.settings.arguments == null
        ? _blocHome.order = 0
        : _blocHome.order = 1;

    Map<String, dynamic>? dataa =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final BlocHome ? blocHome = dataa?['_blocHome'];
    final BlocAddress? blocAddress = dataa?['_blocAddress'];
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        leadingWidth: 100,
        leading: Container(
          margin: const EdgeInsets.fromLTRB(10, 10, 0, 0),
          width: double.infinity,
          alignment: Alignment.bottomLeft,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            image: DecorationImage(
                image: AssetImage('assets/logo.png'), fit: BoxFit.cover),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: badges.Badge(
              badgeContent: Text(_blocHome.order.toString()),
              child: IconButton(
                  onPressed: () {
                   if (_blocHome.order!=0) {
                      Navigator.of(context).pushNamed(ORDERED_SCREEN, arguments: {
                      '_blocHome': blocHome,
                      '_blocAddress': blocAddress
                    });
                   }
                  },
                  icon: const Icon(
                    Icons.payment,
                    size: 35,
                  )),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(alignment: Alignment.center, children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  height: double.infinity,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      image: DecorationImage(
                          image: AssetImage('assets/background.png'),
                          fit: BoxFit.cover)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Container(
                  height: 80,
                  width: double.infinity,
                  color: Colors.grey.withOpacity(0.8),
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        MyText(
                          text: '40 món ngon khao miễn phí hôm nay',
                          fontSize: 20,
                          color: Colors.white,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            double screenHeight =
                                MediaQuery.of(context).size.height;
                            double bottomSheetHeight = (4.3 / 5) * screenHeight;

                            showModalBottomSheet(
                                isScrollControlled: true,
                                context: context,
                                builder: (BuildContext) {
                                  return ListProduct(
                                      context: context,
                                      bottomSheetHeight: bottomSheetHeight,
                                      products: products,
                                      bloc: _blocHome);
                                });
                          },
                          style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.red),
                          ),
                          child: MyText(text: 'Nhận ngay'),
                        )
                      ]),
                ),
              ),
            ]),
          ),
          SizedBox(
            height: 100,
            // color: Colors.grey,
            width: double.infinity,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                            child: StreamBuilder<List<ProductModel>>(
                          stream: _blocHome.streamCart,
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Container();
                            }
                            if (snapshot.data!.isNotEmpty) {
                              return Container(
                                height: 50,
                                alignment: Alignment.centerRight,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: snapshot.data?.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                          width: 40,
                                          height: 40,
                                          child: badges.Badge(
                                            badgeContent: Text(snapshot
                                                    .data?[index].number
                                                    .toString() ??
                                                '1'),
                                            child: CircleAvatar(
                                              radius: 30,
                                              backgroundImage: AssetImage(
                                                  snapshot.data?[index].image ??
                                                      ''),
                                            ),
                                          ));
                                    }),
                              );
                            }
                            return Container();
                          },
                        )),
                        GestureDetector(
                          onTap: () {
                            _blocHome.initData();
                            _blocHome.payCart();
                            _blocHome.hasSideDishes();
                            Navigator.of(context)
                                .pushNamed(CART_SCREEN, arguments: _blocHome);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: StreamBuilder<int>(
                              stream: _blocHome.stremCountList,
                              initialData: 0,
                              builder: (context, snapshot) {
                                return badges.Badge(
                                  badgeContent: Text(snapshot.data.toString()),
                                  child: Container(
                                    //  margin: EdgeInsets.only(right: ),
                                    height: 40,
                                    decoration: BoxDecoration(
                                        color: constColor,
                                        borderRadius: BorderRadius.circular(5)),
                                    width: 150,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        const MyIcon(
                                          icon: Icons.shopify_outlined,
                                          color: Colors.white,
                                        ),
                                        MyText(
                                          text: 'Xem giỏ hàng',
                                          color: Colors.white,
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(),
                    height: 1,
                    color: constColor,
                  ),
                ]),
          ),
          Container(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              alignment: Alignment.centerLeft,
              child: MyText(
                text: 'Món Ngon Nên Thử!',
                fontSize: 25,
                fontWeight: FontWeight.bold,
              )),
          GestureDetector(
            child: SizedBox(
              height: 300,
              child: ListView.builder(
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        MyProduct(
                          hasCart: true,
                          bloc: _blocHome,
                          product: products[index],
                          image: products[index].image,
                          name: products[index].name,
                          price: products[index].price,
                          sale: products[index].sale,
                          hot: true,
                        ),
                        if (index < 3)
                          Container(
                            height: 0.7,
                            color: constColor.withOpacity(0.5),
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                          )
                      ],
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
