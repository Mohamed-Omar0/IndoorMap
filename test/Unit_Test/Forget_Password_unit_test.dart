import 'package:flutter_test/flutter_test.dart';
import 'package:indoor_map_application/Forget_Password.dart';

void main() {
  group("Try empty fields and non empty fields", () {
    test("Empty Email Field returns Error String", () {
      var result = EmailFieldValidator.validate("");
      expect(result, "Email Field can\'t be empty");
    });

    test("Filled Email Field returns null", () {
      var result = EmailFieldValidator.validate("admin@admin.com");
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
  });
}
