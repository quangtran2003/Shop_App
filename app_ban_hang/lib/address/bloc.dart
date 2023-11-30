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
  String? phone = '';
  String? address = '';
  String? name = '';
  bool checkAddress = false;

  void isPhoneNumber(String input) {
    bool isAllDigits = input.runes.every((rune) => rune >= 48 && rune <= 57);
    bool isCorrectLength = input.length == 10;
    if (isAllDigits && isCorrectLength) {
      phone = null;
    } else {
      phone = "Số điện thoại không hợp lệ";
    }
    check();

    _errorPhoneController.sink.add(phone);
  }

  void isAddress(String input) {
    if (input.length >= 15) {
      address = null;
    } else {
      address = 'Địa chỉ không hợp lệ!';
    }
    check();

    _errorAddressController.sink.add(address);
  }

  void isName(String input) {
    check();
    if (input.isNotEmpty) {
      name = null;
    } else {
      name = 'Tên người nhân không hợp lệ!';
    }
    check();

    _errorNameController.sink.add(name);
  }

  void check() {
    //   print('phone: $phone    add: $address   name: $name');

    if (phone == null && address == null && name == null) {
      checkAddress = true;
    } else {
      checkAddress = false;
    }
    _checkAddressController.sink.add(checkAddress);
  }
}
