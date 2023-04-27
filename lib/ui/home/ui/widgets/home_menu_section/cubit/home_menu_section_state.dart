part of 'home_menu_section_cubit.dart';

abstract class HomeMenuSectionState extends Equatable {
  const HomeMenuSectionState({required List<Menu> menus}) : _menus = menus;
  final List<Menu> _menus;

  bool get isInitial => this is HomeMenuSectionInitial;
  bool get isLoaded => this is HomeMenuSectionLoaded;
  bool get isError => this is HomeMenuSectionError;

  List<Menu> get menus => _menus;
  @override
  List<Object> get props => [_menus];
}

class HomeMenuSectionInitial extends HomeMenuSectionState {
  const HomeMenuSectionInitial({required super.menus});
}

class HomeMenuSectionLoaded extends HomeMenuSectionState {
  const HomeMenuSectionLoaded({required super.menus});
}

class HomeMenuSectionError extends HomeMenuSectionState {
  const HomeMenuSectionError({required super.menus});
}
