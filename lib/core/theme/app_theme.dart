// =============================================================================
// app_theme.dart - tema bersama semua modul, mengikuti desain web ValuWaste
//
// Sumber: Figma lama "Responsive Marketplace Screens" (Mobile 390 + Components).
// - Latar krem, kartu/input kertas bergaris tipis, sudut 6.
// - Top bar hijau tinta dengan tulisan "ValuWaste".
// - Tombol utama lime (teks gelap), tombol netral kertas bergaris, tinggi 44.
// - Font DM Sans (dibundel di assets/fonts).
// =============================================================================
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_colors.dart';
import 'vw_colors.dart';

class AppTheme {
  const AppTheme._();

  static const String fontFamily = 'DMSans';
  static const double radius = 6;

  static ThemeData light() {
    const scheme = ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.lime,
      onPrimary: AppColors.text,
      primaryContainer: AppColors.head,
      onPrimaryContainer: AppColors.ink2,
      secondary: AppColors.ink,
      onSecondary: AppColors.cream,
      secondaryContainer: AppColors.head,
      onSecondaryContainer: AppColors.ink2,
      error: AppColors.danger,
      onError: AppColors.paper,
      errorContainer: AppColors.dangerTint,
      onErrorContainer: AppColors.danger,
      surface: AppColors.cream,
      onSurface: AppColors.text,
      onSurfaceVariant: AppColors.muted,
      surfaceContainerLowest: AppColors.paper,
      surfaceContainerLow: AppColors.paper,
      surfaceContainer: AppColors.paper,
      surfaceContainerHigh: AppColors.head,
      surfaceContainerHighest: AppColors.head,
      outline: AppColors.line,
      outlineVariant: AppColors.line,
      inverseSurface: AppColors.ink,
      onInverseSurface: AppColors.cream,
      inversePrimary: AppColors.lime,
      scrim: AppColors.ink,
      shadow: AppColors.ink,
      surfaceTint: Colors.transparent,
    );
    return _build(scheme, VwColors.light);
  }

  static TextTheme _textTheme(ColorScheme scheme) {
    TextStyle style(
      double size,
      double lineHeight, {
      FontWeight weight = FontWeight.w400,
      double letterSpacing = 0,
    }) {
      return TextStyle(
        fontFamily: fontFamily,
        fontSize: size,
        height: lineHeight / size,
        fontWeight: weight,
        letterSpacing: letterSpacing,
        color: scheme.onSurface,
      );
    }

    return TextTheme(
      // Angka besar di kartu statistik gelap: Medium 48/56.
      displaySmall: style(48, 56, weight: FontWeight.w500),
      // Judul halaman: Medium 30, tinggi baris 112%, tracking -2%.
      headlineMedium: style(
        30,
        34,
        weight: FontWeight.w500,
        letterSpacing: -0.6,
      ),
      // Nama material / harga di kartu: Medium 24/32.
      headlineSmall: style(24, 32, weight: FontWeight.w500),
      // Judul bagian ("My inventory"): Medium 20/27.
      titleLarge: style(20, 27, weight: FontWeight.w500),
      // Judul kartu peran / item: Bold 18/24.
      titleMedium: style(18, 24, weight: FontWeight.w700),
      titleSmall: style(16, 22, weight: FontWeight.w500),
      bodyLarge: style(16, 22),
      // Isi baris daftar: Regular 14/22. Keterangan di bawah judul: 14/19.
      bodyMedium: style(14, 22),
      bodySmall: style(13, 18),
      // Teks tombol sedang: Medium 16. Tombol kecil / label filter: Medium 14.
      labelLarge: style(16, 20, weight: FontWeight.w500),
      labelMedium: style(14, 18, weight: FontWeight.w500),
      labelSmall: style(12, 16),
    );
  }

  static ThemeData _build(ColorScheme scheme, VwColors vw) {
    final textTheme = _textTheme(scheme);
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(radius),
    );
    final buttonText = textTheme.labelLarge;
    const buttonPadding = EdgeInsets.symmetric(horizontal: 16, vertical: 12);
    const buttonSize = Size(64, 44);
    OutlineInputBorder inputBorder(Color color, [double width = 1]) =>
        OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: BorderSide(color: color, width: width),
        );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: scheme,
      fontFamily: fontFamily,
      textTheme: textTheme,
      extensions: [vw],
      scaffoldBackgroundColor: scheme.surface,
      canvasColor: scheme.surface,
      dividerColor: vw.line,
      splashFactory: InkRipple.splashFactory,

      // Top bar: hijau tinta, tinggi 64, tulisan "ValuWaste" Bold 20 krem.
      appBarTheme: AppBarThemeData(
        backgroundColor: vw.ink,
        foregroundColor: scheme.onSecondary,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        toolbarHeight: 64,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        titleTextStyle: TextStyle(
          fontFamily: fontFamily,
          fontSize: 20,
          height: 27 / 20,
          fontWeight: FontWeight.w700,
          color: scheme.onSecondary,
        ),
      ),

      // Kartu kertas bergaris tipis, sudut 6, tanpa bayangan.
      cardTheme: CardThemeData(
        color: vw.paper,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
          side: BorderSide(color: vw.line),
        ),
      ),

      // Tombol utama (Primary): lime, teks gelap Medium 16, tinggi 44.
      // Ditekan/hover: tetap lime + garis #163A28 (state Hover di Figma).
      // Nonaktif: head + teks muted.
      filledButtonTheme: FilledButtonThemeData(
        style:
            FilledButton.styleFrom(
              minimumSize: buttonSize,
              padding: buttonPadding,
              shape: shape,
              textStyle: buttonText,
              foregroundColor: scheme.onPrimary,
              disabledForegroundColor: vw.muted,
              backgroundColor: vw.lime,
              disabledBackgroundColor: vw.head,
            ).copyWith(
              side: WidgetStateProperty.resolveWith(
                (states) =>
                    states.contains(WidgetState.pressed) ||
                        states.contains(WidgetState.hovered)
                    ? BorderSide(color: vw.ink2)
                    : BorderSide.none,
              ),
            ),
      ),

      // Tombol netral (Neutral): kertas bergaris, teks gelap.
      // Ditekan/hover: head + garis #163A28 (state Hover di Figma).
      outlinedButtonTheme: OutlinedButtonThemeData(
        style:
            OutlinedButton.styleFrom(
              minimumSize: buttonSize,
              padding: buttonPadding,
              shape: shape,
              textStyle: buttonText,
              foregroundColor: scheme.onSurface,
              disabledForegroundColor: vw.muted,
            ).copyWith(
              backgroundColor: WidgetStateProperty.resolveWith(
                (states) =>
                    states.contains(WidgetState.pressed) ||
                        states.contains(WidgetState.hovered)
                    ? vw.head
                    : vw.paper,
              ),
              side: WidgetStateProperty.resolveWith(
                (states) =>
                    states.contains(WidgetState.pressed) ||
                        states.contains(WidgetState.hovered)
                    ? BorderSide(color: vw.ink2)
                    : BorderSide(color: vw.line),
              ),
            ),
      ),

      // Tombol halus (Subtle): tanpa latar, teks gelap.
      // Ditekan/hover: garis #163A28 (state Hover di Figma).
      textButtonTheme: TextButtonThemeData(
        style:
            TextButton.styleFrom(
              minimumSize: buttonSize,
              padding: buttonPadding,
              shape: shape,
              textStyle: buttonText,
              foregroundColor: scheme.onSurface,
              disabledForegroundColor: vw.muted,
            ).copyWith(
              side: WidgetStateProperty.resolveWith(
                (states) =>
                    states.contains(WidgetState.pressed) ||
                        states.contains(WidgetState.hovered)
                    ? BorderSide(color: vw.ink2)
                    : BorderSide.none,
              ),
            ),
      ),

      // Input: kertas, garis tipis, sudut 6, padding kiri-kanan 16.
      // Label ditulis di atas field (lihat LabeledField), bukan di dalamnya.
      inputDecorationTheme: InputDecorationThemeData(
        filled: true,
        fillColor: vw.paper,
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 11,
        ),
        hintStyle: textTheme.bodyLarge?.copyWith(color: vw.muted),
        prefixIconColor: vw.muted,
        suffixIconColor: vw.muted,
        border: inputBorder(vw.line),
        enabledBorder: inputBorder(vw.line),
        disabledBorder: inputBorder(vw.line),
        // Fokus: garis #163A28 1 px, bahasa yang sama dengan state Hover.
        focusedBorder: inputBorder(vw.ink2),
        errorBorder: inputBorder(scheme.error),
        focusedErrorBorder: inputBorder(scheme.error),
      ),

      // Chip: kertas bergaris; terpilih head + garis tinta.
      chipTheme: ChipThemeData(
        color: WidgetStateProperty.resolveWith(
          (states) =>
              states.contains(WidgetState.selected) ? vw.head : vw.paper,
        ),
        labelStyle: TextStyle(
          fontFamily: fontFamily,
          fontSize: 14,
          height: 18 / 14,
          fontWeight: FontWeight.w500,
          color: scheme.onSurface,
        ),
        side: WidgetStateBorderSide.resolveWith(
          (states) => BorderSide(
            color: states.contains(WidgetState.selected) ? vw.ink2 : vw.line,
          ),
        ),
        shape: shape,
        showCheckmark: false,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      ),

      dividerTheme: DividerThemeData(color: vw.line, thickness: 1, space: 1),

      dialogTheme: DialogThemeData(
        backgroundColor: vw.paper,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        shape: shape,
        titleTextStyle: textTheme.titleLarge,
        contentTextStyle: textTheme.bodyMedium?.copyWith(color: vw.muted),
      ),

      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: vw.paper,
        modalBackgroundColor: vw.paper,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        modalElevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(radius)),
        ),
      ),

      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: vw.ink,
        actionTextColor: vw.lime,
        contentTextStyle: textTheme.bodyMedium?.copyWith(
          color: scheme.onSecondary,
        ),
        elevation: 0,
        shape: shape,
      ),

      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: vw.ink2,
        linearTrackColor: vw.head,
        circularTrackColor: Colors.transparent,
      ),
    );
  }
}
