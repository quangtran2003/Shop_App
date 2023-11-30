import 'package:app_ban_hang/Home/bloc.dart';
import 'package:app_ban_hang/component/const.dart';
import 'package:app_ban_hang/component/container.dart';
import 'package:app_ban_hang/component/icon.dart';
import 'package:app_ban_hang/component/text.dart';
import 'package:flutter/material.dart';

class PayScreen extends StatelessWidget {
  PayScreen({super.key});
  final _blocHome = BlocHome();
  @override
  Widget build(BuildContext context) {
    double x = MediaQuery.of(context).size.height;
    double y = MediaQuery.of(context).size.width;
    //  BlocHome _blocHome = ModalRoute.of(context)?.settings.arguments as BlocHome;
    _blocHome.pay();
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
          Padding(
            padding: const EdgeInsets.only(right: 20, top: 10, bottom: 10),
            child: MyContainer(
              color: constColor,
              boder: 10,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  //mainAxisAlignment: ,
                  children: [
                    const Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                    MyText(
                      text: 'Sửa đơn hàng',
                      color: Colors.white,
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
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
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Divider(
                        color: constColor,
                      ),
                    ),
                    StreamBuilder<TRANSPORT>(
                        stream: _blocHome.streamTransport,
                        initialData: TRANSPORT.NORMAL,
                        builder: (context, snapshot) {
                          return Column(
                            children: [
                              RadioListTile(
                                value: snapshot.data,
                                groupValue: TRANSPORT.NORMAL,
                                onChanged: (value) {
                                  _blocHome.checkTranport();
                                },
                                title: MyText(
                                    text: 'Giao hàng thường (+15.000)',
                                    textAlign: TextAlign.left),
                                subtitle: MyText(
                                    text: 'Khoảng 3-4 giờ sau khi đặt hàng!',
                                    textAlign: TextAlign.left),
                              ),
                              RadioListTile(
                                value: snapshot.data,
                                groupValue: TRANSPORT.FASST,
                                onChanged: (value) {
                                  _blocHome.checkTranport();
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
                                    text: 'Khoảng 30 phút sau khi đặt hàng!',
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
                            padding: const EdgeInsets.only(top: 10, left: 10),
                            child: MyText(
                              text: 'Dịch vụ tặng quà',
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
                              stream: _blocHome.stremFlower,
                              initialData: false,
                              builder: (context, snapshot) {
                                return RadioListTile(
                                  value: snapshot.data,
                                  groupValue: true,
                                  onChanged: (value) {
                                    _blocHome.checkFlower();
                                  },
                                  secondary: GestureDetector(
                                    onTap: () {
                                      showModalBottomSheet(
                                          context: context,
                                          builder: (BuildContext) {
                                            return _buildBottomSheet(
                                                'Túi thủ công vintage để đựng quà / đồ ăn / thức uống bên trong',
                                                'assets/tui.jpg',
                                                x);
                                          });
                                    },
                                    child: const MyIcon(
                                      icon: Icons.question_mark,
                                    ),
                                  ),
                                  title: MyText(
                                      text: 'Túi đựng quà (+30.000)',
                                      textAlign: TextAlign.left),
                                );
                              }),
                          StreamBuilder<bool>(
                              stream: _blocHome.streamBag,
                              builder: (context, snapshot) {
                                return RadioListTile(
                                  value: snapshot.data,
                                  groupValue: true,
                                  onChanged: (value) {
                                    _blocHome.checkBag();
                                  },
                                  shape: const BeveledRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                          bottom: Radius.circular(8))),
                                  secondary: const MyIcon(
                                    icon: Icons.question_mark,
                                  ),
                                  title: MyText(
                                      text: 'Bó hoa tươi (+70.000)',
                                      textAlign: TextAlign.left),
                                );
                              }),
                        ])),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomSheet(String text, String image, double height) =>
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        height: height,
        child: Column(
          children: [
            ListTile(
              tileColor: Colors.grey.withOpacity(0.7),
              shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              title: MyText(
                textAlign: TextAlign.left,
                text: text,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
                child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        image: DecorationImage(
                            image: AssetImage(image), fit: BoxFit.cover))))
          ],
        ),
      );
}
