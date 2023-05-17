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
      app.main();

      //Home Page
      await tester.pumpAndSettle(const Duration(seconds: 3));
      final button = find.byKey(Key("SignIn_page"));
      await tester.tap(button);
      await tester.pumpAndSettle();

      //Sign In Page
      expect(
          find.byWidgetPredicate((widget) => widget is SignIn), findsOneWidget);

      //detect fields
      final emailFormField = find.byKey(Key("Email"));
      final passwordFormField = find.byKey(Key("Password"));
      final signInButton = find.byKey(Key("SignIn_action"));

      //enter email data
      await tester.tap(emailFormField);
      await tester.enterText(find.byKey(Key("Email")), "admin@admin.com");
      await tester.pumpAndSettle();

      //enter password data
      await tester.tap(passwordFormField);
      await tester.enterText(passwordFormField, "123456");
      await tester.pumpAndSettle();

      //press "sign in" button
      await tester.tap(signInButton);
      await tester.pumpAndSettle();
      expect(find.byWidgetPredicate((widget) => widget is HomePage),
          findsOneWidget);

      //detect fields
      final profile = find.byKey(Key("Profile"));
      final editProfileData = find.byKey(Key("Edit_Profile_Information"));
      final phoneNumberField = find.byKey(Key("PhoneNumber"));
      final updateDataButton = find.byKey(Key("Update_Data"));
      final closeButton = find.byKey(Key("Close_Button"));

      //open drawer
      await tester.pumpAndSettle(Duration(microseconds: 200));
      await tester.tapAt(Offset(385, 50));
      await tester.pumpAndSettle();

      //go to profile
      await tester.tap(profile);
      await tester.pumpAndSettle();
      await Future.delayed(const Duration(milliseconds: 300));

      //press "Edit Phone Number or Email Address" button
      await tester.tap(editProfileData);
      await tester.pumpAndSettle();

      //enter phone number data
      await tester.tap(phoneNumberField);
      await tester.enterText(phoneNumberField, "01060");
      await tester.pumpAndSettle();

      //press "Change Data" button
      await tester.tap(updateDataButton);
      await tester.pumpAndSettle();

      //press "close" button
      await tester.tap(closeButton);
      await tester.pumpAndSettle();
    });
  });
}
