import 'package:app_ban_hang/component/const.dart';
import 'package:app_ban_hang/component/container.dart';
import 'package:app_ban_hang/component/text.dart';
import 'package:flutter/material.dart';

class DialogComfrim extends StatelessWidget {
  const DialogComfrim({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: Center(
        child: Container(
          height: 130,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.only(top: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              MyText(
                maxLine: 2,
                text: 'Xác nhận hủy đơn hàng!',
                color: Colors.black,
                fontSize: 25,
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildButtom(
                      'Hủy bỏ',
                      Colors.grey.withOpacity(0.5),
                      () {
                        Navigator.of(context).pop();
                      },
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    _buildButtom(
                      'Đồng ý',
                      const Color.fromARGB(255, 255, 53, 39),
                      () {
                        Navigator.of(context).pushNamed(HOME_SCREEN);
                      },
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

  Expanded _buildButtom(String text, Color color, void Function()? onTap) {
    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: onTap,
        child: Center(
          child: MyContainer(
            height: 40,
            width: 120,
            color: color,
            boder: 10,
            child: Center(
                child: MyText(
              fontWeight: FontWeight.bold,
              text: text,
              color: Colors.black,
            )),
          ),
        ),
      ),
    );
  }
}
