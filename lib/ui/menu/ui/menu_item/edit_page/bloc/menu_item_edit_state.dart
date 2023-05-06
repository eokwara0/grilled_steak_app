part of 'menu_item_edit_bloc.dart';

abstract class MenuItemEditState extends Equatable {
  const MenuItemEditState({
    required MenuItem item,
    File? file_,
    required FormzStatus status_,
  })  : menuItem = item,
        file = file_,
        status = status_;

  final MenuItem menuItem;
  final File? file;
  final FormzStatus status;

  @override
  List<Object?> get props => [
        menuItem,
        status,
        file,
      ];

  bool get recipeChanged => this is MenuItemRecipeChanged;
  bool get isSubmitted => this is MenuItemSubmitted;
  bool get isDeleted => this is MenuItemDeletedState;
  bool get isError => this is MenuItemEditError;
  bool get fileIsNull => file == null;
}

class MenuItemEditInitial extends MenuItemEditState {
  const MenuItemEditInitial({required super.item, required super.status_});
}

class MenuItemChanged extends MenuItemEditState {
  const MenuItemChanged(
      {required super.item, required super.status_, File? file})
      : super(file_: file);
}

class MenuItemSubmitted extends MenuItemEditState {
  const MenuItemSubmitted(
      {required super.item, required super.status_, File? file})
      : super(file_: file);
}

class MenuItemDeletedState extends MenuItemEditState {
  const MenuItemDeletedState(
      {required super.item, required super.status_, File? file})
      : super(file_: file);
}

class MenuItemEditError extends MenuItemEditState {
  const MenuItemEditError(
      {required super.item, required super.status_, File? file})
      : super(file_: file);
}

class MenuItemRecipeChanged extends MenuItemEditState {
  const MenuItemRecipeChanged({
    required super.item,
    required super.status_,
    File? file,
  }) : super(file_: file);
}
