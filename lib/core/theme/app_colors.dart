// =============================================================================
// app_colors.dart - warna ValuWaste, sama dengan desain web (Figma lama)
//
// Sumber: Figma "Responsive Marketplace Screens" (bagian Mobile 390) dan
// static/css/layout.css di repo web. Krem sebagai latar, kertas untuk kartu dan
// input, hijau tinta untuk top bar dan kartu gelap, lime untuk tombol utama.
//
// Di halaman, ambil warna dari tema supaya konsisten:
//   Theme.of(context).colorScheme.surface        -> krem (latar)
//   Theme.of(context).extension<VwColors>()!.ink -> hijau tinta (top bar)
// =============================================================================
import 'package:flutter/material.dart';

class AppColors {
  const AppColors._();

  /// Top bar, kartu statistik gelap (--app-ink).
  static const ink = Color(0xFF071D15);

  /// Ikon tombol, garis saat hover/fokus, teks tab aktif.
  static const ink2 = Color(0xFF163A28);

  /// Latar halaman (--app-cream).
  static const cream = Color(0xFFF2F0DC);

  /// Kartu, input, panel menu, tombol netral (--app-paper).
  static const paper = Color(0xFFFAF9EF);

  /// Kartu terpilih, tombol nonaktif, label di kartu gelap (--app-head).
  static const head = Color(0xFFE1EBCB);

  /// Garis tepi dan pemisah baris.
  static const line = Color(0xFFCCD4BC);

  /// Teks utama.
  static const text = Color(0xFF132B20);

  /// Teks keterangan dan placeholder.
  static const muted = Color(0xFF66745E);

  /// Tombol utama dan angka penting di kartu gelap (--app-lime).
  static const lime = Color(0xFFB9ED83);

  static const danger = Color(0xFFA3361B);
  static const dangerTint = Color(0xFFF6DCD2);
  static const amber = Color(0xFF8A5A12);
  static const amberTint = Color(0xFFF6E7C8);

  /// Segmen SupplyScale per seller (--agg-seg-1..6 di web).
  static const supply = [
    Color(0xFFB9ED83),
    Color(0xFF6FAE4C),
    Color(0xFFE3F6C9),
    Color(0xFF7FC9A3),
    Color(0xFFF2F0DC),
    Color(0xFF4B8A37),
  ];
}
