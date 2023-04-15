part of 'forgot_password_cubit.dart';

abstract class ForgotPasswordState extends Equatable {
  // properties
  final Email email;
  final FormzStatus status;

  // constructor
  const ForgotPasswordState({
    required this.email,
    required this.status,
  });

  ForgotPasswordState copyWith({Email? email, FormzStatus? status}) {
    return ForgotPasswordInitial(
      email: email ?? this.email,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [
        status,
        email,
      ];
}

class ForgotPasswordInitial extends ForgotPasswordState {
  const ForgotPasswordInitial({required super.email, required super.status});
}

class ForgotPasswordLoaded extends ForgotPasswordState {
  const ForgotPasswordLoaded({required super.email, required super.status});
}

class ForgotPasswordError extends ForgotPasswordState {
  const ForgotPasswordError({required super.email, required super.status});
}
