import 'package:efishery_catalogue_frontend/catalogue_screen.dart';
import 'package:efishery_catalogue_frontend/theme/app_theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: appTheme,
      home: const CatalogueScreen(),
    );
  }
}
