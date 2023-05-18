class OrderItem {
  final String menuId;
  final int quantity;
  final double price;

  const OrderItem({
    required this.menuId,
    required this.quantity,
    required this.price,
  });

  Map<String, dynamic> toJson() {
    return {
      'menuId': menuId,
      'quantity': quantity,
      'price': price,
    };
  }

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      menuId: json['menuId'],
      quantity: json['quantity'],
      price: double.parse('${json['price']}'),
    );
  }

  OrderItem copyWith({
    String? menuId,
    int? quantity,
    double? price,
  }) {
    return OrderItem(
      menuId: menuId ?? this.menuId,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
    );
  }
}
