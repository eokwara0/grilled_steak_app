class OrderCustomer implements Customer {
  String name;
  String email;

  OrderCustomer({
    required this.name,
    required this.email,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
    };
  }

  factory OrderCustomer.fromJson(Map<String, dynamic> json) {
    return OrderCustomer(
      name: json['name'] as String,
      email: json['email'] as String,
    );
  }

  OrderCustomer copyWith({
    String? name,
    String? email,
  }) {
    return OrderCustomer(
      name: name ?? this.name,
      email: email ?? this.email,
    );
  }
}

// Declare the Customer interface
abstract class Customer {
  String get name;
  String get email;
}
