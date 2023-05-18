part of 'order_cubit.dart';

abstract class OrderState extends Equatable {
  const OrderState({
    required List<Order> orders,
    required List<List<MenuItem>> menuOrderItems,
  })  : _orders = orders,
        _menuOrderItems = menuOrderItems;

  final List<Order> _orders;
  final List<List<MenuItem>> _menuOrderItems;

  List<Order> get orders => _orders;
  List<List<MenuItem>> get menuOrderItems => _menuOrderItems;

  bool get isLoaded => this is OrderLoaded;
  bool get isError => this is OrderError;
  bool get isOrdered => this is OrderAgain;
  bool get isInitial => this is OrderInitial;
  bool get isCancel => this is OrderCancel;
  bool get isClosed => this is OrderClosed;

  @override
  List<Object> get props => [
        _orders,
        _menuOrderItems,
        _orders.length,
      ];
}

class OrderInitial extends OrderState {
  const OrderInitial({
    required super.orders,
    required super.menuOrderItems,
  });
}

class OrderLoaded extends OrderState {
  const OrderLoaded({
    required super.orders,
    required super.menuOrderItems,
  });
}

class OrderCancel extends OrderState {
  const OrderCancel({
    required super.orders,
    required super.menuOrderItems,
  });
}

class OrderClosed extends OrderState {
  const OrderClosed({
    required super.orders,
    required super.menuOrderItems,
  });
}

class OrderAgain extends OrderState {
  const OrderAgain({
    required super.orders,
    required super.menuOrderItems,
  });
}

class OrderError extends OrderState {
  const OrderError({
    required super.orders,
    required super.menuOrderItems,
  });
}
