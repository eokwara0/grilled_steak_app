import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import '../../login/models/email.dart';

part 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final AuthenticationRepository authRepo;
  bool valid = false;
  ForgotPasswordCubit({
    required this.authRepo,
  }) : super(const ForgotPasswordInitial(
          email: Email.dirty(''),
          status: FormzStatus.pure,
        ));

  void onEmailChanged(String value) {
    emit(ForgotPasswordInitial(
      email: Email.dirty(value),
      status: Formz.validate([state.email]),
    ));
  }

  Future<void> submit() async {
    try {
      final res = await authRepo.forgotPassword(
        email: state.email.value,
      );

      if (res) {
        return emit(
          const ForgotPasswordLoaded(
            email: Email.pure(),
            status: FormzStatus.submissionSuccess,
          ),
        );
      }

      emit(
        const ForgotPasswordError(
          email: Email.pure(),
          status: FormzStatus.submissionFailure,
        ),
      );
    } catch (e) {
      return emit(
        ForgotPasswordError(
          email: Email.pure(),
          status: state.status,
        ),
      );
    }
  }
}
