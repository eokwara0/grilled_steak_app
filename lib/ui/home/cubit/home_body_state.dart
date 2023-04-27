import 'package:equatable/equatable.dart';
import 'package:menu_repository/menu_repository.dart';

abstract class HomeBodyState extends Equatable {
  const HomeBodyState({
    required List<MenuItem> items,
  }) : _items = items;

  // list of menu items
  final List<MenuItem> _items;

  // getting menu items
  List<MenuItem> get item => _items;

  bool get isInitial => this is HomeBodyInitial;
  bool get isLoaded => this is HomeBodyLoaded;
  bool get isError => this is HomeBodyLoaded;

  @override
  List<Object> get props => [_items];
}

class HomeBodyInitial extends HomeBodyState {
  const HomeBodyInitial({
    required super.items,
  });
}

class HomeBodyLoaded extends HomeBodyState {
  const HomeBodyLoaded({required super.items});
}

class HomeBodyError extends HomeBodyState {
  const HomeBodyError({required super.items});
}
