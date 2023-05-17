import 'package:flutter_test/flutter_test.dart';
import 'package:indoor_map_application/Profile.dart';

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

    test("Empty Phone Number Field returns Error String", () {
      var result = PhoneNumberFieldValidator.validate("");
      expect(result, "Phone Number Field can\'t be empty");
    });
    test("Filled Phone Number Field returns null", () {
      var result = PhoneNumberFieldValidator.validate("010");
      expect(result, null);
    });
  });
}
