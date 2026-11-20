import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:valuwaste_mobile/features/aggregation/data/request_filters.dart';
import 'package:valuwaste_mobile/features/aggregation/data/waste_request.dart';
import 'package:valuwaste_mobile/features/aggregation/widgets/request_row.dart';

WasteRequest _request({
  int id = 1,
  String title = 'PET flakes for November production',
  int category = 1,
  String categoryName = 'PET Plastic',
  String target = '150.00',
  String fulfilled = '0.00',
  int percent = 0,
  String status = 'OPEN',
}) {
  return WasteRequest.fromJson({
    'id': id,
    'title': title,
    'category': category,
    'category_name': categoryName,
    'target_quantity_kg': target,
    'max_price_per_kg': null,
    'notes': '',
    'status': status,
    'status_label': '',
    'fulfilled_kg': fulfilled,
    'fulfillment_percent': percent,
    'seller_count': 0,
    'total_cost': '0.00',
    'created_at': '2026-10-30T10:00:00+07:00',
  });
}

void main() {
  group('WasteRequest.fromJson', () {
    test('reads the list item sent by /api/v1/aggregation/requests/', () {
      final request = WasteRequest.fromJson({
        'id': 7,
        'title': 'Clear PET October',
        'category': 1,
        'category_name': 'PET',
        'target_quantity_kg': '100.00',
        'max_price_per_kg': '3500.00',
        'notes': '',
        'status': 'BUNDLED',
        'status_label': 'Ready for checkout',
        'fulfilled_kg': '70.00',
        'fulfillment_percent': 70,
        'seller_count': 2,
        'total_cost': '224000.00',
        'created_at': '2026-11-18T10:00:00+07:00',
        'updated_at': '2026-11-18T10:00:00+07:00',
      });

      expect(request.id, 7);
      expect(request.categoryName, 'PET');
      expect(request.targetKg, 100);
      expect(request.maxPricePerKg, 3500);
      expect(request.fulfilledKg, 70);
      expect(request.progress, 0.7);
      expect(request.sellerCount, 2);
      expect(request.totalCost, 224000);
      expect(request.statusLabel, 'Ready for checkout');
      expect(request.createdAt, isNotNull);
      expect(request.isClosed, isFalse);
    });

    test('falls back to the material name and the known status label', () {
      final request = _request(title: '', status: 'CANCELLED');

      expect(request.displayTitle, 'PET Plastic');
      expect(request.statusLabel, 'Cancelled');
      expect(request.maxPricePerKg, isNull);
      expect(request.isClosed, isTrue);
    });
  });

  group('formatting', () {
    test('formatKg drops trailing zeros', () {
      expect(formatKg(100), '100');
      expect(formatKg(12.5), '12.5');
      expect(formatKg(12.25), '12.25');
    });

    test('formatRupiah uses dots as thousand separators', () {
      expect(formatRupiah(0), 'Rp 0');
      expect(formatRupiah(323000), 'Rp 323.000');
      expect(formatRupiah(1250000), 'Rp 1.250.000');
    });

    test('formatDate matches the web (j M Y)', () {
      expect(formatDate(DateTime(2026, 10, 30)), '30 Oct 2026');
      expect(formatDate(null), '-');
    });
  });

  group('RequestFilters', () {
    final full = _request(id: 1, fulfilled: '150.00', percent: 100);
    final partial = _request(id: 2, category: 2, fulfilled: '40.00');
    final empty = _request(id: 3, category: 2);
    final all = [full, partial, empty];

    test('only sends search and status to the API', () {
      const filters = RequestFilters(
        query: '  pet ',
        status: 'OPEN',
        categoryId: 2,
        supply: SupplyFilter.partial,
      );
      expect(filters.apiParams, {'q': 'pet', 'status': 'OPEN'});
      expect(const RequestFilters().isEmpty, isTrue);
    });

    test('filters material and supply the same way as the web', () {
      expect(
        const RequestFilters(categoryId: 2).applyLocal(all).map((r) => r.id),
        [2, 3],
      );
      expect(
        const RequestFilters(
          supply: SupplyFilter.complete,
        ).applyLocal(all).map((r) => r.id),
        [1],
      );
      expect(
        const RequestFilters(
          supply: SupplyFilter.partial,
        ).applyLocal(all).map((r) => r.id),
        [2],
      );
      expect(
        const RequestFilters(
          supply: SupplyFilter.empty,
        ).applyLocal(all).map((r) => r.id),
        [3],
      );
    });
  });

  testWidgets('RequestRow shows title, material, fulfilled, status and date', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: RequestRow(
            request: _request(fulfilled: '150.00', percent: 100, status: 'BUNDLED'),
          ),
        ),
      ),
    );

    expect(find.text('PET flakes for November production'), findsOneWidget);
    expect(find.text('PET Plastic'), findsOneWidget);
    expect(find.text('150 / 150 kg'), findsOneWidget);
    expect(find.text('Ready for checkout'), findsOneWidget);
    expect(find.text('30 Oct 2026'), findsOneWidget);
  });
}
