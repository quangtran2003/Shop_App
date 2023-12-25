import 'package:app_ban_hang/Home/home_screen.dart';
import 'package:app_ban_hang/component/text.dart';
import 'package:app_ban_hang/login_resiger/resiger_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../component/textfield.dart';

class Resiger extends GetView<ResigerController> {
  @override
  final controller = Get.put(ResigerController());
  Resiger({super.key});

  @override
  Widget build(BuildContext context) {
    final x = MediaQuery.of(context).size.height;
    final y = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: x,
          width: y,
          color: const Color.fromARGB(255, 245, 229, 246),
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(top: 40, bottom: 20),
                    height: x * 2 / 7,
                    width: x * 2 / 7,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: const DecorationImage(
                            image: AssetImage(
                              'assets/background.png',
                            ),
                            opacity: 0.9,
                            fit: BoxFit.cover)),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.bottomLeft,
                child: const Text(
                  'Đăng kí',
                  style: TextStyle(
                      color: Colors.purple,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Obx(
                () => MyTextField(
                  textHint: 'Nhập email của bạn',
                  errorText: controller.emailError.value,
                  onChange: (value) {
                    controller.validateEmail(value);
                    controller.resiger();
                  },
                ),
              ),
              Obx(
                () => MyTextField(
                  textHint: 'Nhập mật khẩu',
                  hasPass: true,
                  errorText: controller.passWordError.value,
                  onChange: (value) {
                    controller.validatePassWord(value);
                    controller.resiger();
                  },
                ),
              ),
              Obx(
                () => MyTextField(
                  textHint: 'Xác nhận mật khẩu',
                  hasPass: true,
                  errorText: controller.confrimPassWordError.value,
                  onChange: (value) {
                    controller.validateConfrimPassWord(value);
                    controller.resiger();
                  },
                ),
              ),
              Obx(
                () => GestureDetector(
                  onTap: () {
                    controller.createAcc(controller.email.value ?? '',
                        controller.passWord.value ?? '');
                    if (controller.checkResiger.value) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeScreen()),
                      );
                    }
                  },
                  child:
                      // Obx(
                      //   () =>
                      Container(
                    margin: EdgeInsets.only(top: 30, bottom: x > 500 ? 50 : 20),
                    height: 60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: controller.checkResiger.value
                            ? Colors.purple
                            : null,
                        border: Border.all(
                            width: 1,
                            color: const Color.fromARGB(255, 104, 104, 104)),
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(
                        child: MyText(
                      text: "Đăng kí",
                      color: controller.checkResiger.value
                          ? Colors.white
                          : Colors.grey,
                      fontSize: 20,
                    )),
                  ),
                  // ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
