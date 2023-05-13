import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:menu_repository/menu_repository.dart';

part 'menu_edit_state.dart';

class MenuEditCubit extends Cubit<MenuEditState> {
  MenuEditCubit({required MenuRepository repo})
      : menuRepo = repo,
        super(
          MenuEditInitial(
            menu: Menu.empty(''),
            status: MenuEditStatus.initial,
          ),
        );

  final MenuRepository menuRepo;

  add(Menu menu) {
    return emit(
      MenuEditChanged(
        menu: menu,
        status: MenuEditStatus.changed,
      ),
    );
  }

  titleChange(String title) {
    return emit(
      MenuEditChanged(
        menu: state.menu.copyWith(title: title),
        status: MenuEditStatus.changed,
      ),
    );
  }

  summaryChanged(String summary) {
    return emit(
      MenuEditChanged(
        menu: state.menu.copyWith(summary: summary),
        status: MenuEditStatus.changed,
      ),
    );
  }

  contentChanged(String summary) {
    return emit(
      MenuEditChanged(
        menu: state.menu.copyWith(content: summary),
        status: MenuEditStatus.changed,
      ),
    );
  }

  addMenu(Menu menu) async {
    bool submitted = await menuRepo.addMenu(menu);
    if (submitted) {
      return emit(
        MenuEditSubmitted(menu: menu, status: MenuEditStatus.success),
      );
    }

    return emit(
      MenuEditError(menu: menu, status: MenuEditStatus.error),
    );
  }

  deleteMenu(Menu menu) async {
    bool response = await menuRepo.deleteMenuById(menu.id!);
    if (response) {
      emit(
        MenuEditSubmitted(menu: menu, status: MenuEditStatus.success),
      );
      return true;
    }
    emit(
      MenuEditError(menu: menu, status: MenuEditStatus.error),
    );
    return false;
  }

  uploadImage() async {
    File? file = await getImage();

    if (file != null) {
      String? url = await menuRepo.uploadImage(file);
      if (url != null) {
        return emit(
          MenuEditChanged(
            menu: state.menu.copyWith(imageUrl: url),
            status: MenuEditStatus.changed,
          ),
        );
      }
    }
  }

  Future<File?> getImage() async {
    try {
      final image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );
      if (image == null) return null;
      return File(image.path);
    } catch (e) {
      return null;
    }
  }
}
