// =============================================================================
// app_menu.dart - panel menu navigasi (frame "M — Buyer menu" di Figma lama)
//
// Panel kertas 350 lebar, sudut 6, bayangan lembut, padding 24. Baris atas:
// tulisan "ValuWaste" + tombol "Close ×". Di bawahnya daftar halaman
// (Regular 16, tinggi baris 45), dan "Sign out" paling bawah kalau sudah login.
// =============================================================================
import 'package:flutter/material.dart';

import '../theme/vw_colors.dart';

class AppMenuItem {
  const AppMenuItem({
    required this.label,
    required this.onTap,
    this.selected = false,
  });

  final String label;
  final VoidCallback onTap;

  /// Halaman yang sedang dibuka (hanya untuk pembaca layar, tampilannya sama).
  final bool selected;
}

/// Menampilkan panel menu di bagian atas layar, tanpa latar gelap dan tanpa
/// animasi (seperti di Figma). Ketuk di luar panel atau "Close" untuk menutup.
Future<void> showAppMenu(
  BuildContext context, {
  required List<AppMenuItem> items,
  VoidCallback? onSignOut,
}) {
  return showGeneralDialog<void>(
    context: context,
    barrierDismissible: true,
    barrierLabel: 'Close menu',
    barrierColor: Colors.transparent,
    transitionDuration: Duration.zero,
    pageBuilder: (context, animation, secondaryAnimation) =>
        _AppMenuPanel(items: items, onSignOut: onSignOut),
  );
}

class _AppMenuPanel extends StatelessWidget {
  const _AppMenuPanel({required this.items, this.onSignOut});

  final List<AppMenuItem> items;
  final VoidCallback? onSignOut;

  @override
  Widget build(BuildContext context) {
    final vw = Theme.of(context).extension<VwColors>()!;
    final text = Theme.of(context).colorScheme.onSurface;
    void close() => Navigator.of(context).pop();

    return SafeArea(
      child: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 350),
            // Bayangan dari Figma: drop shadow 0 8, blur 32, 10%.
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x1A000000),
                    offset: Offset(0, 8),
                    blurRadius: 32,
                  ),
                ],
              ),
              child: Material(
              color: vw.paper,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'ValuWaste',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: text,
                            ),
                          ),
                        ),
                        OutlinedButton(
                          onPressed: close,
                          child: const Text('Close ×'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    for (final item in items)
                      _MenuRow(
                        label: item.label,
                        selected: item.selected,
                        onTap: () {
                          close();
                          item.onTap();
                        },
                      ),
                    if (onSignOut != null)
                      _MenuRow(
                        label: 'Sign out',
                        onTap: () {
                          close();
                          onSignOut!();
                        },
                      ),
                  ],
                ),
              ),
            ),
            ),
          ),
        ),
      ),
    );
  }
}

class _MenuRow extends StatelessWidget {
  const _MenuRow({
    required this.label,
    required this.onTap,
    this.selected = false,
  });

  final String label;
  final VoidCallback onTap;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: selected,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(6),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Text(label, style: Theme.of(context).textTheme.bodyLarge),
        ),
      ),
    );
  }
}
