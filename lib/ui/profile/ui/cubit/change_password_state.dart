part of 'change_password_cubit.dart';

abstract class ChangePasswordState extends Equatable {
  const ChangePasswordState({
    required Password oldPassword,
    required Password newPassword,
    required FormzStatus status,
  })  : _oldPassword = oldPassword,
        _newPassword = newPassword,
        _status = status;

  final Password _oldPassword;
  final Password _newPassword;
  final FormzStatus _status;

  Password get oldPassword => _oldPassword;
  Password get newPassword => _newPassword;
  FormzStatus get status => _status;

  bool get isError => this is ChangePasswordError;
  bool get isSuccess => this is ChangePasswordSuccessful;
  bool get isChanged => this is ChangePasswordChanged;

  @override
  List<Object> get props => [_oldPassword, _newPassword, _status];
}

class ChangePasswordInitial extends ChangePasswordState {
  const ChangePasswordInitial({
    required super.oldPassword,
    required super.newPassword,
    required super.status,
  });
}

class ChangePasswordChanged extends ChangePasswordState {
  const ChangePasswordChanged({
    required super.oldPassword,
    required super.newPassword,
    required super.status,
  });
}

class ChangePasswordSuccessful extends ChangePasswordState {
  const ChangePasswordSuccessful({
    required super.oldPassword,
    required super.newPassword,
    required super.status,
  });
}

class ChangePasswordError extends ChangePasswordState {
  const ChangePasswordError({
    required super.oldPassword,
    required super.newPassword,
    required super.status,
  });
}
