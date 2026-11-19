// =============================================================================
// vw_colors.dart - warna desain web yang tidak punya tempat di ColorScheme
//
// Contoh:
//   final vw = Theme.of(context).extension<VwColors>()!;
//   Container(color: vw.ink);                 // kartu statistik gelap
//   Text('128 kg', style: TextStyle(color: vw.lime));
// =============================================================================
import 'package:flutter/material.dart';

import 'app_colors.dart';

@immutable
class VwColors extends ThemeExtension<VwColors> {
  const VwColors({
    required this.ink,
    required this.ink2,
    required this.paper,
    required this.head,
    required this.line,
    required this.muted,
    required this.lime,
    required this.amber,
    required this.amberTint,
    required this.supplySegments,
  });

  final Color ink;
  final Color ink2;
  final Color paper;
  final Color head;
  final Color line;
  final Color muted;
  final Color lime;
  final Color amber;
  final Color amberTint;
  final List<Color> supplySegments;

  static const light = VwColors(
    ink: AppColors.ink,
    ink2: AppColors.ink2,
    paper: AppColors.paper,
    head: AppColors.head,
    line: AppColors.line,
    muted: AppColors.muted,
    lime: AppColors.lime,
    amber: AppColors.amber,
    amberTint: AppColors.amberTint,
    supplySegments: AppColors.supply,
  );

  @override
  VwColors copyWith({
    Color? ink,
    Color? ink2,
    Color? paper,
    Color? head,
    Color? line,
    Color? muted,
    Color? lime,
    Color? amber,
    Color? amberTint,
    List<Color>? supplySegments,
  }) {
    return VwColors(
      ink: ink ?? this.ink,
      ink2: ink2 ?? this.ink2,
      paper: paper ?? this.paper,
      head: head ?? this.head,
      line: line ?? this.line,
      muted: muted ?? this.muted,
      lime: lime ?? this.lime,
      amber: amber ?? this.amber,
      amberTint: amberTint ?? this.amberTint,
      supplySegments: supplySegments ?? this.supplySegments,
    );
  }

  @override
  VwColors lerp(VwColors? other, double t) {
    if (other == null) return this;
    Color mix(Color a, Color b) => Color.lerp(a, b, t)!;
    return VwColors(
      ink: mix(ink, other.ink),
      ink2: mix(ink2, other.ink2),
      paper: mix(paper, other.paper),
      head: mix(head, other.head),
      line: mix(line, other.line),
      muted: mix(muted, other.muted),
      lime: mix(lime, other.lime),
      amber: mix(amber, other.amber),
      amberTint: mix(amberTint, other.amberTint),
      supplySegments: t < 0.5 ? supplySegments : other.supplySegments,
    );
  }
}
