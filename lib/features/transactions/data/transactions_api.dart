// =============================================================================
// transactions_api.dart - panggilan ke REST API Modul 5 (/api/v1/transactions/)
// =============================================================================
import 'package:pbp_django_auth/pbp_django_auth.dart';

import '../../../core/network/api_client.dart';
import 'purchase_order.dart';

class TransactionsApi {
  const TransactionsApi(this._request);

  final CookieRequest _request;

  static const String basePath = '/api/v1/transactions';

  /// GET orders/?q=&status= -> pesanan yang boleh dilihat user yang login.
  Future<List<PurchaseOrder>> fetchOrders({
    String query = '',
    String? status,
  }) async {
    final params = <String, String>{
      if (query.trim().isNotEmpty) 'q': query.trim(),
      'status': ?status,
    };
    final suffix =
        params.isEmpty ? '' : '?${Uri(queryParameters: params).query}';
    final body = await getJson(_request, '$basePath/orders/$suffix');
    // Cek: balasan sukses selalu berupa list.
    if (body is! List) {
      throw const ApiException(
        'The server sent an unexpected response. Please try again later.',
      );
    }
    return body
        .whereType<Map<String, dynamic>>()
        .map(PurchaseOrder.fromJson)
        .toList();
  }
}
