import 'package:equatable/equatable.dart';

import 'order_customer_model.dart';
import 'order_item_model.dart';

enum OrderStatus {
  PREPARING,
  FINISHED,
  CLOSED,
}

enum OrderType {
  EATIN,
  TAKEOUT,
}

class Order extends Equatable {
  final String id;
  final String userId;
  final String type;
  final String status;
  final double grandTotal;
  final List<OrderItem> items;
  final OrderCustomer customer;
  final DateTime? createdAt;

  Order({
    required this.id,
    required this.userId,
    required this.type,
    required this.status,
    required this.grandTotal,
    required this.items,
    required this.customer,
    this.createdAt,
  });

  @override
  List<Object?> get props => [
        id,
        userId,
        type,
        status,
        grandTotal,
        items,
        customer,
        createdAt,
      ];

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'type': type,
      'status': status,
      'grandTotal': grandTotal,
      'items': items.map((e) => e.toJson()).toList(),
      'customer': customer.toJson(),
    };
  }

  factory Order.fromJson(Map<String, dynamic> json) {
    print(json['grandTotal']);
    return Order(
      id: json['_id'] as String,
      userId: json['userId'] as String,
      type: json['type'] as String,
      status: json['status'] as String,
      grandTotal: double.parse('${json['grandTotal']}'),
      items: (json['items'] as List<dynamic>)
          .map((e) => OrderItem.fromJson(e))
          .toList(),
      customer: OrderCustomer.fromJson(json['customer']),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  Order copyWith({
    String? id,
    String? userId,
    String? type,
    String? status,
    double? grandTotal,
    List<OrderItem>? items,
    OrderCustomer? customer,
  }) {
    return Order(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      type: type ?? this.type,
      status: status ?? this.status,
      grandTotal: grandTotal ?? this.grandTotal,
      items: items ?? this.items,
      customer: customer ?? this.customer,
      createdAt: this.createdAt,
    );
  }
}
