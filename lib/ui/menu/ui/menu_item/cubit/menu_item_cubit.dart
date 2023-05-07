import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:menu_repository/menu_repository.dart';

part 'menu_item_state.dart';

class MenuItemCubit extends Cubit<MenuItemState> {
  MenuItemCubit()
      : super(
          MenuItemInitial(
            item: MenuItem.empty('', ''),
          ),
        );

  void addItem(MenuItem item) {
    emit(
      MenuItemInitial(item: item),
    );
  }
}
