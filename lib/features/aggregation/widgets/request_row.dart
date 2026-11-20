// =============================================================================
// request_row.dart - satu baris di daftar Waste requests
//
// Figma lama D13 "Waste Requests": kolom Request / Fulfilled / Status / Created
// disusun bertumpuk untuk layar HP. Garis bawah #D6DBC4, padding 16.
// - Judul SemiBold 15, material Regular 13 muted (jarak 4).
// - "150 / 150 kg" SemiBold 14 + bar 6 px (track #D6DBC4, isi lime), jarak 8.
// - Pil status (SemiBold 12, radius penuh) dan tanggal dibuat Regular 13 muted.
// =============================================================================
import 'package:flutter/material.dart';

import '../data/waste_request.dart';

const Color _rowLine = Color(0xFFD6DBC4);
const Color _barTrack = Color(0xFFD6DBC4);
const Color _lime = Color(0xFFB9ED83);
const Color _head = Color(0xFFE1EBCB);
const Color _text = Color(0xFF132B20);
const Color _muted = Color(0xFF66745E);

class RequestRow extends StatelessWidget {
  const RequestRow({super.key, required this.request});

  final WasteRequest request;

  @override
  Widget build(BuildContext context) {
    const mutedSmall = TextStyle(
      fontSize: 13,
      height: 17 / 13,
      color: _muted,
    );
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: _rowLine)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            request.displayTitle,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 15,
              height: 20 / 15,
              fontWeight: FontWeight.w600,
              color: _text,
            ),
          ),
          const SizedBox(height: 4),
          Text(request.categoryName, style: mutedSmall),
          const SizedBox(height: 12),
          Text(
            '${formatKg(request.fulfilledKg)} / ${formatKg(request.targetKg)} kg',
            style: const TextStyle(
              fontSize: 14,
              height: 18 / 14,
              fontWeight: FontWeight.w600,
              color: _text,
            ),
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(3),
            child: LinearProgressIndicator(
              value: request.progress,
              minHeight: 6,
              color: _lime,
              backgroundColor: _barTrack,
              semanticsLabel: 'Fulfilled',
              semanticsValue: '${request.fulfillmentPercent}%',
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              StatusPill(request: request),
              const Spacer(),
              Text(formatDate(request.createdAt), style: mutedSmall),
            ],
          ),
        ],
      ),
    );
  }
}

/// Pil status. Warna Open dan Ready for checkout dari Figma lama; Checked out
/// dan Cancelled dari CSS web (aggregation.css .agg-status--*).
class StatusPill extends StatelessWidget {
  const StatusPill({super.key, required this.request});

  final WasteRequest request;

  @override
  Widget build(BuildContext context) {
    final (Color background, Color foreground) = switch (request.status) {
      WasteRequest.statusBundled => (_lime, _text),
      WasteRequest.statusCheckedOut => (const Color(0xFFE4E2CF), _muted),
      WasteRequest.statusCancelled => (
        const Color(0xFFF3D9CF),
        const Color(0xFF7D2A13),
      ),
      _ => (_head, _text),
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        request.statusLabel,
        style: TextStyle(
          fontSize: 12,
          height: 16 / 12,
          fontWeight: FontWeight.w600,
          color: foreground,
        ),
      ),
    );
  }
}
