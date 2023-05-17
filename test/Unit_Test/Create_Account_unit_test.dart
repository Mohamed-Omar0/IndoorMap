import 'package:flutter_test/flutter_test.dart';
import 'package:indoor_map_application/Create_Account.dart';

void main() {
  group("Try empty fields and non empty fields", () {
    test("Empty First Name Field returns Error String", () {
      var result = FirstNameFieldValidator.validate("");
      expect(result, "First Name Field can\'t be empty");
    });
    test("Filled First Name Field returns null", () {
      var result = FirstNameFieldValidator.validate("Mohamed");
      expect(result, null);
    });

    test("Empty Second Name Field returns Error String", () {
      var result = SecondNameFieldValidator.validate("");
      expect(result, "Second Name Field can\'t be empty");
    });
    test("Filled Second Name Field returns null", () {
      var result = SecondNameFieldValidator.validate("Omar");
      expect(result, null);
    });
    test("Empty Email Field returns Error String", () {
      var result = EmailFieldValidator.validate("");
      expect(result, "Email Field can\'t be empty");
    });
    test("Filled Email Field returns null", () {
      var result = EmailFieldValidator.validate("admin@admin.com");
      expect(result, null);
    });
    test("Empty Confirm Email Field returns Error String", () {
      var result = ConfirmEmailFieldValidator.validate("");
      expect(result, "Confirm Email Field can\'t be empty");
    });
    test("Filled Confirm Email Field returns null", () {
      var result = ConfirmEmailFieldValidator.validate("admin@admin.com");
      expect(result, null);
    });
    test("Empty Password Field returns Error String", () {
      var result = PasswordFieldValidator.validate("");
      expect(result, "Password Field can\'t be empty");
    });
    test("Filled Password Field returns null", () {
      var result = PasswordFieldValidator.validate("123456");
      expect(result, null);
    });
    test("Empty Confirm Password Field returns Error String", () {
      var result = ConfirmPasswordFieldValidator.validate("");
      expect(result, "Confirm Password Field can\'t be empty");
    });
    test("Filled Confirm Password Field returns null", () {
      var result = ConfirmPasswordFieldValidator.validate("123456");
      expect(result, null);
    });
    test("Empty Question Answer Field returns Error String", () {
      var result = QuestionAnswerFieldValidator.validate("");
      expect(result, "Question Answer Field can\'t be empty");
    });
    test("Filled Question Answer Field returns null", () {
      var result = EmailFieldValidator.validate("egypt");
      expect(result, null);
    });
    test("Empty Age Field returns Error String", () {
      var result = AgeFieldValidator.validate("");
      expect(result, "Age Field can\'t be empty");
    });
    test("Filled Age Field returns null", () {
      var result = AgeFieldValidator.validate("2");
      expect(result, null);
    });
    test("Empty Country Field returns Error String", () {
      var result = CountryFieldValidator.validate("");
      expect(result, "Country Field can\'t be empty");
    });
    test("Filled Country Field returns null", () {
      var result = CountryFieldValidator.validate("Egypt");
      expect(result, null);
    });
  });
}
