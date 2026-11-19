// =============================================================================
// module_placeholder.dart - halaman sementara untuk modul yang belum dibuat
//
// Pemilik modul cukup mengganti isi halaman di lib/features/<modul>/pages/
// dengan halaman aslinya. Navigasi di app_shell.dart tidak perlu diubah.
// =============================================================================
import 'package:flutter/material.dart';

import 'page_header.dart';
import 'vw_app_bar.dart';

class ModulePlaceholder extends StatelessWidget {
  const ModulePlaceholder({
    super.key,
    required this.title,
    required this.module,
  });

  final String title;
  final String module;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const VwAppBar(),
      body: ListView(
        padding: VwSpacing.page,
        children: [
          PageHeader(
            title: title,
            subtitle: '$module. This page is still being built.',
          ),
        ],
      ),
    );
  }
}
