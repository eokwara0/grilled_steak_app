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

    on<MenuItemSummaryChangedEvent>(_onMenuItemSummaryChanged);
    on<MenuItemContentChangedEvent>(_onMenuItemContentChanged);
    on<MenuItemQuantityChangedEvent>(_onMenuItemQuantityChanged);
    on<MenuItemPriceChangedEVent>(_onMenuItemPriceChanged);
    on<MenuItemNutritionChangedEvent>(_onMenuItemNutritionChanged);
    on<MenuItemRecipeChangedEvent>(_onMenuItemRecipeChanged);
    on<MenuItemInstructionsChangedEvent>(_onMenuItemInstructionsChanged);
  }

  final MenuItemRepository _menuItemRepository;

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
        item: state.menuItem.item?.copyWith(content: event.value),
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
      MenuItemChanged(
        state.menuItem.copyWith(
          item: state.menuItem.item?.copyWith(recipe: event.value),
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
    print(state.menuItem.id);
    bool answer = await _menuItemRepository.replaceMenuItem(state.menuItem);
    // print(answer);
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
