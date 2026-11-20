// =============================================================================
// aggregation_api.dart - panggilan ke REST API Modul 4 (/api/v1/aggregation/)
//
// Daftar endpoint lengkap ada di README repo web (bagian "Daftar Endpoint API").
// =============================================================================
import 'package:pbp_django_auth/pbp_django_auth.dart';

import '../../../core/network/api_client.dart';
import 'request_filters.dart';
import 'waste_request.dart';

class AggregationApi {
  const AggregationApi(this._request);

  final CookieRequest _request;

  static const String basePath = '/api/v1/aggregation';

  /// GET requests/?q=&status= -> kebutuhan milik buyer yang sedang login,
  /// terbaru dulu.
  Future<List<WasteRequest>> fetchRequests({
    RequestFilters filters = const RequestFilters(),
  }) async {
    final params = filters.apiParams;
    final query = params.isEmpty
        ? ''
        : '?${Uri(queryParameters: params).query}';
    final body = await getJson(_request, '$basePath/requests/$query');
    return _list(body).map(WasteRequest.fromJson).toList();
  }

  /// GET categories/ -> pilihan Material (data Modul 2, hanya dibaca).
  Future<List<WasteCategory>> fetchCategories() async {
    final body = await getJson(_request, '$basePath/categories/');
    return _list(body).map(WasteCategory.fromJson).toList();
  }

  static List<Map<String, dynamic>> _list(dynamic body) {
    // Cek: balasan sukses dari endpoint daftar selalu berupa list.
    if (body is! List) {
      throw const ApiException(
        'The server sent an unexpected response. Please try again later.',
      );
    }
    return body.whereType<Map<String, dynamic>>().toList();
  }
}
