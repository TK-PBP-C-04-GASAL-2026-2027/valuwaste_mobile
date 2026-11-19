// =============================================================================
// purchase_order.dart - satu pesanan dari API Modul 5 (/api/v1/transactions/)
// =============================================================================

class PurchaseOrder {
  const PurchaseOrder({
    required this.code,
    required this.title,
    required this.status,
    required this.statusLabel,
    required this.quantityKg,
    required this.total,
    this.createdAt,
  });

  factory PurchaseOrder.fromJson(Map<String, dynamic> json) {
    final status = json['status'] as String? ?? '';
    return PurchaseOrder(
      code: json['code'] as String? ?? '',
      title: json['title'] as String? ?? '',
      status: status,
      statusLabel:
          json['status_label'] as String? ?? statusLabels[status] ?? status,
      quantityKg: (json['quantity_kg'] as num?)?.toDouble() ?? 0,
      total: (json['total'] as num?)?.toDouble() ?? 0,
      createdAt: DateTime.tryParse(
        json['created_at'] as String? ?? '',
      )?.toLocal(),
    );
  }

  final String code;
  final String title;
  final String status;
  final String statusLabel;
  final double quantityKg;
  final double total;
  final DateTime? createdAt;

  /// Label status, sama dengan PurchaseOrder.Status di Django.
  static const Map<String, String> statusLabels = {
    'PLACED': 'Awaiting confirmation',
    'CONFIRMED': 'Seller confirmed',
    'READY': 'Ready for pickup',
    'IN_TRANSIT': 'In transit',
    'AWAITING_PAYMENT': 'Awaiting payment',
    'COMPLETED': 'Completed',
    'CANCELLED': 'Cancelled',
  };

  /// 300 -> "300 kg", 12.5 -> "12.5 kg".
  static String formatKg(double kg) {
    final text = kg == kg.roundToDouble()
        ? kg.toStringAsFixed(0)
        : kg.toStringAsFixed(1);
    return '$text kg';
  }
}
