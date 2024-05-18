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

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        productId: json["si3"],
        name: json["s4"],
        description: json["s5"],
        isAvailable: true,
        orderQuantity: 0,
        price: int.parse(json["s3"].replaceAll(",", "")),
      );
}
