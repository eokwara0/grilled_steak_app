part of 'menu_edit_cubit.dart';

enum MenuEditStatus { initial, error, success, changed }

abstract class MenuEditState extends Equatable {
  const MenuEditState({required Menu menu, required MenuEditStatus status})
      : _menu = menu,
        _status = status;

  final Menu _menu;
  final MenuEditStatus _status;

  // Getters
  Menu get menu => _menu;
  MenuEditStatus get status => _status;

  // checks

  bool get isSubmitted => this is MenuEditSubmitted;
  bool get isError => this is MenuEditError;
  //

  @override
  List<Object> get props => [_menu, _status];
}

class MenuEditInitial extends MenuEditState {
  const MenuEditInitial({required super.menu, required super.status});
}

class MenuEditChanged extends MenuEditState {
  const MenuEditChanged({required super.menu, required super.status});
}

class MenuEditSubmitted extends MenuEditState {
  const MenuEditSubmitted({required super.menu, required super.status});
}

class MenuEditDelete extends MenuEditState {
  const MenuEditDelete({required super.menu, required super.status});
}

class MenuEditError extends MenuEditState {
  const MenuEditError({required super.menu, required super.status});
}
