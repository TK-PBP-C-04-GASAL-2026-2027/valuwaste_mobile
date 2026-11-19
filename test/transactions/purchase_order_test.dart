import 'package:flutter_test/flutter_test.dart';

import 'package:valuwaste_mobile/features/transactions/data/purchase_order.dart';

void main() {
  test('PurchaseOrder.fromJson membaca data dari API', () {
    final order = PurchaseOrder.fromJson({
      'code': 'RM-1024',
      'title': 'PET plastic',
      'status': 'IN_TRANSIT',
      'status_label': 'In transit',
      'quantity_kg': 300.0,
      'total': 1103670.0,
      'created_at': '2026-11-18T09:12:00+07:00',
    });

    expect(order.code, 'RM-1024');
    expect(order.statusLabel, 'In transit');
    expect(order.quantityKg, 300);
    expect(order.createdAt, isNotNull);
  });

  test('label status dipakai kalau status_label kosong', () {
    final order = PurchaseOrder.fromJson({'status': 'COMPLETED'});
    expect(order.statusLabel, 'Completed');
  });

  test('formatKg', () {
    expect(PurchaseOrder.formatKg(300), '300 kg');
    expect(PurchaseOrder.formatKg(12.5), '12.5 kg');
  });
}
