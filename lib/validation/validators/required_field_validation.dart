import '../protocols/protocols.dart';

class RequiredFieldValidation extends Comparable<RequiredFieldValidation> implements FieldValidation {
  final String field;

  RequiredFieldValidation(this.field);

  String validate(String value) {
    return value?.isNotEmpty == true ? null : 'Campo obrigatório';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is RequiredFieldValidation && o.field == field;
  }

  @override
  int get hashCode => field.hashCode;

  @override
  int compareTo(RequiredFieldValidation other) {
    return this == other ? 1 : -1;
  }
}
