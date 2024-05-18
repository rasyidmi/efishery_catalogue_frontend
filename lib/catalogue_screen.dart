import 'package:efishery_catalogue_frontend/providers/product_provider.dart';
import 'package:efishery_catalogue_frontend/widgets/product_card.dart';
import 'package:efishery_catalogue_frontend/order_confirmation_screen.dart';
import 'package:efishery_catalogue_frontend/widgets/warning_banner.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CatalogueScreen extends StatelessWidget {
  final String cityName;
  final String bucketTag;
  final String sender;
  const CatalogueScreen({
    super.key,
    required this.cityName,
    required this.bucketTag,
    required this.sender,
  });

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    return FutureBuilder(
      future: productProvider.initiateProductList(cityName, bucketTag),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (productProvider.productList.isEmpty) {
            return const Scaffold(
              body: Center(
                child: Text("Maaf produk untuk area ini kosong."),
              ),
            );
          }
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
                      text: TextSpan(
                        text: "Berikut adalah pilihan yang tersedia untuk: ",
                        style: const TextStyle(fontSize: 10),
                        children: [
                          TextSpan(
                            text: cityName,
                            style: const TextStyle(
                                fontSize: 10, fontWeight: FontWeight.bold),
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
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: productProvider.productList.length,
                      itemBuilder: (context, index) {
                        return ProductCard(
                          name: productProvider.productList[index].name,
                          description:
                              productProvider.productList[index].description,
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
                  ),
                  const SizedBox(height: 8),
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
                              builder: (context) =>
                                  OrderConfirmationScreen(sender: sender),
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
        } else if (snapshot.hasError) {
          return const Scaffold(
            body: Center(child: Text("Sedang ada perbaikan di sistem kami.")),
          );
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
