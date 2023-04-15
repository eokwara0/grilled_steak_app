import 'package:formz/formz.dart';

enum EmailValidatorError { empty, invalid }

class Email extends FormzInput<String, EmailValidatorError> {
  // Email contructor
  const Email.pure() : super.pure('');
  const Email.dirty([super.value = '']) : super.dirty();

  @override
  EmailValidatorError? validator(String value) {
    const pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$";
    final validator = RegExp(pattern);
    if (value.isEmpty) return EmailValidatorError.empty;
    if (!validator.hasMatch(value)) return EmailValidatorError.invalid;
    return null;
  }
}
