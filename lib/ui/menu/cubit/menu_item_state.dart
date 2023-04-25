part of 'menu_item_cubit.dart';

abstract class MenuItemState extends Equatable {
  const MenuItemState({
    required MenuItem item,
  }) : _item = item;

  final MenuItem _item;

  // getter
  get item => _item;

  // props
  @override
  List<Object> get props => [_item];
}

class MenuItemInitial extends MenuItemState {
  const MenuItemInitial({required super.item});
}
