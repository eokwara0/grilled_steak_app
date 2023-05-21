import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:service_locator/service_locator.dart';
import 'package:user_repository/user_repository.dart';

import '../../../login/models/password.dart';

part 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(
          const ChangePasswordInitial(
            newPassword: Password.dirty(),
            oldPassword: Password.dirty(),
            status: FormzStatus.invalid,
          ),
        );

  final UserRepository _userRepository;
  final SecureStorage _ss = sl<SecureStorage>();

  oldPasswordChanged(String password) async {
    String? currentPassword = await _ss.readKey('password');

    if (currentPassword != null) {
      bool eq = password == currentPassword;
      return emit(ChangePasswordChanged(
        oldPassword: eq ? Password.dirty(password) : const Password.dirty(''),
        newPassword: state._newPassword,
        status: !eq ? state._status : FormzStatus.valid,
      ));
    } else {
      return emit(ChangePasswordChanged(
        oldPassword: state.oldPassword,
        newPassword: state.newPassword,
        status: state.status,
      ));
    }
  }

  newPasswordChanged(String password) async {
    return emit(
      ChangePasswordChanged(
        oldPassword: state._oldPassword,
        newPassword: Password.dirty(password),
        status: Formz.validate(
          [Password.dirty(password)],
        ),
      ),
    );
  }

  changePassword(String userId) async {
    bool res =
        await _userRepository.changePassword(userId, state._newPassword.value);
    if (res) {
      return emit(
        ChangePasswordSuccessful(
            oldPassword: state._oldPassword,
            newPassword: state.newPassword,
            status: state.status),
      );
    }

    return emit(
      ChangePasswordError(
        oldPassword: state._oldPassword,
        newPassword: state.newPassword,
        status: state._status,
      ),
    );
  }
}
