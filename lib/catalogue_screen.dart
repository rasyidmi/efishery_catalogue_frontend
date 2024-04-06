import 'package:efishery_catalogue_frontend/widgets/product_card.dart';
import 'package:efishery_catalogue_frontend/order_confirmation_screen.dart';
import 'package:efishery_catalogue_frontend/widgets/warning_banner.dart';
import 'package:flutter/material.dart';

class CatalogueScreen extends StatefulWidget {
  const CatalogueScreen({super.key});

  @override
  State<CatalogueScreen> createState() => _CatalogueScreenState();
}

class _CatalogueScreenState extends State<CatalogueScreen> {
  List<dynamic> items = [
    {
      "name": "Fish",
      "description": "Min. & maks. pemesanan 2- 10 kg",
      "price": 20000,
      "orderQuantity": 0,
      "available": true,
    },
    {
      "name": "Shark",
      "description": "Min. & maks. pemesanan 2- 10 kg",
      "price": 40000,
      "orderQuantity": 0,
      "available": true,
    },
    {
      "name": "Whale",
      "description": "Min. & maks. pemesanan 2- 10 kg",
      "price": 100000,
      "orderQuantity": 0,
      "available": false,
    },
    {
      "name": "Catfish",
      "description": "Min. & maks. pemesanan 2- 10 kg",
      "price": 5000,
      "orderQuantity": 0,
      "available": true,
    }
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Katalog eFishery Fresh",
        ),
        foregroundColor: Colors.black,
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            WarningBanner(
              child: RichText(
                text: const TextSpan(
                  text: "Berikut adalah pilihan yang tersedia untuk: ",
                  style: TextStyle(fontSize: 10),
                  children: [
                    TextSpan(
                      text: "Kota Bandung",
                      style:
                          TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "Selesaikan pesanan Anda sebelum: 00:50:29",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              itemCount: items.length,
              itemBuilder: (context, index) {
                return ProductCard(
                  name: items[index]["name"],
                  description: items[index]["description"],
                  price: items[index]["price"],
                  orderQuantity: items[index]["orderQuantity"],
                  isStockAvailable: items[index]["available"],
                  onTapPlus: () {
                    setState(() {
                      items[index]["orderQuantity"] += 1;
                    });
                  },
                  onTapMinus: () {
                    setState(() {
                      items[index]["orderQuantity"] -= 1;
                    });
                  },
                );
              },
            ),
            const Spacer(),
            const Row(
              children: [
                Text("Pesanan dalam Keranjang:"),
                Spacer(),
                Text(
                  "8 Barang",
                  style: TextStyle(fontWeight: FontWeight.w700),
                )
              ],
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const OrderConfirmationScreen(),
                ));
              },
              style: Theme.of(context).textButtonTheme.style!,
              child: const Text(
                "Cek Keranjang",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
