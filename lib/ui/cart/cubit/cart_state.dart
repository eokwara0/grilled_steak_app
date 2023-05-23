part of 'cart_cubit.dart';

abstract class CartState extends Equatable {
  const CartState({
    required List<OrderItem> orderItems,
    required List<MenuItem> menuItems,
    Email? email,
    Username? username,
  })  : _orderItems = orderItems,
        _email = email,
        _username = username,
        _menuItems = menuItems,
        _length = orderItems.length;

  final List<OrderItem> _orderItems;
  final int _length;
  final List<MenuItem> _menuItems;
  final Email? _email;
  final Username? _username;

  //Getters
  Email? get email => _email;
  Username? get username => _username;
  List<OrderItem> get orderItems => _orderItems;
  List<MenuItem> get menuItems => _menuItems;
  int get length => _length;
  double get grandTotal => _orderItems.isNotEmpty
      ? _orderItems.map((e) => e.quantity * e.price).toList().reduce(
            (value, element) => value + element,
          )
      : 0.0;

  // Checks
  bool get isChanged => this is CartChanged;
  bool get isCheckedOut => this is CartCheckedOut;
  bool get isError => this is CartError;
  bool get isAdded => this is CartItemAdded;
  bool get isLoaded => this is CartMenuItemLoaded;

  @override
  List<Object?> get props => [
        _orderItems,
        _length,
        grandTotal,
        _email,
        _username,
      ];
}

class CartInitial extends CartState {
  const CartInitial({
    required super.orderItems,
    required super.menuItems,
    super.email,
    super.username,
  });
}

class CartChanged extends CartState {
  const CartChanged({
    required super.orderItems,
    required super.menuItems,
    super.email,
    super.username,
  });
}

class CartMenuItemLoaded extends CartState {
  const CartMenuItemLoaded({
    required super.orderItems,
    required super.menuItems,
    super.email,
    super.username,
  });
}

class CartItemAdded extends CartState {
  const CartItemAdded({
    required super.orderItems,
    required super.menuItems,
    super.email,
    super.username,
  });
}

class CartCheckedOut extends CartState {
  const CartCheckedOut({
    required super.orderItems,
    required super.menuItems,
    super.email,
    super.username,
  });
}

class CartError extends CartState {
  const CartError({
    required super.orderItems,
    required super.menuItems,
    super.email,
    super.username,
  });
}
