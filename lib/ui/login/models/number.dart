import 'package:formz/formz.dart';

enum PhoneNumberValidatorError { empty, invalid }

class PhoneNumber extends FormzInput<String, PhoneNumberValidatorError> {
  const PhoneNumber.pure() : super.pure('');
  const PhoneNumber.dirty([super.value = '']) : super.dirty();

  @override
  PhoneNumberValidatorError? validator(String value) {
    const patt = r"^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$";
    final vali = RegExp(patt);
    if (value.isEmpty) return PhoneNumberValidatorError.empty;
    if (!vali.hasMatch(value)) return PhoneNumberValidatorError.invalid;
    return null;
  }
}
