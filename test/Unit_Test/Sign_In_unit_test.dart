import 'package:flutter_test/flutter_test.dart';
import 'package:indoor_map_application/Sign_In.dart';

void main() {
  group("Try empty fields and non empty fields", () {
    test("Empty Email Field returns Error String", () {
      var result = EmailFieldValidator.validate("");
      expect(result, "Email Field can\'t be empty");
    });
    test("filled Email Field returns null", () {
      var result = EmailFieldValidator.validate("admin@admin.com");
      expect(result, null);
    });
    test("Empty Password Field returns Error String", () {
      var result = PasswordFieldValidator.validate("");
      expect(result, "Password Field can\'t be empty");
    });
    test("filled Password Field returns null", () {
      var result = PasswordFieldValidator.validate("12345");
      expect(result, null);
    });
  });
}
