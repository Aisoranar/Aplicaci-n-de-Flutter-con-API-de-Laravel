import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:api_flutter_laravel/main.dart';

void main() {
  testWidgets('Login navigation test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Verify that login screen is displayed initially.
    expect(find.text('Login'), findsOneWidget);
    expect(find.text('Create an account'), findsOneWidget);

    // Tap the "Create an account" button to navigate to the register screen.
    await tester.tap(find.text('Create an account'));
    await tester.pumpAndSettle();

    // Verify that register screen is displayed after navigating.
    expect(find.text('Register'), findsOneWidget);

    // Navigate back to the login screen.
    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();

    // Verify that login screen is displayed again after navigating back.
    expect(find.text('Login'), findsOneWidget);

    // Tap the login button to trigger the login process.
    await tester.tap(find.text('Login'));
    await tester.pumpAndSettle();

    // Verify that home screen is displayed after successful login.
    expect(find.text('Bienvenido a la pantalla de inicio'), findsOneWidget);
    expect(find.text('Cerrar Sesión'), findsOneWidget);
  });
}
