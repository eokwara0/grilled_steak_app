import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:menu_repository/menu_repository.dart';

part 'home_menu_item_recommendation_state.dart';

class HomeMenuItemRecommendationCubit
    extends Cubit<HomeMenuItemRecommendationState> {
  final MenuItemRepository _menuItemRepo;
  HomeMenuItemRecommendationCubit({required MenuItemRepository repo})
      : _menuItemRepo = repo,
        super(
          const HomeMenuItemRecommendationInitial(menuItems: []),
        ) {
    _load();
  }

  void _load() async {
    try {
      List<MenuItem>? items = await _menuItemRepo.getRecommendedItems();
      if (items == null) {
        return emit(
          const HomeMenuItemRecommendationError(
            menuItems: [],
          ),
        );
      }
      return emit(
        HomeMenuItemRecommendationLoaded(menuItems: items),
      );
    } on Exception {
      return emit(
        const HomeMenuItemRecommendationError(
          menuItems: [],
        ),
      );
    }
  }
}
