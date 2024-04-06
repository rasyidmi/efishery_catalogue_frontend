import 'package:efishery_catalogue_frontend/order_success_screen.dart';
import 'package:efishery_catalogue_frontend/widgets/product_card.dart';
import 'package:efishery_catalogue_frontend/widgets/warning_banner.dart';
import 'package:flutter/material.dart';

class OrderConfirmationScreen extends StatefulWidget {
  const OrderConfirmationScreen({super.key});

  @override
  State<OrderConfirmationScreen> createState() =>
      _OrderConfirmationScreenState();
}

class _OrderConfirmationScreenState extends State<OrderConfirmationScreen> {
  List<dynamic> orderProducts = [
    {
      "name": "Fish",
      "price": 40000,
      "orderQuantity": 2,
      "description": "Min. & maks. pemesanan 2- 10 kg",
    },
    {
      "name": "Shark",
      "price": 300000,
      "orderQuantity": 3,
      "description": "Min. & maks. pemesanan 2- 10 kg",
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Pesanan Anda",
        ),
        foregroundColor: Colors.black,
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const WarningBanner(
              child: Text(
                "Jika pesanannya sudah sesuai, tekan \"Lanjut Pemesanan\" untuk kembali ke Whatsapp dan selesaikan prosesnya.",
                style: TextStyle(fontSize: 10),
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
              itemCount: orderProducts.length,
              itemBuilder: (context, index) {
                return ProductCard(
                  name: orderProducts[index]["name"],
                  price: orderProducts[index]["price"],
                  orderQuantity: orderProducts[index]["orderQuantity"],
                  description: orderProducts[index]["description"],
                  isStockAvailable: true,
                  onTapMinus: () {},
                  onTapPlus: () {},
                );
              },
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: Colors.grey[350],
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              child: Row(
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Tambah Barang Lainnya?",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Cek lagi siapa tahu ada yang terlewat",
                        style: TextStyle(fontSize: 10),
                      )
                    ],
                  ),
                  const Spacer(),
                  Flexible(
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const OrderSuccessScreen(),
                        ));
                      },
                      style: Theme.of(context).textButtonTheme.style!,
                      child: const Text(
                        "Tambah",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            const Row(
              children: [
                Text("Estimasi Total Harga Pesanan:"),
                Spacer(),
                Text(
                  "Rp280.000",
                  style: TextStyle(fontWeight: FontWeight.w700),
                )
              ],
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const OrderSuccessScreen(),
                ));
              },
              style: Theme.of(context).textButtonTheme.style!,
              child: const Text(
                "Lanjut Pemesanan",
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
