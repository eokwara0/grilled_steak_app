import 'package:formz/formz.dart';

enum PasswordValidatorError { empty }

class Password extends FormzInput<String, PasswordValidatorError> {
  // formz data handling
  const Password.pure() : super.pure('');
  const Password.dirty([super.value = '']) : super.dirty();

  @override
  PasswordValidatorError? validator(String value) {
    if (value.isEmpty) return PasswordValidatorError.empty;
    return null;
  }
}
