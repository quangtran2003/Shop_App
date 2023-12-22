import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class BlocAddress {
  final StreamController<String?> _errorAddressController =
      StreamController.broadcast();
  Stream<String?> get streamAddress => _errorAddressController.stream;
  final StreamController<String?> _errorNameController =
      StreamController.broadcast();
  Stream<String?> get streamName => _errorNameController.stream;
  final StreamController<String?> _errorPhoneController =
      StreamController.broadcast();
  Stream<String?> get streamPhone => _errorPhoneController.stream;
  final StreamController<bool> _checkAddressController =
      StreamController.broadcast();
  Stream<bool> get streamCheck => _checkAddressController.stream;

  final StreamController<String?> address = StreamController.broadcast();
  Stream<String?> get streamAdd => address.stream;
  final StreamController<String?> phone = StreamController.broadcast();
  Stream<String?> get streamPhonee => phone.stream;
  final StreamController<String?> name = StreamController.broadcast();
  Stream<String?> get streamNamee => name.stream;

  String? phoneEror;
  String? addressError;
  String? nameEror;
  String addressValue = '';
  String nameValue = '';
  String phoneValue = '';
  bool checkAddress = false;

  void getName() {
    name.sink.add(nameValue);
  }

  void getAddr() {
    address.sink.add(addressValue);
  }

  void getPhone() {
    phone.sink.add(phoneValue);
  }

  void isPhoneNumber(String input) {
    bool isAllDigits = input.runes.every((rune) => rune >= 48 && rune <= 57);
    bool isCorrectLength = input.length == 10;
    if (isAllDigits && isCorrectLength) {
      phoneEror = null;
      phoneValue = input;
    } else {
      phoneEror = "Số điện thoại không hợp lệ";
    }
    check();

    _errorPhoneController.sink.add(phoneEror);
  }

  void isAddress(String input) {
    if (input.length >= 15) {
      addressError = null;
      addressValue = input;
    } else {
      addressError = 'Địa chỉ không hợp lệ!';
    }
    check();

    _errorAddressController.sink.add(addressError);
  }

  void isName(String input) {
    check();
    if (input.isNotEmpty) {
      nameEror = null;
      nameValue = input;
    } else {
      nameEror = 'Tên người nhân không hợp lệ!';
    }
    check();

    _errorNameController.sink.add(nameEror);
  }

  void check() {
    if (phoneEror == null && addressError == null && nameEror == null) {
      checkAddress = true;
    } else {
      checkAddress = false;
    }
    if (nameValue != '' && addressValue != '' && phoneValue != '') {
      checkAddress = true;
    }
    _checkAddressController.sink.add(checkAddress);
  }

  Future<void> loadAddress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? add = prefs.getString('address');
    String? name = prefs.getString('name');

    String? phone = prefs.getString('phone');
    nameValue = name ?? '';
    addressValue = add ?? '';
    phoneValue = phone ?? '';

    getAddr();
    getName();
    getPhone();
  }

  Future<void> saveAddress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('address', addressValue);
    prefs.setString('name', nameValue);
    prefs.setString('phone', phoneValue);
  }

  void dispose() {
    phone.close();
    address.close();
    name.close();
    _checkAddressController.close();
    _errorAddressController.close();
    _errorNameController.close();
    _errorPhoneController.close();
  }
}
