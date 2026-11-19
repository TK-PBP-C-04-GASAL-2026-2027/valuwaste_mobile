// =============================================================================
// page_header.dart - judul halaman + keterangan, dan ukuran jarak bersama
//
// Mengikuti Figma lama: judul Medium 30 (tracking -2%), keterangan Regular 14
// warna muted, jarak 16. Konten halaman berjarak 20 kiri-kanan dan 24 atas.
//
//   ListView(
//     padding: VwSpacing.page,
//     children: const [
//       PageHeader(title: 'Seller dashboard',
//           subtitle: 'Inventory, sales, and earnings at a glance.'),
//     ],
//   )
// =============================================================================
import 'package:flutter/material.dart';

class VwSpacing {
  const VwSpacing._();

  /// Padding isi halaman: 20 kiri-kanan, 24 atas-bawah.
  static const EdgeInsets page = EdgeInsets.fromLTRB(20, 24, 20, 24);

  /// Jarak antar blok di dalam halaman.
  static const double gap = 16;
}

class PageHeader extends StatelessWidget {
  const PageHeader({super.key, required this.title, this.subtitle});

  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final detail = subtitle;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Semantics(
          header: true,
          child: Text(title, style: theme.textTheme.headlineMedium),
        ),
        if (detail != null) ...[
          const SizedBox(height: VwSpacing.gap),
          Text(
            detail,
            style: theme.textTheme.bodyMedium?.copyWith(
              height: 19 / 14,
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ],
    );
  }
}

/// Field dengan label di atasnya (komponen "Input Field" di Figma lama):
/// label Regular 16, jarak 8, lalu input kertas bergaris.
class LabeledField extends StatelessWidget {
  const LabeledField({super.key, required this.label, required this.child});

  final String label;

  /// Biasanya TextField / TextFormField / DropdownButtonFormField.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(label, style: Theme.of(context).textTheme.bodyLarge),
        const SizedBox(height: 8),
        child,
      ],
    );
  }
}
