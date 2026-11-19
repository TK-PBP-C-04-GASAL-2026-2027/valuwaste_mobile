// =============================================================================
// order_row.dart - satu baris pesanan
//
// Desain: Figma lama, M08 Company Dashboard, daftar "Recent purchase orders".
// Baris 1: nomor pesanan (Bold 14) + status. Baris 2: material + jumlah kg.
// Padding atas-bawah 12, jarak antar baris 6, garis bawah kecuali baris terakhir.
// =============================================================================
import 'package:flutter/material.dart';

import '../../../core/theme/vw_colors.dart';
import '../data/purchase_order.dart';

class OrderRow extends StatelessWidget {
  const OrderRow({super.key, required this.order, this.showDivider = true});

  final PurchaseOrder order;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    final vw = Theme.of(context).extension<VwColors>()!;
    final style = TextStyle(
      fontSize: 14,
      height: 20 / 14,
      color: Theme.of(context).colorScheme.onSurface,
    );
    return DecoratedBox(
      decoration: BoxDecoration(
        border: showDivider
            ? Border(bottom: BorderSide(color: vw.line))
            : null,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Column(
          children: [
            _pair(
              Text(
                '#${order.code}',
                style: style.copyWith(fontWeight: FontWeight.w700),
              ),
              Text(order.statusLabel, style: style),
            ),
            const SizedBox(height: 6),
            _pair(
              Text(
                order.title,
                style: style,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(PurchaseOrder.formatKg(order.quantityKg), style: style),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _pair(Widget left, Widget right) {
    return Row(
      children: [
        Expanded(child: left),
        const SizedBox(width: 8),
        Expanded(child: right),
      ],
    );
  }
}
