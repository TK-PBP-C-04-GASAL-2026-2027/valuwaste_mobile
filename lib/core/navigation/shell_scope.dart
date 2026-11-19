// =============================================================================
// shell_scope.dart - jalan pintas ke kerangka navigasi dari halaman mana pun
//
// Halaman modul punya Scaffold sendiri. ShellScope meneruskan perintah
// "buka menu" dan "pindah halaman" supaya halaman tidak perlu tahu isi
// AppShell. VwAppBar memakainya untuk tombol menu.
// =============================================================================
import 'package:flutter/widgets.dart';

class ShellScope extends InheritedWidget {
  const ShellScope({
    super.key,
    required this.openMenu,
    required this.selectTab,
    required super.child,
  });

  /// Membuka panel menu navigasi (desain "Buyer menu" / "Seller menu").
  final VoidCallback openMenu;

  /// Pindah ke halaman utama ke-[index]: 0 Community market, 1 My listings,
  /// 2 Orders (Waste requests), 3 Transactions, 4 Profile.
  final ValueChanged<int> selectTab;

  /// Null kalau halaman dibuka di luar AppShell (misalnya di test).
  static ShellScope? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<ShellScope>();

  @override
  bool updateShouldNotify(ShellScope oldWidget) => false;
}
