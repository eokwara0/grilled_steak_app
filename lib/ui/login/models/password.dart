import 'package:formz/formz.dart';

enum PasswordValidatorError { empty, invalid }

class Password extends FormzInput<String, PasswordValidatorError> {
  // formz data handling
  const Password.pure() : super.pure('');
  const Password.dirty([super.value = '']) : super.dirty();

  @override
  PasswordValidatorError? validator(String value) {
    final regex =
        RegExp(r'^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$');
    if (value.isEmpty) return PasswordValidatorError.empty;
    if (!regex.hasMatch(value)) return PasswordValidatorError.invalid;

    return null;
  }
}
