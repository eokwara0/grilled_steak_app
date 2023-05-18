part of 'chef_home_page_cubit.dart';

abstract class ChefHomePageState extends Equatable {
  const ChefHomePageState({
    required List<Order> orders,
    required List<List<MenuItem>> menuOrderItems,
  })  : _orders = orders,
        _menuOrderItems = menuOrderItems;

  final List<Order> _orders;
  final List<List<MenuItem>> _menuOrderItems;

  List<Order> get orders => _orders;
  List<List<MenuItem>> get menuOrderItems => _menuOrderItems;

  bool get isLoaded => this is ChefHomePageLoaded;
  bool get isError => this is ChefHomePageError;
  bool get isInitial => this is ChefHomePageInitial;
  bool get isReady => this is ChefHomePageReadyOrder;
  bool get isCancel => this is ChefHomePageCancelOrder;
  @override
  List<Object> get props => [_orders, _menuOrderItems];
}

class ChefHomePageInitial extends ChefHomePageState {
  const ChefHomePageInitial({
    required super.orders,
    required super.menuOrderItems,
  });
}

class ChefHomePageLoaded extends ChefHomePageState {
  const ChefHomePageLoaded({
    required super.orders,
    required super.menuOrderItems,
  });
}

class ChefHomePageReadyOrder extends ChefHomePageState {
  const ChefHomePageReadyOrder({
    required super.orders,
    required super.menuOrderItems,
  });
}

class ChefHomePageCancelOrder extends ChefHomePageState {
  const ChefHomePageCancelOrder({
    required super.orders,
    required super.menuOrderItems,
  });
}

class ChefHomePageError extends ChefHomePageState {
  const ChefHomePageError({
    required super.orders,
    required super.menuOrderItems,
  });
}
