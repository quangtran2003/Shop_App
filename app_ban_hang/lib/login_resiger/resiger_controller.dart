import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ResigerController extends GetxController {
  final passWordError = RxnString();
  final passWord = RxnString();
  final comfrimPassWValue = RxnString();
  final checkConfrimSuccessPass = false.obs;
  final checkSuccessPassW = false.obs;
  final checkResiger = false.obs;
  final confrimPassWordError = RxnString();
  final checkEmail = false.obs;
  final email = RxnString();
  //final passWord = RxnString();
  final emailError = RxnString();

  //final dataUser = Rxn<User>();

  void createAcc(String email, String pass) async {
// Ví dụ
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: pass,
      );
      // ignore: empty_catches
    } catch (e) {}
  }

  void comfrimPass() {
    if (passWord.value != comfrimPassWValue.value) {
      confrimPassWordError.value = 'Confirm password is incorrect!';
      checkConfrimSuccessPass.value = false;
    } else {
      confrimPassWordError.value = null;
      checkConfrimSuccessPass.value = true;
    }
  }

  void validateEmail(value) {
    email.value = value;
    RegExp emailRegex = RegExp(
      r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$',
    );
    if (emailRegex.hasMatch(value)) {
      emailError.value = null;
      checkEmail.value = true;
    } else {
      checkEmail.value = false;
      emailError.value = 'Invalid email!';
    }
  }

  void validatePassWord(String value) {
    if (value.isEmpty) {
      passWordError.value = null;
      checkSuccessPassW.value = false;
    } else if (value.length >= 6) {
      passWordError.value = null;
      checkSuccessPassW.value = true;
    } else {
      passWordError.value = 'Minimum length 6 characters!';
      checkSuccessPassW.value = false;
    }
    passWord.value = value;
    comfrimPass();
  }

  void validateConfrimPassWord(String value) {
    comfrimPassWValue.value = value;
    comfrimPass();
  }

  void resiger() {
    if (checkConfrimSuccessPass.value &&
        checkSuccessPassW.value &&
        checkEmail.value) {
      checkResiger.value = true;
    } else {
      checkResiger.value = false;
    }
  }
}
