import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:menu_repository/menu_repository.dart';

part 'menu_item_edit_event.dart';
part 'menu_item_edit_state.dart';

class MenuItemEditBloc extends Bloc<MenuItemEditEvent, MenuItemEditState> {
  MenuItemEditBloc(
      {required MenuItemRepository menuItemRepo, required MenuItem item})
      : _menuItemRepository = menuItemRepo,
        super(
          MenuItemEditInitial(
            item,
            FormzStatus.pure,
          ),
        ) {
    on<MenuItemActiveEditEvent>(
      _onMenuItemActiveChanged,
    );
    on<MenuItemUrlChangedEvent>(
      _onMenuItemUrlChanged,
    );
    on<MenuItemTitleChangedEvent>(
      _onMenuItemTitleChanged,
    );

    on<MenuItemSubmitEvent>(
      _onMenuItemSubmit,
    );

    on<MenuItemSummaryChangedEvent>(
      _onMenuItemSummaryChanged,
    );
    on<MenuItemContentChangedEvent>(
      _onMenuItemContentChanged,
    );
    on<MenuItemQuantityChangedEvent>(
      _onMenuItemQuantityChanged,
    );
    on<MenuItemPriceChangedEVent>(
      _onMenuItemPriceChanged,
    );
    on<MenuItemNutritionChangedEvent>(
      _onMenuItemNutritionChanged,
    );
    on<MenuItemRecipeChangedEvent>(
      _onMenuItemRecipeChanged,
    );
    on<MenuItemInstructionsChangedEvent>(
      _onMenuItemInstructionsChanged,
    );

    on<MenuItemDeleteEvent>(_onMenuItemDeleted);
  }

  final MenuItemRepository _menuItemRepository;

  _onMenuItemDeleted(
    MenuItemDeleteEvent event,
    emit,
  ) async {
    bool? response =
        await _menuItemRepository.deleteItemById(state.menuItem.id);
    if (response ?? false) {
      return emit(
        MenuItemDeletedState(
          state.menuItem,
          FormzStatus.submissionSuccess,
        ),
      );
    }
    return emit(
      MenuItemEditError(state.menuItem, FormzStatus.submissionFailure),
    );
  }

  // event handlers
  _onMenuItemSummaryChanged(
    event,
    emit,
  ) {
    emit(
      MenuItemChanged(
        state.menuItem.copyWith(
          item: state.menuItem.item?.copyWith(summary: event.value),
        ),
        FormzStatus.valid,
      ),
    );
  }

  _onMenuItemContentChanged(
    event,
    emit,
  ) {
    emit(MenuItemChanged(
      state.menuItem.copyWith(
        item: state.menuItem.item?.copyWith(
          content: event.value,
        ),
      ),
      FormzStatus.valid,
    ));
  }

  _onMenuItemQuantityChanged(
    event,
    emit,
  ) {
    emit(
      MenuItemChanged(
        state.menuItem.copyWith(
          item: state.menuItem.item?.copyWith(
            quantity: event.value,
          ),
        ),
        FormzStatus.valid,
      ),
    );
  }

  _onMenuItemPriceChanged(
    event,
    emit,
  ) {
    emit(
      MenuItemChanged(
        state.menuItem.copyWith(
          item: state.menuItem.item?.copyWith(price: event.value),
        ),
        FormzStatus.valid,
      ),
    );
  }

  _onMenuItemNutritionChanged(
    event,
    emit,
  ) {
    // print(event.value);
    emit(
      MenuItemChanged(
        state.menuItem.copyWith(
          item: state.menuItem.item?.copyWith(nutrition: event.value),
        ),
        FormzStatus.valid,
      ),
    );
  }

  _onMenuItemRecipeChanged(
    event,
    emit,
  ) {
    emit(
      MenuItemRecipeChanged(
        state.menuItem.copyWith(
          item: state.menuItem.item
              ?.copyWith(recipe: event.value as List<Recipe>),
        ),
        FormzStatus.valid,
      ),
    );
  }

  _onMenuItemInstructionsChanged(
    event,
    emit,
  ) {
    emit(
      MenuItemChanged(
        state.menuItem.copyWith(
          item: state.menuItem.item?.copyWith(instructions: event.value),
        ),
        FormzStatus.valid,
      ),
    );
  }

  _onMenuItemSubmit(
    MenuItemSubmitEvent event,
    Emitter<MenuItemEditState> emit,
  ) async {
    bool answer = await _menuItemRepository.replaceMenuItem(state.menuItem);
    if (answer) {
      return emit(
        MenuItemSubmitted(state.menuItem, FormzStatus.submissionSuccess),
      );
    }
    return emit(
      MenuItemEditError(state.menuItem, FormzStatus.submissionFailure),
    );
  }

  /// updates the menu Item Object with the relevant active value
  _onMenuItemActiveChanged(
    MenuItemActiveEditEvent event,
    Emitter<MenuItemEditState> emit,
  ) {
    emit(
      MenuItemChanged(
          state.menuItem.copyWith(active: event.value), FormzStatus.valid),
    );
  }

  _onMenuItemUrlChanged(
    MenuItemUrlChangedEvent event,
    Emitter<MenuItemEditState> emit,
  ) {}

  // emits a new state when title changes
  _onMenuItemTitleChanged(
    MenuItemTitleChangedEvent event,
    Emitter<MenuItemEditState> emit,
  ) {
    emit(
      MenuItemChanged(
        state.menuItem.copyWith(
          item: state.menuItem.item?.copyWith(
            title: event.value,
          ),
        ),
        FormzStatus.valid,
      ),
    );
  }
}
