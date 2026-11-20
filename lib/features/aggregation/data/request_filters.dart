// =============================================================================
// request_filters.dart - filter daftar Waste requests (sama dengan web)
//
// Web: aggregation/forms.py RequestFilterForm + queries.py filtered_requests.
// Search dan Status dikirim ke API (?q=&status=). Material dan Supply belum
// didukung API, jadi disaring di aplikasi dengan aturan yang sama dengan web.
// =============================================================================
import 'waste_request.dart';

class WasteCategory {
  const WasteCategory({required this.id, required this.name});

  factory WasteCategory.fromJson(Map<String, dynamic> json) =>
      WasteCategory(id: json['id'] as int, name: json['name'] as String? ?? '');

  final int id;
  final String name;
}

/// Pilihan "Supply" (fulfilment) di web.
enum SupplyFilter {
  complete('Fulfilled'),
  partial('Partially fulfilled'),
  empty('No supply');

  const SupplyFilter(this.label);

  final String label;

  bool matches(WasteRequest request) {
    final supplied = request.fulfilledKg;
    return switch (this) {
      SupplyFilter.complete => supplied >= request.targetKg,
      SupplyFilter.partial => supplied > 0 && supplied < request.targetKg,
      SupplyFilter.empty => supplied == 0,
    };
  }
}

class RequestFilters {
  const RequestFilters({
    this.query = '',
    this.status,
    this.categoryId,
    this.supply,
  });

  final String query;
  final String? status;
  final int? categoryId;
  final SupplyFilter? supply;

  bool get isEmpty =>
      query.trim().isEmpty &&
      status == null &&
      categoryId == null &&
      supply == null;

  /// Query string untuk GET /api/v1/aggregation/requests/.
  Map<String, String> get apiParams => {
    if (query.trim().isNotEmpty) 'q': query.trim(),
    'status': ?status,
  };

  /// Saringan yang belum didukung API (Material, Supply).
  List<WasteRequest> applyLocal(List<WasteRequest> requests) {
    return requests
        .where((r) => categoryId == null || r.categoryId == categoryId)
        .where((r) => supply == null || supply!.matches(r))
        .toList();
  }
}
