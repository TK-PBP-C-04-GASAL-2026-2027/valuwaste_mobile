// =============================================================================
// vw_app_bar.dart - top bar ValuWaste (frame "Mobile top bar" di Figma lama)
//
// Hijau tinta, tinggi 64, padding 16: tulisan "ValuWaste" Bold 20 krem di
// kiri, tombol menu kotak 40 di kanan (krem, garis #CCD4BC 1 px, sudut 6)
// berisi ikon menu dari Figma: tiga garis 13,3 x 11,7, tebal 2, ujung bulat,
// warna #163A28, di tengah kotak 20.
//
// Pakai di setiap halaman: appBar: const VwAppBar(),
// =============================================================================
import 'package:flutter/material.dart';

import '../navigation/shell_scope.dart';
import '../theme/vw_colors.dart';

class VwAppBar extends StatelessWidget implements PreferredSizeWidget {
  const VwAppBar({super.key});

  static const double height = 64;

  @override
  Size get preferredSize => const Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    final shell = ShellScope.maybeOf(context);
    return AppBar(
      toolbarHeight: height,
      automaticallyImplyLeading: false,
      titleSpacing: 16,
      title: const Text('ValuWaste'),
      actions: [
        if (shell != null) ...[
          _MenuButton(onPressed: shell.openMenu),
          const SizedBox(width: 16),
        ],
      ],
    );
  }
}

class _MenuButton extends StatelessWidget {
  const _MenuButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final vw = Theme.of(context).extension<VwColors>()!;
    final radius = BorderRadius.circular(6);
    return Tooltip(
      message: 'Menu',
      child: Material(
        color: Theme.of(context).colorScheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: radius,
          side: BorderSide(color: vw.line),
        ),
        child: InkWell(
          onTap: onPressed,
          borderRadius: radius,
          child: SizedBox(
            width: 40,
            height: 40,
            child: Center(
              child: CustomPaint(
                size: const Size(20, 20),
                painter: _MenuGlyphPainter(vw.ink2),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Vektor "menu" di Figma: tiga garis horizontal di kotak 20 x 20.
class _MenuGlyphPainter extends CustomPainter {
  const _MenuGlyphPainter(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;
    const left = 3.0;
    const right = left + 13.332;
    const top = 4.0;
    for (final dy in const [0.0, 5.834, 11.668]) {
      canvas.drawLine(
        const Offset(left, 0) + Offset(0, top + dy),
        const Offset(right, 0) + Offset(0, top + dy),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_MenuGlyphPainter oldDelegate) =>
      oldDelegate.color != color;
}
