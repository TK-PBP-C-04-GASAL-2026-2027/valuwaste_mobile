// =============================================================================
// app_shell.dart - kerangka navigasi: top bar + panel menu (desain web)
//
// Mengikuti Figma lama (Mobile 390): tidak ada nav bawah. Setiap halaman punya
// top bar hijau tinta dengan tombol menu di kanan; tombol itu membuka panel
// menu (lihat app_menu.dart).
//
// Label menu memakai nama dari Figma lama. Figma punya menu Buyer (Dashboard,
// Community market, Orders, Transactions, Profile) dan Seller (Dashboard,
// My listings, Add listing, Transactions, Profile). Selama login (Modul 1)
// belum ada, menu memuat semua halaman modul yang sudah ada:
//   Community market -> Modul 3   My listings  -> Modul 2
//   Orders           -> Modul 4 (di Figma D13, Waste requests ada di Orders)
//   Transactions     -> Modul 5   Profile      -> Modul 1
// Setelah login ada, tampilkan menu Buyer atau Seller sesuai peran.
//
// Satu halaman per modul. Halaman ada di folder modulnya sendiri
// (lib/features/<modul>/pages/), jadi pemilik modul tidak perlu mengubah file
// ini. Halaman dibangun saat pertama dibuka lalu disimpan (posisi scroll tidak
// hilang saat pindah halaman).
//
// Pola halaman modul:
//   Scaffold(
//     appBar: const VwAppBar(),
//     body: ListView(padding: VwSpacing.page, children: [
//       const PageHeader(title: 'Seller dashboard', subtitle: '...'),
//       ...
//     ]),
//   )
// =============================================================================
import 'package:flutter/material.dart';

import '../../features/aggregation/pages/requests_page.dart';
import '../../features/auth/pages/profile_page.dart';
import '../../features/discovery/pages/market_page.dart';
import '../../features/listings/pages/listings_page.dart';
import '../../features/transactions/pages/orders_page.dart';
import 'app_menu.dart';
import 'shell_scope.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _ShellPage {
  const _ShellPage({required this.label, required this.page});

  final String label;
  final Widget page;
}

class _AppShellState extends State<AppShell> {
  late final List<_ShellPage> _pages = [
    _ShellPage(label: 'Community market', page: MarketPage()),
    _ShellPage(label: 'My listings', page: ListingsPage()),
    _ShellPage(label: 'Orders', page: RequestsPage()),
    _ShellPage(label: 'Transactions', page: OrdersPage()),
    _ShellPage(
      label: 'Profile',
      page: ProfilePage(onSessionChanged: _resetAccountPages),
    ),
  ];

  int _index = 0;
  final Set<int> _opened = {0};

  DemoAccount? _role;

  void _resetAccountPages(DemoAccount? role) {
    setState(() {
      _role = role;
      _opened.removeWhere((index) => index != 4);
      _opened.add(_index);
    });
  }

  void _select(int index) {
    setState(() {
      _index = index;
      _opened.add(index);
    });
  }

  void _openMenu() {
    showAppMenu(
      context,
      items: [
        for (var i = 0; i < _pages.length; i++)
          if (!(i == 1 && _role == DemoAccount.buyer) &&
              !(i == 2 && _role == DemoAccount.seller))
            AppMenuItem(
              label: _pages[i].label,
              selected: i == _index,
              onTap: () => _select(i),
            ),
      ],
      // Modul 1: isi aksi Sign out setelah login tersedia.
      onSignOut: null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ShellScope(
      openMenu: _openMenu,
      selectTab: _select,
      child: IndexedStack(
        index: _index,
        children: [
          for (var i = 0; i < _pages.length; i++)
            _opened.contains(i) ? _pages[i].page : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
