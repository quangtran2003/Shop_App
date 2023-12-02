// ignore_for_file: avoid_types_as_parameter_names

import 'package:app_ban_hang/Home/bloc.dart';
import 'package:app_ban_hang/address/bloc.dart';
import 'package:app_ban_hang/component/const.dart';
import 'package:app_ban_hang/component/container.dart';
import 'package:app_ban_hang/component/icon.dart';
import 'package:app_ban_hang/component/text.dart';
import 'package:app_ban_hang/pay/dialog_assess.dart';
import 'package:flutter/material.dart';

class PayScreen extends StatefulWidget {
  const PayScreen({super.key});

  @override
  State<PayScreen> createState() => _PayScreenState();
}

class _PayScreenState extends State<PayScreen> {
  @override
  Widget build(BuildContext context) {
    double x = MediaQuery.of(context).size.height;
    Map<String, dynamic> data =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final BlocHome blocHome = data['_blocHome'];
    final BlocAddress blocAddress = data['_blocAddress'];
    blocHome.payAll();
    blocHome.hasSideDishes();
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const MyIcon(icon: Icons.arrow_back_ios)),
        title: MyText(
          text: 'Thanh toán',
          fontWeight: FontWeight.bold,
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(CART_SCREEN, arguments: blocHome);
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 20, top: 10, bottom: 10),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: constColor),
                    color: constColor.withOpacity(0.1)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.edit,
                        size: 20,
                        //  color: Colors.white,
                      ),
                      MyText(
                        text: 'Sửa đơn hàng',
                        color: Colors.black,
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  MyContainer(
                    boder: 10,
                    color: Colors.grey.withOpacity(0.2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10, left: 10),
                          child: MyText(
                            text: 'Tùy chọn giao hàng',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Divider(
                            color: constColor,
                          ),
                        ),
                        StreamBuilder<TRANSPORT>(
                            stream: blocHome.streamTransport,
                            initialData: TRANSPORT.NORMAL,
                            builder: (context, snapshot) {
                              return Column(
                                children: [
                                  RadioListTile(
                                    value: snapshot.data,
                                    groupValue: TRANSPORT.NORMAL,
                                    onChanged: (value) {
                                      blocHome.checkTranport(TRANSPORT.NORMAL);
                                      blocHome.payAll();
                                    },
                                    title: MyText(
                                        text: 'Giao hàng thường (+15.000)',
                                        textAlign: TextAlign.left),
                                    subtitle: MyText(
                                        text:
                                            'Khoảng 3-4 giờ sau khi đặt hàng!',
                                        textAlign: TextAlign.left),
                                  ),
                                  RadioListTile(
                                    value: snapshot.data,
                                    groupValue: TRANSPORT.FASST,
                                    onChanged: (value) {
                                      blocHome.checkTranport(TRANSPORT.FASST);
                                      blocHome.payAll();
                                    },
                                    shape: const BeveledRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                            bottom: Radius.circular(8))),
                                    secondary: MyIcon(
                                      icon: Icons.flash_on_outlined,
                                      color: snapshot.data == TRANSPORT.FASST
                                          ? Colors.orange
                                          : null,
                                    ),
                                    title: MyText(
                                        text: 'Giao hàng hỏa tốc (+30.000)',
                                        textAlign: TextAlign.left),
                                    subtitle: MyText(
                                        text:
                                            'Khoảng 30 phút sau khi đặt hàng!',
                                        textAlign: TextAlign.left),
                                  ),
                                ],
                              );
                            }),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: MyContainer(
                        boder: 10,
                        color: Colors.grey.withOpacity(0.2),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 10, left: 10),
                                child: MyText(
                                  text: 'Dịch vụ tặng quà',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Divider(
                                  color: constColor,
                                ),
                              ),
                              StreamBuilder<bool>(
                                  stream: blocHome.streamBag,
                                  initialData: false,
                                  builder: (context, snapshot) {
                                    return ListTile(
                                      onTap: () {
                                        blocHome.checkBag();
                                        blocHome.payGifsPrice();
                                        blocHome.payAll();
                                      },
                                      leading: snapshot.data == false
                                          ? const Icon(
                                              Icons.check_box_outline_blank)
                                          : const Icon(
                                              Icons.check_box_outlined),
                                      trailing: GestureDetector(
                                        onTap: () {
                                          showModalBottomSheet(
                                              context: context,
                                              isScrollControlled: true,
                                              builder: (builderContext) {
                                                return _buildBottomSheet(
                                                    'Túi thủ công vintage để đựng quà / đồ ăn / thức uống bên trong',
                                                    'assets/tui.jpg',
                                                    x);
                                              });
                                        },
                                        child: const MyIcon(
                                          icon: Icons.question_mark,
                                          size: 20,
                                        ),
                                      ),
                                      title: MyText(
                                          text: 'Túi đựng quà (+30.000)',
                                          textAlign: TextAlign.left),
                                    );
                                  }),
                              StreamBuilder<bool>(
                                  initialData: false,
                                  stream: blocHome.stremFlower,
                                  builder: (context, snapshot) {
                                    return ListTile(
                                      onTap: () {
                                        blocHome.checkFlower();
                                        blocHome.payGifsPrice();
                                        blocHome.payAll();
                                      },
                                      leading: snapshot.data == false
                                          ? const Icon(
                                              Icons.check_box_outline_blank)
                                          : const Icon(
                                              Icons.check_box_outlined),
                                      shape: const BeveledRectangleBorder(
                                          borderRadius: BorderRadius.vertical(
                                              bottom: Radius.circular(8))),
                                      trailing: GestureDetector(
                                        onTap: () {
                                          showModalBottomSheet(
                                              context: context,
                                              isScrollControlled: true,
                                              // ignore: non_constant_identifier_names
                                              builder: (BuildContext) {
                                                return _buildBottomSheet(
                                                    'Bó hoa tươi tặng người mình thương tặng kèm 1 thiệp chúc những lời yêu thương',
                                                    'assets/hoa.jpg',
                                                    x);
                                              });
                                        },
                                        child: const MyIcon(
                                          icon: Icons.question_mark,
                                          size: 20,
                                        ),
                                      ),
                                      title: MyText(
                                          text: 'Bó hoa tươi (+100.000)',
                                          textAlign: TextAlign.left),
                                    );
                                  }),
                            ])),
                  ),
                  Container(
                    alignment: Alignment.bottomLeft,
                    child: MyText(
                      textAlign: TextAlign.left,
                      text: "Sản phẩm đã chọn",
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: blocHome.cart.length * 70,
                    child: ListView.builder(
                        itemCount: blocHome.cart.length,
                        cacheExtent: 70,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: const EdgeInsets.only(top: 5),
                            height: 70,
                            child: ListTile(
                              leading: Container(
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        image: AssetImage(
                                          blocHome.cart[index].image ?? '',
                                        ),
                                        fit: BoxFit.cover,
                                      ))),
                              subtitle: MyText(
                                text:
                                    'Giá: ${format(blocHome.cart[index].price ?? 0)} vnđ',
                                textAlign: TextAlign.left,
                              ),
                              title: MyText(
                                text: blocHome.cart[index].name ?? '',
                                textAlign: TextAlign.left,
                              ),
                              trailing: MyText(
                                  text: 'X${blocHome.cart[index].number}'),
                            ),
                          );
                        }),
                  ),
                  Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          StreamBuilder<bool>(
                              stream: blocHome.stremsideDishes,
                              initialData: blocHome.sideDishes,
                              builder: (context, snapshot) {
                                if (snapshot.data == true) {
                                  return MyText(
                                    text: 'Món đi kèm',
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  );
                                }
                                return Container();
                              }),
                          StreamBuilder<bool>(
                              stream: blocHome.streamDippingSauce,
                              initialData: blocHome.dippingSauce,
                              builder: (context, snapshot) {
                                if (snapshot.data == true) {
                                  return MyText(
                                    textAlign: TextAlign.left,
                                    text: '+Sốt chấm đặc biệti! (+20.000 vnđ)',
                                    fontSize: 16,
                                  );
                                }

                                return Container();
                              }),
                          StreamBuilder<bool>(
                              stream: blocHome.streamSoup,
                              initialData: blocHome.soup,
                              builder: (context, snapshot) {
                                if (snapshot.data == true) {
                                  return MyText(
                                    textAlign: TextAlign.left,
                                    text:
                                        '+Nước chấm thần thánh! (+10.000 vnđ)',
                                    fontSize: 16,
                                  );
                                }

                                return Container();
                              }),
                          StreamBuilder<bool>(
                              stream: blocHome.streamCucumberSalad,
                              initialData: blocHome.cucumberSalad,
                              builder: (context, snapshot) {
                                if (snapshot.data == true) {
                                  return MyText(
                                    textAlign: TextAlign.left,
                                    text:
                                        '+Nộm dưa chuột siêu hot! (+20.000 vnđ)',
                                    fontSize: 16,
                                  );
                                }

                                return Container();
                              }),
                        ],
                      )),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    alignment: Alignment.centerLeft,
                    child: MyText(
                      text: 'Tạm tính',
                      fontSize: 16,
                      textAlign: TextAlign.left,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MyText(
                        text: 'Giá món:',
                        fontSize: 15,
                      ),
                      Expanded(child: Container()),
                      MyText(text: '${format(blocHome.priceProduct)} vnđ')
                    ],
                  ),
                  StreamBuilder<TRANSPORT>(
                      stream: blocHome.streamTransport,
                      initialData: TRANSPORT.NORMAL,
                      builder: (context, snapshot) {
                        return Row(
                          children: [
                            MyText(
                              text: 'Phí vận chuyển',
                              fontSize: 15,
                            ),
                            Expanded(child: Container()),
                            MyText(
                                text: snapshot.data == TRANSPORT.NORMAL
                                    ? '${format(15000)} vnđ'
                                    : '${format(30000)} vnđ')
                          ],
                        );
                      }),
                  StreamBuilder<int>(
                      stream: blocHome.streamGifsPrice,
                      initialData: blocHome.gifsPrice,
                      builder: (context, snapshot) {
                        if (snapshot.data != 0) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              MyText(
                                text: 'Dịch vụ tặng quà:',
                                fontSize: 15,
                              ),
                              Expanded(child: Container()),
                              MyText(text: '${format(snapshot.data ?? 0)} vnđ')
                            ],
                          );
                        }
                        return Container();
                      }),
                  const Divider(
                    color: constColor,
                  ),
                  StreamBuilder<int>(
                      stream: blocHome.streampayAll,
                      initialData: blocHome.priceAll,
                      builder: (context, snapshot) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              MyText(
                                text: 'Tổng (COD):',
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: constColor,
                              ),
                              Expanded(child: Container()),
                              MyText(
                                text: '${format(snapshot.data ?? 0)} vnđ',
                                fontSize: 18,
                                color: constColor,
                                fontWeight: FontWeight.bold,
                              )
                            ],
                          ),
                        );
                      }),
                  const SizedBox(
                    height: 160,
                  )
                ],
              ),
            ),
          ),
          Container(
            height: 150,
            color: Colors.white,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  height: 60,
                  decoration: BoxDecoration(
                      color: constColor.withOpacity(0.1),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      border: Border.all(color: constColor)),
                  child: ListTile(
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(ADDRESS_SCREEN, arguments: blocHome);
                    },
                    title: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        MyText(
                          text: 'Giao hàng đến  ',
                          fontSize: 14,
                        ),
                        const MyIcon(
                          icon: Icons.edit_square,
                          size: 15,
                        )
                      ],
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: MyText(
                        textAlign: TextAlign.left,
                        text: blocAddress.addressValue,
                        maxLine: 1,
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                        isDismissible: false,
                        backgroundColor: Colors.transparent,
                        context: context,
                        builder: (builderContext) {
                          return DialogScreen(
                            blocHome: blocHome,
                            blocAddress: blocAddress,
                          );
                        });
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 15, 20, 10),
                    child: MyContainer(
                      height: 60,
                      width: double.infinity,
                      boder: 10,
                      color: constColor,
                      child: Center(
                          child: MyText(
                        text: 'Đặt hàng',
                        color: Colors.white,
                        fontSize: 20,
                      )),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomSheet(String text, String image, double height) =>
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        height: height * 3 / 5,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: ListTile(
                tileColor: Colors.grey.withOpacity(0.3),
                shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none),
                title: MyText(
                  textAlign: TextAlign.left,
                  text: text,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
                child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    height: double.infinity,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        image: DecorationImage(
                            image: AssetImage(image), fit: BoxFit.cover))))
          ],
        ),
      );
}
