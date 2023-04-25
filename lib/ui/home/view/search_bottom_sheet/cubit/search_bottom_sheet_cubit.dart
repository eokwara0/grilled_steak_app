import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:menu_repository/menu_repository.dart';

part 'search_bottom_sheet_state.dart';

class SearchBottomSheetCubit extends Cubit<SearchBottomSheetState> {
  final MenuItemRepository _menuItemRepo;
  SearchBottomSheetCubit({
    required MenuItemRepository menuItemRepo,
  })  : _menuItemRepo = menuItemRepo,
        super(
          const SearchBottomSheetInitial(
            result: [],
            status: SearchBottomSheetStatus.initial,
          ),
        );

  Future<void> onSubmit(String search) async {
    try {
      List<MenuItem>? items = await _menuItemRepo.getItemsBySearch(search);
      if (items == null || items.isEmpty) {
        emit(
          const SearchBottomSheetInitial(
            result: [],
            status: SearchBottomSheetStatus.initial,
          ),
        );
      } else {
        // print(items);
        emit(
          SearchBottomSheetLoaded(
            result: items,
            status: SearchBottomSheetStatus.success,
          ),
        );
      }
    } on Exception {
      emit(
        const SearchBottomSheetError(
          result: [],
          status: SearchBottomSheetStatus.error,
        ),
      );
    }
  }
}
