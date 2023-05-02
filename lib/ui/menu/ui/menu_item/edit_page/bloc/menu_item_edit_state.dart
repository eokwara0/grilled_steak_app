part of 'menu_item_edit_bloc.dart';

abstract class MenuItemEditState extends Equatable {
  const MenuItemEditState(this.menuItem, this.status);

  final MenuItem menuItem;
  final FormzStatus status;

  @override
  List<Object> get props => [
        menuItem,
        status,
      ];
}

class MenuItemEditInitial extends MenuItemEditState {
  const MenuItemEditInitial(super.menuItem, super.status);
}

class MenuItemChanged extends MenuItemEditState {
  const MenuItemChanged(super.menuItem, super.status);
}

class MenuItemSubmitted extends MenuItemEditState {
  const MenuItemSubmitted(super.menuItem, super.status);
}

class MenuItemError extends MenuItemEditState {
  const MenuItemError(super.menuItem, super.status);
}
