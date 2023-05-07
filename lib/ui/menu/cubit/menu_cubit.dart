import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:menu_repository/menu_repository.dart';

part 'menu_state.dart';

class MenuCubit extends Cubit<MenuState> {
  MenuCubit({
    required MenuRepository menuRepository,
    required MenuItemRepository menuItemRepository,
  })  : _menuItemRepository = menuItemRepository,
        _menuRepository = menuRepository,
        super(
          const MenuInitial(
            item: [],
            menu: Menu(id: ''),
          ),
        );

  final MenuRepository _menuRepository;
  final MenuItemRepository _menuItemRepository;

  Future<void> addMenu(Menu menu) async {
    List<MenuItem>? items =
        await _menuItemRepository.getItemsByMenuId(menu.id!);

    if (items != null) {
      return emit(
        MenuLoaded(
          menu: menu,
          item: items,
        ),
      );
    }

    return emit(
      MenuError(
        menu: menu,
        item: const [],
      ),
    );
  }
}
