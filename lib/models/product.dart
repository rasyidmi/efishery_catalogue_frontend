class Product {
  final String productId;
  final String name;
  final String description;
  final bool isAvailable;
  int orderQuantity;
  final int price;

  Product({
    required this.productId,
    required this.name,
    required this.description,
    required this.isAvailable,
    required this.orderQuantity,
    required this.price,
  });
}
