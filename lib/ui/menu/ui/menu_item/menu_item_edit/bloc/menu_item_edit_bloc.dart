import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:menu_repository/menu_repository.dart';

part 'menu_item_edit_event.dart';
part 'menu_item_edit_state.dart';

class MenuItemEditBloc extends Bloc<MenuItemEditEvent, MenuItemEditState> {
  MenuItemEditBloc({
    required MenuItemRepository menuItemRepo,
    required MenuItem item,
    required MenuRepository menuRepo,
  })  : _menuItemRepository = menuItemRepo,
        _menuRepo = menuRepo,
        super(
          MenuItemEditInitial(item: item, status_: FormzStatus.pure),
        ) {
    on<MenuItemActiveEditEvent>(
      _onMenuItemActiveChanged,
    );

    on<MenuItemAddEvent>(_onMenuItemAdd);
    on<MenuItemFileChangedEvent>(
      _onMenuItemFileChanged,
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
  final MenuRepository _menuRepo;

  _onMenuItemAdd(MenuItemAddEvent event, emit) async {}
  _onMenuItemDeleted(
    MenuItemDeleteEvent event,
    emit,
  ) async {
    bool? response =
        await _menuItemRepository.deleteItemById(state.menuItem.id);
    if (response ?? false) {
      return emit(
        MenuItemDeletedState(
          item: state.menuItem,
          status_: FormzStatus.submissionSuccess,
        ),
      );
    }
    return emit(
      MenuItemEditError(
        item: state.menuItem,
        status_: FormzStatus.submissionFailure,
      ),
    );
  }

  // event handlers
  _onMenuItemSummaryChanged(
    event,
    emit,
  ) {
    emit(
      MenuItemChanged(
        item: state.menuItem.copyWith(
          item: state.menuItem.item?.copyWith(summary: event.value),
        ),
        status_: FormzStatus.valid,
      ),
    );
  }

  _onMenuItemContentChanged(
    event,
    emit,
  ) {
    emit(MenuItemChanged(
      item: state.menuItem.copyWith(
        item: state.menuItem.item?.copyWith(
          content: event.value,
        ),
      ),
      status_: FormzStatus.valid,
    ));
  }

  _onMenuItemQuantityChanged(
    event,
    emit,
  ) {
    emit(
      MenuItemChanged(
        item: state.menuItem.copyWith(
          item: state.menuItem.item?.copyWith(
            quantity: event.value,
          ),
        ),
        status_: FormzStatus.valid,
      ),
    );
  }

  _onMenuItemPriceChanged(
    event,
    emit,
  ) {
    emit(
      MenuItemChanged(
        item: state.menuItem.copyWith(
          item: state.menuItem.item?.copyWith(price: event.value),
        ),
        status_: FormzStatus.valid,
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
        item: state.menuItem.copyWith(
          item: state.menuItem.item?.copyWith(nutrition: event.value),
        ),
        status_: FormzStatus.valid,
      ),
    );
  }

  _onMenuItemRecipeChanged(
    event,
    emit,
  ) {
    emit(
      MenuItemRecipeChanged(
        item: state.menuItem.copyWith(
          item: state.menuItem.item
              ?.copyWith(recipe: event.value as List<Recipe>),
        ),
        status_: FormzStatus.valid,
      ),
    );
  }

  _onMenuItemInstructionsChanged(
    event,
    emit,
  ) {
    emit(
      MenuItemChanged(
        item: state.menuItem.copyWith(
          item: state.menuItem.item?.copyWith(instructions: event.value),
        ),
        status_: FormzStatus.valid,
      ),
    );
  }

  _onMenuItemSubmit(
    MenuItemSubmitEvent event,
    Emitter<MenuItemEditState> emit,
  ) async {
    // validate if image has been uploaded and get the new url

    if (!state.fileIsNull) {
      Menu? menu = await _menuRepo.getMenuById(state.menuItem.menuId!);
      String dirName = menu?.title?.toLowerCase() ?? 'files';

      // TODO: Change this to dirName
      String? url = await _menuItemRepository.uploadImage(state.file, 'files');
      emit(
        MenuItemChanged(
          item: state.menuItem.copyWith(imageUrl: url),
          status_: FormzStatus.valid,
        ),
      );
    }

    // Try updating the item and emit a submitted state.
    bool answer = await _menuItemRepository.replaceMenuItem(state.menuItem);

    if (answer) {
      return emit(
        MenuItemSubmitted(
          item: state.menuItem,
          status_: FormzStatus.submissionSuccess,
        ),
      );
    }
    return emit(
      MenuItemEditError(
        item: state.menuItem,
        status_: FormzStatus.submissionFailure,
      ),
    );
  }

  /// updates the menu Item Object with the relevant active value
  _onMenuItemActiveChanged(
    MenuItemActiveEditEvent event,
    Emitter<MenuItemEditState> emit,
  ) {
    emit(
      MenuItemChanged(
        item: state.menuItem.copyWith(active: event.value),
        status_: FormzStatus.valid,
      ),
    );
  }

  _onMenuItemFileChanged(
    MenuItemFileChangedEvent event,
    Emitter<MenuItemEditState> emit,
  ) async {
    File? file = await getImage();

    return emit(
      MenuItemChanged(
        item: state.menuItem,
        status_: FormzStatus.valid,
        file: File(file!.path),
      ),
    );
  }

  Future<File?> getImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return null;
      return File(image.path);
    } catch (e) {
      return null;
    }
  }

  // emits a new state when title changes
  _onMenuItemTitleChanged(
    MenuItemTitleChangedEvent event,
    Emitter<MenuItemEditState> emit,
  ) {
    emit(
      MenuItemChanged(
        item: state.menuItem.copyWith(
          item: state.menuItem.item?.copyWith(
            title: event.value,
          ),
        ),
        status_: FormzStatus.valid,
      ),
    );
  }
}
