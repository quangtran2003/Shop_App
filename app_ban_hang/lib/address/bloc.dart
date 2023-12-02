import 'dart:async';

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
  String? phoneEror;
  String? addressError;
  String? nameEror;
  String addressValue = '';
  String nameValue = '';
  String phoneValue = '';
  bool checkAddress = false;

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
    //   print('phone: $phone    add: $address   name: $name');

    if (phoneEror == null && addressError == null && nameEror == null) {
      checkAddress = true;
    } else {
      checkAddress = false;
    }
    _checkAddressController.sink.add(checkAddress);
  }
}
