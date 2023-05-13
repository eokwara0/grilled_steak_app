import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:menu_repository/menu_repository.dart';

part 'menu_manage_state.dart';

class MenuManageCubit extends Cubit<MenuManageState> {
  MenuManageCubit({
    required MenuRepository menuRepository,
    required MenuItemRepository menuItemRepository,
  })  : _menuRepository = menuRepository,
        _menuItemRepository = menuItemRepository,
        super(
          const MenuManageInitialState(
            menus_: [],
            items: {},
            status_: MenuManageStatus.initial,
          ),
        ) {
    initialize();
  }

  final MenuRepository _menuRepository;
  final MenuItemRepository _menuItemRepository;

  // initialize the data
  Future<void> initialize() async {
    Map<String, List<MenuItem>> menuToItem = {};
    List<Menu>? menus = await _menuRepository.getMenus();

    if (menus != null) {
      for (var e in menus) {
        List<MenuItem> items =
            await _menuItemRepository.getItemsByMenuId(e.id!) ?? [];
        menuToItem.addAll({e.title!: items});
      }
      return emit(
        MenuManageLoadedState(
            menus_: menus, items: menuToItem, status_: MenuManageStatus.loaded),
      );
    }
    return emit(
      const MenuManageErrorState(
        menus_: [],
        items: {},
        status_: MenuManageStatus.error,
      ),
    );
  }
}
