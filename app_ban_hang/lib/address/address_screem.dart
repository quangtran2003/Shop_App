import 'package:app_ban_hang/Home/bloc.dart';
import 'package:app_ban_hang/address/bloc.dart';
import 'package:app_ban_hang/component/const.dart';
import 'package:app_ban_hang/component/container.dart';
import 'package:app_ban_hang/component/icon.dart';
import 'package:app_ban_hang/component/text.dart';
import 'package:app_ban_hang/component/textfield.dart';
import 'package:flutter/material.dart';

class AddressSCreen extends StatefulWidget {
  const AddressSCreen({super.key});

  @override
  State<AddressSCreen> createState() => _AddressSCreenState();
}

class _AddressSCreenState extends State<AddressSCreen> {
  final _blocAddress = BlocAddress();

  @override
  Widget build(BuildContext context) {
    BlocHome blocHome = ModalRoute.of(context)?.settings.arguments as BlocHome;

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: const MyIcon(
            icon: Icons.arrow_back_ios,
            size: 25,
          ),
        ),
        title: MyText(text: "Địa chỉ thanh toán"),
      ),
      body: Container(
        //height: 600,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: MyText(
                text: 'Địa chỉ giao hàng',
              ),
            ),
            StreamBuilder<String?>(
                stream: _blocAddress.streamAddress,
                builder: (context, snapshot) {
                  return MyTextField(
                    errorText: snapshot.data,
                    onChange: (String value) {
                      _blocAddress.isAddress(value);
                    },
                  );
                }),
            MyText(text: 'Số điện thoại'),
            StreamBuilder<String?>(
                stream: _blocAddress.streamPhone,
                builder: (context, snapshot) {
                  return MyTextField(
                    errorText: snapshot.data,
                    onChange: (String value) {
                      _blocAddress.isPhoneNumber(value);
                    },
                  );
                }),
            MyText(text: 'Tên người nhận'),
            StreamBuilder<String?>(
                stream: _blocAddress.streamName,
                builder: (context, snapshot) {
                  return MyTextField(
                    errorText: snapshot.data,
                    onChange: (String value) {
                      _blocAddress.isName(value);
                    },
                  );
                }),
            Expanded(child: Container()),
            StreamBuilder<bool>(
                stream: _blocAddress.streamCheck,
                builder: (context, snapshot) {
                  return GestureDetector(
                    onTap: () {
                      if (snapshot.data == true) {
                        Navigator.of(context).pushNamed(PAY_SCREEN, arguments: {
                          '_blocHome': blocHome,
                          '_blocAddress': _blocAddress
                        });
                      }
                    },
                    child: MyContainer(
                      height: 50,
                      boder: 10,
                      color: snapshot.data == true ? constColor : Colors.grey,
                      child: Center(
                        child: MyText(
                          text: 'Đi tới thanh toán',
                          color: Colors.white,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}
