import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

import 'package:efishery_catalogue_frontend/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/product.dart';

class OrderSuccessScreen extends StatelessWidget {
  final String sender;
  const OrderSuccessScreen({super.key, required this.sender});

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    return FutureBuilder(
      future: sendEvent(sender, productProvider.orderProductList),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Scaffold(
              body: Center(
            child: Text("Order gagal mohon coba beberapa saat lagi."),
          ));
        } else if (snapshot.connectionState == ConnectionState.done) {
          return const Scaffold(
              body: Center(
            child: Text("Order berhasil silahkan cek kembali Whatsapp Anda"),
          ));
        } else {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(color: Color(0xFF349f85)),
            ),
          );
        }
      },
    );
  }
}

Future<void> sendEvent(String sender, List<Product> productList) async {
  try {
    const urlPath =
        "https://cors-anywhere.herokuapp.com/https://r2.cloud.yellow.ai/integrations/sendevent/catalogue-order/x1699680803337?source=whatsapp";
    final productOrderList = [];
    for (var i = 0; i < productList.length; i++) {
      final converted = {
        "product_id": productList[i].productId,
        "quantity": productList[i].orderQuantity,
      };
      productOrderList.add(converted);
    }
    final body = {
      "sender": sender,
      "data": productOrderList,
    };
    final convertedBody = json.encoder.convert(body);
    await http.post(
      Uri.parse(urlPath),
      headers: {
        "authorization": "a9c9844ad495b7acbba6948ad670",
        "Content-Type": "application/json",
      },
      body: convertedBody,
    );
  } catch (e) {
    log(e.toString());
    throw Error();
  }
}
