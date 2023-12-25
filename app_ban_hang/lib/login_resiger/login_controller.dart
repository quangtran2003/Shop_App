// ignore_for_file: constant_identifier_names, camel_case_types

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController extends GetxController {
  final userName = RxnString();
  final passWord = RxnString();

  final checkAccount = Rxn<CHECK_ACCOUNT>();
  final userNameError = RxnString();
  final passWordError = RxnString();
  final textFieldUserName = RxnString();
  final textFieldPassW = RxnString();
  final checkSuccessUserName = false.obs;
  final checkSuccessPass = false.obs;
  final checkLogin = false.obs;
  final showErrorSignIn = RxnString();

  void signInAcc(String email, String pass) {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: email,
      password: pass,
    )
        .then((UserCredential userCredential) {
      checkAccount.value = CHECK_ACCOUNT.Success;
    }).catchError((error) {
      if (error.code == 'invalid-email') {
        checkAccount.value = CHECK_ACCOUNT.NotFound;
        showErrorSignIn.value = 'Tài khoản không tồn tại !';
      } else {
        checkAccount.value = CHECK_ACCOUNT.AthorError;
        showErrorSignIn.value = 'Đăng nhập thất bại!';
      }
    });
  }

  GlobalKey<FormState> fromKey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  final scopes = [
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ];
  final _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  void validateUserName(value) {
    userName.value = value;
    RegExp emailRegex = RegExp(
      r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$',
    );
    if (emailRegex.hasMatch(value)) {
      userNameError.value = null;
      checkSuccessUserName.value = true;
    } else {
      checkSuccessUserName.value = false;
      userNameError.value = 'Email không hợp lệ!';
    }
  }

  void validatePassWord(value) {
    passWord.value = value;
    if (value.toString().length >= 6) {
      passWordError.value = null;
      checkSuccessPass.value = true;
    } else {
      passWordError.value = 'Mật khẩu tối thiểu 6 kí tự!';
      checkSuccessPass.value = false;
    }
  }

  void login() {
    checkLogin.value = checkSuccessPass.value && checkSuccessUserName.value;
  }
}

enum CHECK_ACCOUNT { AthorError, AlreadyExist, Success, NotFound }
