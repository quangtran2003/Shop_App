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
          height: 170,
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
                text: 'Bạn có chắc chắn sẽ hủy đơn hàng này chứ!',
                color: Colors.black,
                fontSize: 25,
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child:
                          _buildButtom('Hủy bỏ', Colors.grey.withOpacity(0.5)),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(HOME_SCREEN);
                      },
                      child: _buildButtom('Đồng ý', Colors.red),
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

  Expanded _buildButtom(String text, Color color) {
    return Expanded(
      flex: 1,
      child: Center(
        child: MyContainer(
          height: 40,
          width: 120,
          color: color,
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
