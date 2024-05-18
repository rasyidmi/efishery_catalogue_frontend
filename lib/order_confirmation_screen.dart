import 'package:efishery_catalogue_frontend/helper/currency_formatter.dart';
import 'package:efishery_catalogue_frontend/order_success_screen.dart';
import 'package:efishery_catalogue_frontend/providers/product_provider.dart';
import 'package:efishery_catalogue_frontend/widgets/product_card.dart';
import 'package:efishery_catalogue_frontend/widgets/warning_banner.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderConfirmationScreen extends StatelessWidget {
  final String sender;
  const OrderConfirmationScreen({
    super.key,
    required this.sender,
  });

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

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
              itemCount: productProvider.orderProductList.length,
              itemBuilder: (context, index) {
                return ProductCard(
                  name: productProvider.orderProductList[index].name,
                  price: productProvider.orderProductList[index].price,
                  orderQuantity:
                      productProvider.orderProductList[index].orderQuantity,
                  description:
                      productProvider.orderProductList[index].description,
                  isStockAvailable:
                      productProvider.orderProductList[index].isAvailable,
                  onTapMinus: () {
                    productProvider.reduceOrderQuantity(
                        productProvider.orderProductList[index].productId);
                  },
                  onTapPlus: () {
                    productProvider.addOrderQuantity(
                        productProvider.orderProductList[index].productId);
                  },
                );
              },
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: Colors.grey[350],
                  borderRadius: const BorderRadius.all(Radius.circular(8))),
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
                        Navigator.of(context).pop();
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
            Row(
              children: [
                const Text("Estimasi Total Harga Pesanan:"),
                const Spacer(),
                Text(
                  CurrencyFormatter.convertToIdr(productProvider.totalPrice, 0),
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
                            OrderSuccessScreen(sender: sender),
                      ));
                    }
                  : null,
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
