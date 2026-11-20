import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:valuwaste_mobile/app.dart';

void main() {
  testWidgets('Demo accounts sign in locally and switch role menus', (
    tester,
  ) async {
    await tester.pumpWidget(const ValuWasteApp());
    await tester.tap(find.byTooltip('Menu'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(InkWell, 'Profile'));
    await tester.pumpAndSettle();
    final fields = find.byType(TextFormField);
    await tester.enterText(fields.first, 'seller');
    await tester.enterText(fields.last, 'wrong');
    await tester.tap(find.text('Sign in'));
    await tester.pump();
    expect(find.text('Check the demo username and password.'), findsOneWidget);

    for (final role in ['seller', 'buyer', 'admin']) {
      await tester.enterText(fields.first, role);
      await tester.enterText(fields.last, 'demo123');
      await tester.tap(find.text('Sign in'));
      await tester.pumpAndSettle();
      expect(find.text(role), findsOneWidget);
      await tester.tap(find.byTooltip('Menu'));
      await tester.pumpAndSettle();
      expect(
        find.widgetWithText(InkWell, 'Orders'),
        role == 'seller' ? findsNothing : findsOneWidget,
      );
      expect(
        find.widgetWithText(InkWell, 'My listings'),
        role == 'buyer' ? findsNothing : findsOneWidget,
      );
      await tester.tap(find.widgetWithText(InkWell, 'Profile'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Sign out'));
      await tester.pumpAndSettle();
      expect(fields, findsNWidgets(2));
    }
  });
}
