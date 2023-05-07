part of 'menu_cubit.dart';

abstract class MenuState extends Equatable {
  const MenuState({
    required Menu menu,
    required List<MenuItem> item,
  })  : _menu = menu,
        _menuItems = item;

  final Menu _menu;
  final List<MenuItem> _menuItems;

  //
  bool get isLoaded => this is MenuLoaded;
  bool get isError => this is MenuError;
  bool get isInitial => this is MenuInitial;

  // getters
  Menu get menu => _menu;
  List<MenuItem> get items => _menuItems;

  // props
  @override
  List<Object> get props => [
        _menu,
        _menuItems,
      ];
}

class MenuInitial extends MenuState {
  const MenuInitial({
    required super.menu,
    required super.item,
  });
}

class MenuLoaded extends MenuState {
  const MenuLoaded({
    required super.menu,
    required super.item,
  });
}

class MenuError extends MenuState {
  const MenuError({
    required super.menu,
    required super.item,
  });
}
