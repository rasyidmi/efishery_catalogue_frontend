import 'package:efishery_catalogue_frontend/models/product.dart';
import 'package:flutter/material.dart';

class ProductProvider extends ChangeNotifier {
  List<Product> _productList = [
    Product(
      productId: "1",
      name: "Ikan Lele",
      description: "Min. & maks. pemesanan 2- 10 kg",
      isAvailable: true,
      orderQuantity: 0,
      price: 20000,
    ),
    Product(
      productId: "2",
      name: "Ikan Gurame",
      description: "Min. & maks. pemesanan 2- 10 kg",
      isAvailable: true,
      orderQuantity: 0,
      price: 10000,
    ),
    Product(
      productId: "3",
      name: "Ikan Hiu",
      description: "Min. & maks. pemesanan 2- 10 kg",
      isAvailable: false,
      orderQuantity: 0,
      price: 150000,
    )
  ];

  List<Product> get productList => _productList;

  set productList(List<Product> newProductList) {
    _productList = newProductList;
    notifyListeners();
  }

  void addOrderQuantity(String id) {
    for (var i = 0; i < _productList.length; i++) {
      if (_productList[i].productId == id) {
        _productList[i].orderQuantity += 1;
        break;
      }
    }
    notifyListeners();
  }

  void reduceOrderQuantity(String id) {
    for (var i = 0; i < _productList.length; i++) {
      if (_productList[i].productId == id) {
        if (_productList[i].orderQuantity > 0) {
          _productList[i].orderQuantity -= 1;
        }
        break;
      }
    }
    notifyListeners();
  }

  int get cartQuantity {
    int total = 0;
    for (var i = 0; i < _productList.length; i++) {
      total = total + _productList[i].orderQuantity;
    }
    return total;
  }

  int get totalPrice {
    int price = 0;
    for (var i = 0; i < _productList.length; i++) {
      price = price + _productList[i].orderQuantity * _productList[i].price;
    }
    return price;
  }

  List<Product> get orderProductList {
    List<Product> orderProductList = [];
    for (var i = 0; i < _productList.length; i++) {
      if (_productList[i].orderQuantity > 0) {
        orderProductList.add(_productList[i]);
      }
    }
    return orderProductList;
  }
}
