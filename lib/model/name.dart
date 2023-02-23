import 'package:formz/formz.dart';

enum NameValidationError { empty }

class Name extends FormzInput<String, NameValidationError> {
  const Name.dirty([String value = '']) : super.dirty(value);

  const Name.pure() : super.pure('');

  @override
  NameValidationError? validator(String value) {
    return value.isNotEmpty == true && !value.trim().startsWith('0')
        ? null
        : NameValidationError.empty;
  }
}
