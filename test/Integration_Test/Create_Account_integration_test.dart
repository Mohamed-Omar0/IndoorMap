import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:indoor_map_application/Home_Page.dart';
import 'package:indoor_map_application/Sign_In.dart';
import 'package:integration_test/integration_test.dart';
import 'package:indoor_map_application/main.dart' as app;

void main() {
  group("Sign in test", () {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();
    testWidgets("Sign in widget test", (WidgetTester tester) async {
      await tester.runAsync(() async {
        app.main();

        //Home Page
        await tester.pumpAndSettle(const Duration(seconds: 3));
        final button = find.byKey(Key("SignIn_page"));
        await tester.tap(button);
        await tester.pumpAndSettle();

        //Sign In Page
        expect(find.byWidgetPredicate((widget) => widget is SignIn),
            findsOneWidget);

        //press "Create Account" button
        await tester.tap(find.byKey(Key("Create_Account")));
        await tester.pumpAndSettle();

        //detect fields
        final firstNameField = find.byKey(Key("First_Name_Field"));
        final secondNameField = find.byKey(Key("Second_Name_Field"));
        final emailField = find.byKey(Key("Email_Field"));
        final confirmEmailField = find.byKey(Key("Confirm_Email_Field"));
        final passwordField = find.byKey(Key("Password_Field"));
        final confirmPasswordField = find.byKey(Key("Confirm_Password_Field"));
        final securityQuestionMenu = find.byKey(Key("Security_Question_Menu"));
        final questionAnswerField = find.byKey(Key("Security_Question_Field"));
        final ageField = find.byKey(Key("Age_Field"));
        final countryField = find.byKey(Key("Country_Field"));

        //enter First Name data
        await tester.tap(firstNameField);
        await tester.enterText(firstNameField, "Mohamed");
        await tester.pumpAndSettle();

        //enter Second Name data
        await tester.tap(secondNameField);
        await tester.enterText(secondNameField, "Omar");
        await tester.pumpAndSettle();

        //enter email data
        await tester.flingFrom(Offset(200, 200), Offset(0, -300), 500);
        await tester.tap(emailField);
        await tester.enterText(emailField, "moh@hotmail.com");
        await tester.pumpAndSettle();

        //enter confirm email data
        await tester.tap(confirmEmailField);
        await tester.enterText(confirmEmailField, "moh@hotmail.com");
        await tester.pumpAndSettle();

        //enter password data
        await tester.tap(passwordField);
        await tester.enterText(passwordField, "123");
        await tester.pumpAndSettle();

        //enter confirm password data
        await tester.tap(confirmPasswordField);
        await tester.enterText(confirmPasswordField, "123");
        await tester.pumpAndSettle();

        //choose security question from menu
        await tester.tap(securityQuestionMenu);
        await tester.pumpAndSettle();
        await Future.delayed(const Duration(milliseconds: 200));
        await tester.tapAt(Offset(50, 350));
        await tester.pumpAndSettle();

        //enter Security Question data
        await tester.tap(questionAnswerField);
        await tester.enterText(questionAnswerField, "Egypt");
        await tester.flingFrom(Offset(200, 400), Offset(0, -500), 500);
        await tester.pumpAndSettle();

        //enter age data
        await tester.tap(ageField);
        await tester.enterText(ageField, "21");
        await tester.pumpAndSettle();

        //enter country data
        await tester.tap(countryField);
        await tester.enterText(countryField, "Egypt");
        await tester.pumpAndSettle();

        //press "Sign Up" button
        await tester.flingFrom(Offset(200, 400), Offset(0, -500), 500);
        await tester.tap(find.byKey(Key("Create_Account")));
        await tester.pumpAndSettle();

        //press "Not Now" button
        await tester.tap(find.byKey(Key("Create_Account_Done")));
        await tester.pumpAndSettle();

        expect(find.byWidgetPredicate((widget) => widget is HomePage),
            findsOneWidget);
        await Future.delayed(const Duration(seconds: 1));
      });
    });
  });
}
