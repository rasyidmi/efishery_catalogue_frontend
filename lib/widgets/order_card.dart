import 'package:flutter/material.dart';

class OrderCard extends StatelessWidget {
  final String name;
  final int price;
  final int orderQuantity;
  const OrderCard({
    super.key,
    required this.name,
    required this.price,
    required this.orderQuantity,
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
              const Text("Min. & maks. pemesanan 2- 10 kg"),
              Text("IDR $price"),
            ],
          ),
        ],
      ),
    );
  }
}
