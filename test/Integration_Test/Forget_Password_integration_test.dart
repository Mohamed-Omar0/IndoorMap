import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:indoor_map_application/Sign_In.dart';
import 'package:integration_test/integration_test.dart';
import 'package:indoor_map_application/main.dart' as app;

void main() {
  group("Sign in test", () {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();
    testWidgets("Sign in widget test", (WidgetTester tester) async {
      app.main();

      //Home Page
      await tester.pumpAndSettle(const Duration(seconds: 3));
      final button = find.byKey(Key("SignIn_page"));
      await tester.tap(button);
      await tester.pumpAndSettle();

      //Sign In Page
      expect(
          find.byWidgetPredicate((widget) => widget is SignIn), findsOneWidget);

      //press "Forget Password" button
      await tester.tap(find.byKey(Key("Forget_Password")));
      await tester.pumpAndSettle();

      //detect fields
      final forgetPasswordEmailField = find.byKey(Key("Forget_Password_Email"));
      final resetButton = find.byKey(Key("Reset_button"));
      final forgetPasswordquestionAnswerField =
          find.byKey(Key("Question_Answer_Field"));
      final submitButton = find.byKey(Key("submit_Button"));
      final newPasswordField = find.byKey(Key("New_Password_Field"));
      final confirmNewPasswordField =
          find.byKey(Key("Confirm_New_Password_Field"));
      final updatePasswordButton = find.byKey(Key("Update_Password_button"));
      final closebutton = find.byKey(Key("Update_Password_Done"));

      //enter email data
      await tester.tap(forgetPasswordEmailField);
      await tester.enterText(forgetPasswordEmailField, "admin@admin.com");
      await tester.pumpAndSettle();

      //press "Reset button" button
      await tester.tap(resetButton);
      await tester.pumpAndSettle();

      //enter Question Answer data
      await tester.tap(forgetPasswordquestionAnswerField);
      await tester.enterText(forgetPasswordquestionAnswerField, "egypt");
      await tester.pumpAndSettle();

      //press "Submit button" button
      await tester.tap(submitButton);
      await tester.pumpAndSettle();

      //enter new password and confirm new password data
      await tester.tap(newPasswordField);
      await tester.enterText(newPasswordField, "123456");
      await tester.pumpAndSettle();
      await tester.tap(confirmNewPasswordField);
      await tester.enterText(confirmNewPasswordField, "123456");
      await tester.pumpAndSettle();

      //press "update Password Button" button
      await tester.tap(updatePasswordButton);
      await tester.pumpAndSettle();

      ////press "close Button" button
      await tester.tap(closebutton);
      await tester.pumpAndSettle();
    });
  });
}
