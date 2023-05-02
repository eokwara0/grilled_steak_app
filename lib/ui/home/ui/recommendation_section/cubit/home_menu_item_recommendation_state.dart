part of 'home_menu_item_recommendation_cubit.dart';

abstract class HomeMenuItemRecommendationState extends Equatable {
  const HomeMenuItemRecommendationState({required List<MenuItem> menuItems})
      : _menuItems = menuItems;

  final List<MenuItem> _menuItems;

  List<MenuItem> get menuItem => _menuItems;

  // validations
  bool get isInitial => this is HomeMenuItemRecommendationInitial;
  bool get isLoaded => this is HomeMenuItemRecommendationLoaded;
  bool get isError => this is HomeMenuItemRecommendationError;

  @override
  List<Object> get props => [_menuItems];
}

class HomeMenuItemRecommendationInitial
    extends HomeMenuItemRecommendationState {
  const HomeMenuItemRecommendationInitial({required super.menuItems});
}

class HomeMenuItemRecommendationLoaded extends HomeMenuItemRecommendationState {
  const HomeMenuItemRecommendationLoaded({required super.menuItems});
}

class HomeMenuItemRecommendationError extends HomeMenuItemRecommendationState {
  const HomeMenuItemRecommendationError({required super.menuItems});
}
