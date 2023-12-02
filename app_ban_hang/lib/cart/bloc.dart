import 'dart:async';

import 'package:app_ban_hang/data/model.dart';

class BlocCart {
  final StreamController<int> _priceController = StreamController.broadcast();
  Stream<int> get stremPrice => _priceController.stream;

  final StreamController<List<ProductModel>> _listProductController =
      StreamController.broadcast();
  Stream<List<ProductModel>> get stremListProd => _listProductController.stream;
  List<ProductModel> productS = [];
  int price = 0;
  void initData(List<ProductModel> data) {
    productS = data;
    _listProductController.sink.add(productS);
  }

  void removProduct(int index) {
    productS.removeAt(index);
    _listProductController.sink.add(productS);
  }

  void dispose() {
    _listProductController.close();
    _priceController.close();
  }
}
