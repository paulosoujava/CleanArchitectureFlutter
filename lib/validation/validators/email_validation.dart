import '../protocols/protocols.dart';

class EmailValidation extends Comparable<EmailValidation> implements FieldValidation {
  final String field;

  EmailValidation(this.field);

  String validate(String value) {
    final regex = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    final isValid = value?.isNotEmpty != true || regex.hasMatch(value);
    return isValid ? null : 'Campo inválido';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is EmailValidation && o.field == field;
  }

  @override
  int get hashCode => field.hashCode;

  @override
  int compareTo(EmailValidation other) {
    return this == other ? 1 : -1;
  }
}
