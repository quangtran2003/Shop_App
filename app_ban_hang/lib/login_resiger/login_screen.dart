import 'package:app_ban_hang/Home/home_screen.dart';
import 'package:app_ban_hang/component/const.dart';
import 'package:app_ban_hang/component/text.dart';
import 'package:app_ban_hang/component/textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'login_controller.dart';

class Login extends GetView<LoginController> {
  @override
  final controller = Get.put(LoginController());
  Login({super.key});
  @override
  Widget build(BuildContext context) {
    final x = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: x,
          color: const Color.fromARGB(255, 245, 229, 246),
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: Container(
                    margin: const EdgeInsets.only(top: 80, bottom: 40),
                    height: x / 3,
                    width: x / 3,
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
                  child: MyText(
                    text: 'Đăng nhập',
                    color: Colors.purple,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  )),
              Obx(
                () => MyTextField(
                  errorText: controller.userNameError.value,
                  textHint: 'Nhập email của bạn',
                  textColor: Colors.purple,
                  onChange: (value) {
                    controller.validateUserName(value);
                    controller.login();
                  },
                ),
              ),
              Obx(
                () => MyTextField(
                  errorText: controller.passWordError.value,
                  onChange: (value) {
                    controller.validatePassWord(value);
                    controller.login();
                  },
                  textHint: 'Nhập mật khẩu',
                  hasPass: true,
                  textColor: Colors.purple,
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (controller.checkLogin.value) {
                    //showDialog(context: context, builder: builder)
                    controller.signInAcc(controller.userName.value ?? '',
                        controller.passWord.value ?? '');
                    if (controller.checkAccount.value ==
                        CHECK_ACCOUNT.Success) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeScreen()),
                      );
                    }
                  }
                },
                child: Obx(
                  () => Container(
                      margin: const EdgeInsets.only(top: 30, bottom: 15),
                      height: 60,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: controller.checkLogin.value
                              ? Colors.purple
                              : null,
                          border: Border.all(
                              width: 1,
                              color: const Color.fromARGB(255, 104, 104, 104)),
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                        child: MyText(
                            text: 'Login',
                            color: controller.checkLogin.value
                                ? Colors.white
                                : Colors.grey,
                            fontSize: 20),
                      )),
                ),
              ),
              _showErrorLogin(),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(RESIGER_SCREEN);
                  //     Get.toNamed(RESIGER_SCREEN);
                },
                child: const Center(
                  child: Text.rich(TextSpan(
                      text: 'Bạn chưa có tài khoản? ',
                      style: TextStyle(
                          fontSize: 17,
                          color: Color.fromARGB(255, 104, 104, 104)),
                      children: [
                        TextSpan(
                            text: 'Đăng kí',
                            style: TextStyle(
                                fontSize: 17,
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.purple,
                                color: Colors.purple))
                      ])),
                ),
              ),
              SizedBox(
                height: x > 500 ? 80 : 40,
              )
            ],
          ),
        ),
      ),
    );
  }

  Obx _showErrorLogin() {
    return Obx(() {
      if (controller.showErrorSignIn.value != null) {
        return Container(
          alignment: Alignment.centerLeft,
          child: MyText(
            text: controller.showErrorSignIn.value ?? '',
            color: Colors.red,
          ),
        );
      } else {
        return Container();
      }
    });
  }
}
