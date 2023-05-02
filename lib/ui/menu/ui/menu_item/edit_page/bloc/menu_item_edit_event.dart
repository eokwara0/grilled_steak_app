part of 'menu_item_edit_bloc.dart';

abstract class MenuItemEditEvent extends Equatable {
  const MenuItemEditEvent(this.value);

  final dynamic value;

  @override
  List<Object> get props => [value];
}

class MenuItemActiveEditEvent extends MenuItemEditEvent {
  const MenuItemActiveEditEvent(super.value);
}

class MenuItemUrlChangedEvent extends MenuItemEditEvent {
  const MenuItemUrlChangedEvent(super.value);
}

class MenuItemTitleChangedEvent extends MenuItemEditEvent {
  const MenuItemTitleChangedEvent(super.value);
}

class MenuItemSummaryChangedEvent extends MenuItemEditEvent {
  const MenuItemSummaryChangedEvent(super.value);
}

class MenuItemContentChangedEvent extends MenuItemEditEvent {
  const MenuItemContentChangedEvent(super.value);
}

class MenuItemQuantityChangedEvent extends MenuItemEditEvent {
  const MenuItemQuantityChangedEvent(super.value);
}

class MenuItemPriceChangedEVent extends MenuItemEditEvent {
  const MenuItemPriceChangedEVent(super.value);
}

class MenuItemNutritionChangedEvent extends MenuItemEditEvent {
  const MenuItemNutritionChangedEvent(super.value);
}

class MenuItemRecipeChangedEvent extends MenuItemEditEvent {
  const MenuItemRecipeChangedEvent(super.value);
}

class MenuItemInstructionsChangedEvent extends MenuItemEditEvent {
  const MenuItemInstructionsChangedEvent(super.value);
}

class MenuItemSubmitEvent extends MenuItemEditEvent {
  const MenuItemSubmitEvent(super.value);
}