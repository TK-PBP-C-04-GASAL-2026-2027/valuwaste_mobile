// Halaman sementara Modul 1 (Jeudi). Ganti isi build() dengan halaman aslinya.
import 'package:flutter/material.dart';

import '../../../core/widgets/module_placeholder.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ModulePlaceholder(
      title: 'Profile',
      module: 'Module 1 • Auth & User Profile',
    );
  }
}
