import 'package:equatable/equatable.dart';

class Bill extends Equatable {
  final String _id;

  final String _orderId;
  final String _userId;
  final double _grandTotal;

  const Bill({
    String? id,
    String? orderId,
    String? userId,
    double? grandTotal,
  })  : _id = id ?? '',
        _orderId = orderId ?? '',
        _userId = userId ?? '',
        _grandTotal = grandTotal ?? 0.0;

  String get id => _id;
  String get orderId => _orderId;
  String get userId => _userId;
  double get total => _grandTotal;

  @override
  List<Object?> get props => [
        _id,
        _userId,
        _orderId,
        _grandTotal,
      ];

  Bill copyWith(
      {String? id, String? userId, String? orderId, double? grandTotal}) {
    return Bill(
      id: id ?? _id,
      orderId: orderId ?? _orderId,
      userId: userId ?? _userId,
      grandTotal: grandTotal ?? _grandTotal,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': _userId,
      'orderId': _orderId,
      'grandTotal': _grandTotal,
    };
  }

  static Bill fromJson(Map<dynamic, dynamic> Json) {
    return Bill(
      id: Json['id'] as String,
      userId: Json['userId'] as String,
      orderId: Json['orderId'] as String,
      grandTotal: double.tryParse('${Json['grandTotal']}'),
    );
  }
}
