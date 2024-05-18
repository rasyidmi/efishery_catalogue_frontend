// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:developer';

import 'package:efishery_catalogue_frontend/catalogue_screen.dart';
import 'package:efishery_catalogue_frontend/providers/product_provider.dart';
import 'package:efishery_catalogue_frontend/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:html';

List<String?> getParams() {
  var uri = Uri.dataFromString(window.location.href);
  Map<String, String> params = uri.queryParameters;
  String? cityName = params["cityName"];
  String? bucketTag = params["bucketTag"];
  String? sender = params["sender"];
  log(cityName ?? "null");
  log(bucketTag ?? "null");
  log(sender ?? "null");
  return [cityName, bucketTag, sender];
}

void main() {
  List<String?> data = getParams();
  if (data[0] == null || data[1] == null || data[2] == null) {
    // runApp(const EmptyProductId());
    runApp(const EmptyProductId());
  } else {
    runApp(MyApp(
      cityName: data[0]!.replaceAll("%20", " "),
      bucketTag: data[1]!.replaceAll("%20", " "),
      sender: data[2]!.replaceAll("%20", " "),
    ));
  }
}

class MyApp extends StatelessWidget {
  final String cityName;
  final String bucketTag;
  final String sender;
  const MyApp({
    super.key,
    required this.cityName,
    required this.bucketTag,
    required this.sender,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProductProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: appTheme,
        home: CatalogueScreen(
          cityName: cityName,
          bucketTag: bucketTag,
          sender: sender,
        ),
      ),
    );
  }
}

class EmptyProductId extends StatelessWidget {
  const EmptyProductId({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: appTheme,
      home: const Scaffold(
        body: Center(
          child: Text("Produk tidak ditemukan."),
        ),
      ),
    );
  }
}
