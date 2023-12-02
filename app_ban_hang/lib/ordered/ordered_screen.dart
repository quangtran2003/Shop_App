import 'package:app_ban_hang/Home/bloc.dart';
import 'package:app_ban_hang/address/bloc.dart';
import 'package:app_ban_hang/component/const.dart';
import 'package:app_ban_hang/component/container.dart';
import 'package:app_ban_hang/component/icon.dart';
import 'package:app_ban_hang/component/text.dart';
import 'package:app_ban_hang/ordered/bloc.dart';
import 'package:app_ban_hang/ordered/dialog_comfrim.dart';
import 'package:flutter/material.dart';

class OrderedScreen extends StatelessWidget {
  OrderedScreen({super.key});
  final blocOrder = BlocOrdered();
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> data =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final BlocHome blocHome = data['_blocHome'];
    final BlocAddress blocAddress = data['_blocAddress'];
    blocHome.payAll();
    return Scaffold(
      appBar: AppBar(
        leading: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(HOME_SCREEN);
                  },
                  icon: const Icon(
                    Icons.home,
                    size: 30,
                  )),
            ),
            MyText(
              text: "Mã đơn hàng: ${blocOrder.generateRandomNumber()}",
              fontSize: 17,
            )
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: IconButton(
                onPressed: () {
                  showModalBottomSheet(
                      backgroundColor: Colors.transparent,
                      context: context,
                      builder: (builderContext) {
                        return const DialogComfrim();
                      });
                },
                icon: const MyIcon(icon: Icons.delete)),
          )
        ],
        leadingWidth: 300,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: MyContainer(
                width: double.infinity,
                boder: 10,
                color: Colors.grey.withOpacity(0.2),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyText(
                        text: 'Thông tin người nhận',
                        fontSize: 16,
                        textAlign: TextAlign.left,
                        fontWeight: FontWeight.bold,
                      ),
                      const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Divider(),
                      ),
                      MyText(
                        text: 'Người nhận: ${blocAddress.addressValue}',
                        fontSize: 16,
                        textAlign: TextAlign.left,
                      ),
                      MyText(
                        text: 'Số điện thoại: ${blocAddress.phoneValue}',
                        fontSize: 16,
                      ),
                      MyText(
                        text: 'Nhận hàng tại: ${blocAddress.addressValue}',
                        fontSize: 16,
                      ),
                    ],
                  ),
                ),
              ),
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
                        trailing:
                            MyText(text: 'X${blocHome.cart[index].number}'),
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
                              text: '+Nước chấm thần thánh! (+10.000 vnđ)',
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
                              text: '+Nộm dưa chuột siêu hot! (+20.000 vnđ)',
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
          ],
        ),
      ),
    );
  }
}
