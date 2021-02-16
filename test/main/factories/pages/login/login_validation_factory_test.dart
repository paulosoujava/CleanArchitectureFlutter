import 'package:test/test.dart';

import 'package:clean_architecture/main/factories/factories.dart';
import 'package:clean_architecture/validation/validators/validators.dart';

void main() {
  setUp(() {});
  test('should return the correct validations', () {
    final validations = makeLoginValidations();

    expect(validations, [
      RequiredFieldValidation('email'),
      EmailValidation('email'),
      RequiredFieldValidation('password'),
    ]);
  });
}
