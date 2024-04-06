import 'package:efishery_catalogue_frontend/helper/currency_formatter.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String name;
  final int price;
  final int orderQuantity;
  final String description;
  final VoidCallback onTapPlus;
  final VoidCallback onTapMinus;
  final bool isStockAvailable;
  const ProductCard({
    super.key,
    required this.name,
    required this.price,
    required this.orderQuantity,
    required this.onTapPlus,
    required this.onTapMinus,
    required this.isStockAvailable,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        boxShadow: [
          BoxShadow(
              offset: const Offset(0, 1),
              blurRadius: 4,
              color: Colors.black.withOpacity(0.12))
        ],
      ),
      child: Row(
        children: [
          Image.network(
            'https://st.depositphotos.com/1521357/2978/i/950/depositphotos_29787629-stock-photo-fish.jpg',
            height: 100,
            width: 100,
          ),
          const SizedBox(width: 4),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 8),
                Text(description),
                const SizedBox(height: 8),
                Text(
                  CurrencyFormatter.convertToIdr(price, 0),
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
          !isStockAvailable ? const SizedBox(width: 8) : const SizedBox(),
          !isStockAvailable
              ? const Text(
                  "Stok Kosong",
                  style: TextStyle(
                      color: Colors.yellow, fontWeight: FontWeight.bold),
                )
              : const SizedBox(),
          isStockAvailable
              ? IconButton(
                  onPressed: onTapMinus, icon: const Icon(Icons.remove_circle))
              : const SizedBox(),
          isStockAvailable ? Text("$orderQuantity") : const SizedBox(),
          isStockAvailable
              ? IconButton(
                  onPressed: onTapPlus, icon: const Icon(Icons.add_circle))
              : const SizedBox(),
        ],
      ),
    );
  }
}
