// =============================================================================
// app.dart - akar aplikasi: session Django, tema, dan kerangka navigasi
// =============================================================================
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

import 'core/navigation/app_shell.dart';
import 'core/network/api_client.dart';
import 'core/theme/app_theme.dart';

class ValuWasteApp extends StatelessWidget {
  const ValuWasteApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Satu CookieRequest untuk seluruh aplikasi, jadi session login Django
    // dipakai bersama oleh semua modul. Ambil di halaman mana pun dengan
    // context.read<CookieRequest>() atau context.watch<CookieRequest>().
    return Provider<CookieRequest>(
      create: (_) => createCookieRequest(),
      child: MaterialApp(
        title: 'ValuWaste',
        debugShowCheckedModeBanner: false,
        // Desain web ValuWaste hanya punya tampilan terang.
        theme: AppTheme.light(),
        themeMode: ThemeMode.light,
        home: const AppShell(),
      ),
    );
  }
}
