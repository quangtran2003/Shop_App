// ignore_for_file: must_be_immutable

import 'package:app_ban_hang/Home/bloc.dart';
import 'package:app_ban_hang/address/bloc.dart';
import 'package:app_ban_hang/component/const.dart';
import 'package:app_ban_hang/component/container.dart';
import 'package:app_ban_hang/component/icon.dart';
import 'package:app_ban_hang/component/text.dart';
import 'package:flutter/material.dart';

class DialogScreen extends StatelessWidget {
  BlocHome blocHome;
  BlocAddress blocAddress;

  DialogScreen({
    Key? key,
    required this.blocHome,
    required this.blocAddress,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      color: Colors.transparent,
      child: Center(
        child: Container(
          height: 260,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
              color: const Color.fromARGB(255, 69, 188, 184),
              borderRadius: BorderRadius.circular(16)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 10),
                child: MyIcon(
                  icon: Icons.check_circle_outline,
                  size: 100,
                  color: Colors.white,
                ),
              ),
              MyText(
                text: 'Đặt Hàng Thành công!',
                color: Colors.black,
                fontSize: 25,
              ),
              MyText(
                text: 'Đơn hàng sẽ sớm được shipper giao đến tay bạn!',
                color: Colors.black,
                fontSize: 16,
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(HOME_SCREEN);
                      },
                      child: _buildButtom('Trang chủ'),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(ORDERED_SCREEN,
                            arguments: {
                              '_blocHome': blocHome,
                              '_blocAddress': blocAddress
                            });
                      },
                      child: _buildButtom('Xem đơn hàng'),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Expanded _buildButtom(String text) {
    return Expanded(
      flex: 1,
      child: Center(
        child: MyContainer(
          height: 40,
          width: 120,
          color: Colors.white,
          boder: 10,
          child: Center(
              child: MyText(
            text: text,
            color: Colors.black,
          )),
        ),
      ),
    );
  }
}
