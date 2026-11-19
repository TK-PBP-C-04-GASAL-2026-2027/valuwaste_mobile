// =============================================================================
// api_client.dart - cara semua modul berbicara dengan API Django
//
// Login memakai session Django lewat CookieRequest (pbp_django_auth). Setiap
// request juga membawa header X-ValuWaste-Client: mobile. Server memakai header
// ini supaya POST/PATCH/DELETE dari aplikasi tidak ditolak cek CSRF (contoh di
// repo web: aggregation/api/authentication.py).
// =============================================================================
import 'package:pbp_django_auth/pbp_django_auth.dart';

import '../config/api_config.dart';

const String mobileClientHeader = 'X-ValuWaste-Client';
const String mobileClientValue = 'mobile';

/// Dipanggil sekali di app.dart. Jangan membuat CookieRequest baru di halaman
/// lain, karena session login hanya tersimpan di objek ini.
CookieRequest createCookieRequest() {
  final request = CookieRequest();
  request.headers[mobileClientHeader] = mobileClientValue;
  return request;
}

/// Kesalahan dari API dengan pesan yang aman ditampilkan ke pengguna.
class ApiException implements Exception {
  const ApiException(this.message);

  final String message;

  @override
  String toString() => message;
}

/// GET ke API Django dan kembalikan JSON yang sudah di-decode (Map atau List).
///
/// Melempar [ApiException] kalau:
/// - server menolak dengan format error DRF {"detail": "..."}, misalnya belum
///   login atau role tidak sesuai;
/// - balasan bukan JSON (misalnya halaman error HTML);
/// - server tidak bisa dihubungi.
Future<dynamic> getJson(CookieRequest request, String path) async {
  dynamic body;
  try {
    body = await request.get(ApiConfig.url(path));
  } on FormatException {
    throw const ApiException(
      'The server sent an unexpected response. Please try again later.',
    );
  } catch (_) {
    throw const ApiException(
      'Cannot reach the server. Check your internet connection.',
    );
  }
  // Cek: format error DRF -> tampilkan pesannya.
  if (body is Map && body['detail'] is String) {
    throw ApiException(body['detail'] as String);
  }
  return body;
}
