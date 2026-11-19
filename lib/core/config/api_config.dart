// =============================================================================
// api_config.dart - alamat server Django yang dipakai semua modul
//
// Default: server PWS. PWS dibuka lewat http, bukan https (sertifikat https
// PWS tidak berlaku untuk alamat ini).
//
// Untuk server lokal, jalankan dengan --dart-define:
//   flutter run --dart-define=API_BASE_URL=http://10.0.2.2:8000   (emulator Android)
//   flutter run --dart-define=API_BASE_URL=http://<IP-laptop>:8000 (HP asli, satu Wi-Fi)
// =============================================================================

class ApiConfig {
  const ApiConfig._();

  static const String baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://enrico-oscar-valuwaste.pws.cs.ui.ac.id',
  );

  /// Alamat lengkap dari path yang diawali '/', misalnya
  /// ApiConfig.url('/api/v1/aggregation/requests/').
  static String url(String path) => '$baseUrl$path';
}
