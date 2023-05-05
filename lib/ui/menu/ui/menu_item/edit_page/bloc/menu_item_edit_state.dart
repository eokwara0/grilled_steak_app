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

  bool get recipeChanged => this is MenuItemRecipeChanged;
  bool get isSubmitted => this is MenuItemSubmitted;
  bool get isDeleted => this is MenuItemDeletedState;
  bool get isError => this is MenuItemEditError;
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

class MenuItemDeletedState extends MenuItemEditState {
  const MenuItemDeletedState(super.menuItem, super.status);
}

class MenuItemEditError extends MenuItemEditState {
  const MenuItemEditError(super.menuItem, super.status);
}

class MenuItemRecipeChanged extends MenuItemEditState {
  const MenuItemRecipeChanged(super.menuItem, super.status);
}
