import 'package:flutter_test/flutter_test.dart';

import 'package:data_validation/data_validation.dart';

void main() {
  test('validates single data', () {
    final validator = SingleValidation('test@example.com', Validation.email()).validate();
    expect(validator.error, false);
    expect(validator.data['email'], 'test@example.com');
  });
}
