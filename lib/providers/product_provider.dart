import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

import 'package:efishery_catalogue_frontend/models/product.dart';
import 'package:flutter/material.dart';

class ProductProvider extends ChangeNotifier {
  List<Product> _productList = [];

  Future<List<Product>> initiateProductList(
      String cityName, String bucketTag) async {
    try {
      if (_productList.isNotEmpty) {
        return _productList;
      }
      const urlPath =
          "https://r2.cloud.yellow.ai/api/ai/botdata/table/659fb01869e7ce2b4b0a1397/search?bot=x1699680803337";
      final body = {
        "query": {
          "filter": {
            "type": "AND",
            "fields": [
              {"type": "SELECTOR", "column": "s1", "value": cityName},
              {"type": "SELECTOR", "column": "s2", "value": bucketTag}
            ]
          }
        }
      };
      final convertedBody = json.encoder.convert(body);
      final response = await http.post(
        Uri.parse(urlPath),
        headers: {
          "x-api-key": "bQ9UuCBQJciSIeYKIhl5iwht7SyvzpolxAqFhe0h",
          "Content-Type": "application/json",
          "Access-Control-Allow-Headers": "*",
          "Access-Control-Allow-Origin": "*",
        },
        body: convertedBody,
      );
      final responseBody = json.decode(response.body);
      if (responseBody["data"].length == 0) {
        log("masuk");
        return [];
      }
      final data = responseBody["data"][0]["j1"];
      final productIdList = json.decode(data);
      _productList = await _getProductList(productIdList);
      return _productList;
    } catch (e) {
      log(e.toString());
      throw Error();
    }
  }

  Future<List<Product>> _getProductList(List<dynamic> ids) async {
    try {
      const urlPath =
          "https://cors-anywhere.herokuapp.com/https://r2.cloud.yellow.ai/api/ai/botdata/table/656719d718b7863e56b680bf/search?bot=x1699680803337";
      final fields = [];
      for (var i = 0; i < ids.length; i++) {
        final query = {"type": "SELECTOR", "column": "si3", "value": ids[i]};
        fields.add(query);
      }
      final body = {
        "query": {
          "filter": {"type": "OR", "fields": fields}
        }
      };
      final convertedBody = json.encoder.convert(body);
      final response = await http.post(
        Uri.parse(urlPath),
        headers: {
          "x-api-key": "bQ9UuCBQJciSIeYKIhl5iwht7SyvzpolxAqFhe0h",
          "Content-Type": "application/json",
        },
        body: convertedBody,
      );
      final responseBody = json.decode(response.body);
      final data = responseBody["data"] as List<dynamic>;
      log("Product list: $data");
      List<Product> productList = [];
      for (var i = 0; i < data.length; i++) {
        final product = Product.fromJson(data[i]);
        productList.add(product);
      }
      return productList;
    } catch (e) {
      log(e.toString());
      throw Error();
    }
  }

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
