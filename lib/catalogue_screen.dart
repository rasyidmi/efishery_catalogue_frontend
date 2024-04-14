import 'package:efishery_catalogue_frontend/providers/product_provider.dart';
import 'package:efishery_catalogue_frontend/widgets/product_card.dart';
import 'package:efishery_catalogue_frontend/order_confirmation_screen.dart';
import 'package:efishery_catalogue_frontend/widgets/warning_banner.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CatalogueScreen extends StatefulWidget {
  const CatalogueScreen({super.key});

  @override
  State<CatalogueScreen> createState() => _CatalogueScreenState();
}

class _CatalogueScreenState extends State<CatalogueScreen> {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

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
              itemCount: productProvider.productList.length,
              itemBuilder: (context, index) {
                return ProductCard(
                  name: productProvider.productList[index].name,
                  description: productProvider.productList[index].description,
                  price: productProvider.productList[index].price,
                  orderQuantity:
                      productProvider.productList[index].orderQuantity,
                  isStockAvailable:
                      productProvider.productList[index].isAvailable,
                  onTapPlus: () {
                    productProvider.addOrderQuantity(
                        productProvider.productList[index].productId);
                  },
                  onTapMinus: () {
                    productProvider.reduceOrderQuantity(
                        productProvider.productList[index].productId);
                  },
                );
              },
            ),
            const Spacer(),
            Row(
              children: [
                const Text("Pesanan dalam Keranjang:"),
                const Spacer(),
                Text(
                  "${productProvider.cartQuantity} Barang",
                  style: const TextStyle(fontWeight: FontWeight.w700),
                )
              ],
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: productProvider.cartQuantity > 0
                  ? () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const OrderConfirmationScreen(),
                      ));
                    }
                  : null,
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
