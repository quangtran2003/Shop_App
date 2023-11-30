import 'dart:async';

import 'package:app_ban_hang/component/const.dart';
import 'package:app_ban_hang/data/model.dart';

class BlocHome {
  final StreamController<List<ProductModel>> _cartController =
      StreamController.broadcast();
  Stream<List<ProductModel>> get streamCart => _cartController.stream;
  final StreamController<int> _countListProductController =
      StreamController.broadcast();
  Stream<int> get stremCountList => _countListProductController.stream;
  final StreamController<bool> _dippingSauceController =
      StreamController.broadcast();
  Stream<bool> get streamDippingSauce => _dippingSauceController.stream;
  final StreamController<bool> _soupController = StreamController.broadcast();
  Stream<bool> get streamSoup => _soupController.stream;
  final StreamController<bool> _cucumberSaladController =
      StreamController.broadcast();
  Stream<bool> get streamCucumberSalad => _cucumberSaladController.stream;
  final StreamController<int> _countProductController =
      StreamController.broadcast();
  Stream<int> get stremCountProduct => _countProductController.stream;
  final StreamController<int> _countProductCartController =
      StreamController.broadcast();
  Stream<int> get stremCountCartProduct => _countProductCartController.stream;
  final StreamController<int> _priceController = StreamController.broadcast();
  Stream<int> get stremPrice => _priceController.stream;
  final StreamController<bool> _sideDishesController =
      StreamController.broadcast();
  Stream<bool> get stremsideDishes => _sideDishesController.stream;
  final StreamController<TRANSPORT> _transportController =
      StreamController.broadcast();
  Stream<TRANSPORT> get streamTransport => _transportController.stream;

  final StreamController<bool> _flowerController = StreamController.broadcast();
  Stream<bool> get stremFlower => _flowerController.stream;
  final StreamController<bool> _bagController = StreamController.broadcast();
  Stream<bool> get streamBag => _bagController.stream;

  bool dippingSauce = false;
  bool soup = false;
  bool cucumberSalad = false;
  final List<ProductModel> cart = [];
  List<String?> listId = [];
  int countProduct = 1;
  List<int> listNumber = [];
  int price = 0;
  bool sideDishes = false;
  TRANSPORT transport = TRANSPORT.DEAFULT;
  bool hasFlower = false;
  bool hasBag = false;

  void checkFlower() {
    hasFlower = !hasFlower;
    _flowerController.sink.add(hasFlower);
  }

  void checkBag() {
    hasBag = !hasBag;
    _bagController.sink.add(hasBag);
  }

  void checkTranport() {
    if (transport == TRANSPORT.NORMAL) {
      transport = TRANSPORT.FASST;
    } else {
      transport = TRANSPORT.NORMAL;
    }
    _transportController.sink.add(transport);
  }

  void hasSideDishes() {
    sideDishes = (cucumberSalad || soup || dippingSauce);
    if (cucumberSalad || soup || dippingSauce) {
      sideDishes = true;
    } else {
      sideDishes = false;
    }
    _sideDishesController.sink.add(sideDishes);
  }

  void pay() {
    price = 0;
    for (var element in cart) {
      price += (element.number ?? 0) * (element.price ?? 0);
    }
    if (dippingSauce) {
      price = price + 20000;
    }
    if (soup) {
      price = price + 10000;
    }
    if (cucumberSalad) {
      price = price + 20000;
    }
    _priceController.sink.add(price);
  }

  void initData() {
    listNumber.clear();
    for (var element in cart) {
      listNumber.add(element.number ?? 1);
    }
  }

  void updateNumber(int index, int value) {
    cart[index].number = value;
    _cartController.sink.add(cart);
  }

  void addCart(ProductModel product, int count) {
    int index = listId.indexOf(product.id);

    if (listId.contains(product.id)) {
      cart[index].number = (cart[index].number ?? 0) + count;
    } else {
      product.number = count;
      cart.add(product);
      listId.add(product.id);
    }
    _cartController.sink.add(cart);
  }

  void countCart() {
    _countListProductController.sink.add(cart.length);
  }

  void checkDippingSauce() {
    dippingSauce = !dippingSauce;
    _dippingSauceController.sink.add(dippingSauce);
  }

  void checkSoup() {
    soup = !soup;
    _soupController.sink.add(soup);
  }

  void checkCucumberSalad() {
    cucumberSalad = !cucumberSalad;
    _cucumberSaladController.sink.add(cucumberSalad);
  }

  void countAdd(int value) {
    value = value + 1;
    _countProductController.sink.add(value);
  }

  void countRemove(int value) {
    if (countProduct <= 1) return;
    value = (value) - 1;

    _countProductController.sink.add(value);
  }

  void countAddHome(ProductModel? product) {
    countProduct = countProduct + 1;
    _countProductCartController.sink.add(countProduct);
  }

  void countRemoveHome(ProductModel? product) {
    if (countProduct <= 1) return;
    countProduct = (countProduct) - 1;

    _countProductCartController.sink.add(countProduct);
  }

  void removeCart(int index) {
    cart.removeAt(index);
    listId.removeAt(index);
    listNumber.removeAt(index);
    _cartController.sink.add(cart);
    countCart();
  }

  void dispose() {
    _cartController.close();
    _countListProductController.close();
    _cucumberSaladController.close();
    _dippingSauceController.close();
    _soupController.close();
    _countProductController.close();
    _countProductCartController.close();
    _sideDishesController.close();
    _transportController.close();
    _priceController.close();
  }
}
//enum TRANSPORT{FASST,NORMAL }
