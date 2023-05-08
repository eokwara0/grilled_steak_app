part of 'menu_manage_cubit.dart';

enum MenuManageStatus { initial, loaded, error }

abstract class MenuManageState extends Equatable {
  const MenuManageState({
    required List<Menu> menus_,
    required Map<String, List<MenuItem>> items,
    required MenuManageStatus status_,
  })  : menus = menus_,
        menusToItems = items,
        status = status_;

  final List<Menu> menus;
  final Map<String, List<MenuItem>> menusToItems;
  final MenuManageStatus status;

  // getters
  Map<String, List<MenuItem>> get menusToItem => menusToItems;
  List<Menu> get menu => menus;
  MenuManageStatus get status_ => status;

  // state checkers

  bool get isInitial => this is MenuManageInitialState;
  bool get isLoaded => this is MenuManageLoadedState;
  bool get isError => this is MenuManageErrorState;
  bool get isSubmitted => this is MenuManageSubmittedState;
  //
  @override
  List<Object> get props => [menus, menusToItems, status];
}

class MenuManageInitialState extends MenuManageState {
  const MenuManageInitialState(
      {required super.menus_, required super.items, required super.status_});
}

class MenuManageLoadedState extends MenuManageState {
  const MenuManageLoadedState(
      {required super.menus_, required super.items, required super.status_});
}

class MenuEditChanged extends MenuManageState {
  const MenuEditChanged({
    required super.menus_,
    required super.items,
    required super.status_,
  });
}

class MenuManageErrorState extends MenuManageState {
  const MenuManageErrorState(
      {required super.menus_, required super.items, required super.status_});
}

class MenuManageSubmittedState extends MenuManageState {
  const MenuManageSubmittedState(
      {required super.menus_, required super.items, required super.status_});
}
