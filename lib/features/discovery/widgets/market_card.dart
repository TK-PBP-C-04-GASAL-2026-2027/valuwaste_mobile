import 'package:flutter/material.dart';
import '../../../core/theme/vw_colors.dart';
import '../models/market_item.dart';

class MarketCard extends StatelessWidget {
  final MarketItem item;
  final VoidCallback onViewMarket;

  const MarketCard({
    super.key,
    required this.item,
    required this.onViewMarket,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final vw = theme.extension<VwColors>()!;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: vw.line, width: 1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.name,
            style: theme.textTheme.titleLarge,
          ),
          const SizedBox(height: 4),
          Text(
            '${item.stockInfo} · ${item.sellerCount} sellers',
            style: theme.textTheme.bodyMedium?.copyWith(color: vw.muted),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'From / kg',
                    style: theme.textTheme.bodySmall?.copyWith(color: vw.muted),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    item.priceFormatted,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              OutlinedButton(
                onPressed: onViewMarket,
                style: OutlinedButton.styleFrom(
                  backgroundColor: vw.paper,
                  side: BorderSide(color: vw.line),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                child: const Text('View market'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}