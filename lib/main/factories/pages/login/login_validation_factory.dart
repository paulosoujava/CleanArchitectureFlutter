import '../../../builders/validation_builder.dart';
import '../../../../presentetion/protocols/protocols.dart';
import '../../../../validation/validators/validators.dart';
import '../../../../validation/protocols/protocols.dart';

Validation makeLoginValidation() {
  return ValidationComposite(makeLoginValidations());
}

List<FieldValidation> makeLoginValidations() {
  return [
    // RequiredFieldValidation('email'),
    // RequiredFieldValidation('password'),
    // EmailValidation('email'),
    ...ValidationBuilder.field('email').required().email().build(),
    ...ValidationBuilder.field('password').required().build(),
  ];
}
