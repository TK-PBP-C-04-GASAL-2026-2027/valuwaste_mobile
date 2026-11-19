import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:valuwaste_mobile/app.dart';
import 'package:valuwaste_mobile/core/widgets/page_header.dart';

Finder pageTitle(String text) =>
    find.descendant(of: find.byType(PageHeader), matching: find.text(text));

void main() {
  testWidgets('App opens on Community market with the ValuWaste top bar', (
    tester,
  ) async {
    await tester.pumpWidget(const ValuWasteApp());

    expect(pageTitle('Community market'), findsOneWidget);
    expect(
      find.descendant(of: find.byType(AppBar), matching: find.text('ValuWaste')),
      findsOneWidget,
    );
  });

  testWidgets('Menu panel lists every module and switches pages', (
    tester,
  ) async {
    await tester.pumpWidget(const ValuWasteApp());

    await tester.tap(find.byTooltip('Menu'));
    await tester.pumpAndSettle();
    for (final label in [
      'Community market',
      'My listings',
      'Orders',
      'Transactions',
      'Profile',
    ]) {
      expect(find.widgetWithText(InkWell, label), findsOneWidget);
    }

    // Profile dipakai di sini karena halaman ini belum memanggil API.
    // Halaman yang memanggil API menampilkan loading terus di test, sehingga
    // pumpAndSettle tidak pernah selesai.
    await tester.tap(find.widgetWithText(InkWell, 'Profile'));
    await tester.pumpAndSettle();
    expect(pageTitle('Profile'), findsOneWidget);

    await tester.tap(find.byTooltip('Menu'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Close ×'));
    await tester.pumpAndSettle();
    expect(find.text('Close ×'), findsNothing);
    expect(pageTitle('Profile'), findsOneWidget);
  });
}
