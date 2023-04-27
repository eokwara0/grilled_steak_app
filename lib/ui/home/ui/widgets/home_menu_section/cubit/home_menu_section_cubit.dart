import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:menu_repository/menu_repository.dart';

part 'home_menu_section_state.dart';

class HomeMenuSectionCubit extends Cubit<HomeMenuSectionState> {
  final MenuRepository _menuRepository;
  HomeMenuSectionCubit({
    required MenuRepository menuRepo,
  })  : _menuRepository = menuRepo,
        super(const HomeMenuSectionInitial(menus: [])) {
    initialize();
  }

  Future<void> initialize() async {
    try {
      List<Menu>? menus = await _menuRepository.getMenus();
      if (menus == null) {
        return emit(const HomeMenuSectionError(menus: []));
      }
      return emit(HomeMenuSectionLoaded(menus: menus));
    } on Exception {
      return emit(const HomeMenuSectionError(menus: []));
    }
  }
}
