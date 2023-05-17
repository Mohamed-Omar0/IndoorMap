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

      //sign in
      await tester.tap(signInButton);
      await tester.pumpAndSettle();
      expect(find.byWidgetPredicate((widget) => widget is HomePage),
          findsOneWidget);
      await tester.pumpAndSettle();
    });
  });
}
