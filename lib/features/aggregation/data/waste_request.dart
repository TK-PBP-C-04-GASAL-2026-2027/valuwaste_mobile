// =============================================================================
// waste_request.dart - data satu kebutuhan limbah (Modul 4)
//
// Bentuk JSON mengikuti WasteRequestSerializer di repo web
// (aggregation/api/serializers.py). Angka kg dan rupiah dikirim sebagai
// string, misalnya "30.00", lalu diubah ke double di sini.
// =============================================================================

class WasteRequest {
  const WasteRequest({
    required this.id,
    required this.title,
    required this.categoryId,
    required this.categoryName,
    required this.targetKg,
    required this.maxPricePerKg,
    required this.notes,
    required this.status,
    required this.statusLabel,
    required this.fulfilledKg,
    required this.fulfillmentPercent,
    required this.sellerCount,
    required this.totalCost,
    required this.createdAt,
  });

  // Nilai status dari server (WasteRequest.Status di models.py).
  static const String statusOpen = 'OPEN';
  static const String statusBundled = 'BUNDLED';
  static const String statusCheckedOut = 'CHECKED_OUT';
  static const String statusCancelled = 'CANCELLED';

  /// Pilihan filter Status, sama dengan label di web.
  static const Map<String, String> statusLabels = {
    statusOpen: 'Open',
    statusBundled: 'Ready for checkout',
    statusCheckedOut: 'Checked out',
    statusCancelled: 'Cancelled',
  };

  final int id;
  final String title;
  final int categoryId;
  final String categoryName;
  final double targetKg;
  final double? maxPricePerKg;
  final String notes;
  final String status;
  final String statusLabel;
  final double fulfilledKg;
  final int fulfillmentPercent;
  final int sellerCount;
  final double totalCost;
  final DateTime? createdAt;

  factory WasteRequest.fromJson(Map<String, dynamic> json) {
    final status = json['status'] as String? ?? statusOpen;
    final label = json['status_label'] as String? ?? '';
    return WasteRequest(
      id: json['id'] as int,
      title: json['title'] as String? ?? '',
      categoryId: json['category'] as int,
      categoryName: json['category_name'] as String? ?? '',
      targetKg: _decimal(json['target_quantity_kg']),
      maxPricePerKg: json['max_price_per_kg'] == null
          ? null
          : _decimal(json['max_price_per_kg']),
      notes: json['notes'] as String? ?? '',
      status: status,
      statusLabel: label.isNotEmpty ? label : (statusLabels[status] ?? status),
      fulfilledKg: _decimal(json['fulfilled_kg']),
      fulfillmentPercent: json['fulfillment_percent'] as int? ?? 0,
      sellerCount: json['seller_count'] as int? ?? 0,
      totalCost: _decimal(json['total_cost']),
      createdAt: DateTime.tryParse(json['created_at'] as String? ?? '')
          ?.toLocal(),
    );
  }

  /// Judul yang ditampilkan: judul buyer, atau nama material kalau kosong
  /// (sama dengan web: `r.title|default:r.category`).
  String get displayTitle => title.isNotEmpty ? title : categoryName;

  bool get isClosed => status == statusCheckedOut || status == statusCancelled;

  /// Persentase untuk progress bar, dibatasi 0..1.
  double get progress => (fulfillmentPercent / 100).clamp(0.0, 1.0).toDouble();
}

/// "30.00" atau 30 -> 30.0. Nilai kosong/tidak valid -> 0.
double _decimal(Object? value) {
  if (value is num) return value.toDouble();
  if (value is String) return double.tryParse(value) ?? 0;
  return 0;
}

/// 100.0 -> "100", 12.5 -> "12.5", 12.25 -> "12.25".
String formatKg(double kg) {
  if (kg == kg.roundToDouble()) return kg.toStringAsFixed(0);
  return kg
      .toStringAsFixed(2)
      .replaceFirst(RegExp(r'0+$'), '')
      .replaceFirst(RegExp(r'\.$'), '');
}

/// 323000.0 -> "Rp 323.000" (pemisah ribuan titik, tanpa desimal).
String formatRupiah(double amount) {
  final digits = amount.round().abs().toString();
  final buffer = StringBuffer();
  for (var i = 0; i < digits.length; i++) {
    if (i > 0 && (digits.length - i) % 3 == 0) buffer.write('.');
    buffer.write(digits[i]);
  }
  final sign = amount < 0 ? '-' : '';
  return 'Rp $sign$buffer';
}

const List<String> _months = [
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
  'Jul',
  'Aug',
  'Sep',
  'Oct',
  'Nov',
  'Dec',
];

/// Tanggal seperti di web ("j M Y"): 30 Oct 2026. Null -> "-".
String formatDate(DateTime? date) {
  if (date == null) return '-';
  return '${date.day} ${_months[date.month - 1]} ${date.year}';
}
