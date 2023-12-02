// ignore_for_file: non_constant_identifier_names, avoid_types_as_parameter_names

import 'package:app_ban_hang/Home/bloc.dart';
import 'package:app_ban_hang/Home/list_product_screen.dart';
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
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 20, 0),
            child: GestureDetector(
                onTap: () {
                  //   Navigator.of(context).pushNamed(PAY_SCREEN);
                },
                child: const Icon(Icons.more_horiz)),
          )
        ],
        leadingWidth: 100,
        leading: Container(
          margin: const EdgeInsets.fromLTRB(10, 10, 0, 0),
          width: double.infinity,
          alignment: Alignment.bottomLeft,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            image: DecorationImage(
                image:
                    // NetworkImage(
                    //     'https://image.similarpng.com/thumbnail/2020/11/Online-Shop-logo-isolated-on-transparent-PNG.png'),
                    // fit: BoxFit.cover,
                    AssetImage('pizza.jpg'),
                fit: BoxFit.cover),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(alignment: Alignment.center, children: [
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(vertical: 20),
                height: double.infinity,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                    image: DecorationImage(
                        image: AssetImage('background.png'),
                        fit: BoxFit.cover)),
              ),
              Container(
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
