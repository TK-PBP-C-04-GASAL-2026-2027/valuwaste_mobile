// =============================================================================
// orders_page.dart - halaman Transactions (Modul 5)
//
// Menu "Transactions" di app_shell.dart membuka halaman ini. Nama class
// OrdersPage jangan diganti (dipakai app_shell.dart).
//
// Data: GET /api/v1/transactions/orders/?q=&status=. Tarik ke bawah untuk
// memuat ulang.
// =============================================================================
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

import '../../../core/network/api_client.dart';
import '../../../core/widgets/page_header.dart';
import '../../../core/widgets/state_views.dart';
import '../../../core/widgets/vw_app_bar.dart';
import '../data/purchase_order.dart';
import '../data/transactions_api.dart';
import '../widgets/order_row.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  late final TransactionsApi _api = TransactionsApi(
    context.read<CookieRequest>(),
  );
  final TextEditingController _search = TextEditingController();
  String? _status;
  int _resetCount = 0;
  late Future<List<PurchaseOrder>> _future;

  @override
  void initState() {
    super.initState();
    _future = _load();
  }

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  Future<List<PurchaseOrder>> _load() =>
      _api.fetchOrders(query: _search.text, status: _status);

  Future<void> _reload() async {
    final future = _load();
    setState(() => _future = future);
    try {
      await future;
    } catch (_) {
      // Error sudah ditampilkan oleh FutureBuilder.
    }
  }

  void _reset() {
    _search.clear();
    _status = null;
    _resetCount++; // supaya dropdown Status kembali ke "All statuses"
    _reload();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const VwAppBar(),
      body: RefreshIndicator(
        onRefresh: _reload,
        child: FutureBuilder<List<PurchaseOrder>>(
          future: _future,
          builder: (context, snapshot) {
            return ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: VwSpacing.page,
              children: [
                const PageHeader(title: 'Transactions'),
                const SizedBox(height: 24),
                ..._filters(),
                const SizedBox(height: 24),
                ..._results(snapshot),
              ],
            );
          },
        ),
      ),
    );
  }

  List<Widget> _filters() {
    return [
      LabeledField(
        label: 'Search',
        child: TextField(
          controller: _search,
          textInputAction: TextInputAction.search,
          onSubmitted: (_) => _reload(),
          decoration: const InputDecoration(
            hintText: 'Order number or material',
          ),
        ),
      ),
      const SizedBox(height: 16),
      LabeledField(
        label: 'Status',
        child: DropdownButtonFormField<String?>(
          key: ValueKey(_resetCount),
          initialValue: _status,
          isExpanded: true,
          items: [
            const DropdownMenuItem(value: null, child: Text('All statuses')),
            for (final entry in PurchaseOrder.statusLabels.entries)
              DropdownMenuItem(value: entry.key, child: Text(entry.value)),
          ],
          onChanged: (value) => _status = value,
        ),
      ),
      const SizedBox(height: 16),
      Row(
        children: [
          FilledButton(onPressed: _reload, child: const Text('Apply')),
          const SizedBox(width: 12),
          OutlinedButton(onPressed: _reset, child: const Text('Reset')),
        ],
      ),
    ];
  }

  List<Widget> _results(AsyncSnapshot<List<PurchaseOrder>> snapshot) {
    if (snapshot.connectionState != ConnectionState.done) {
      return const [
        Padding(padding: EdgeInsets.only(top: 24), child: LoadingView()),
      ];
    }
    if (snapshot.hasError) {
      final error = snapshot.error;
      return [
        MessageView(
          title: "Couldn't load your orders",
          message: error is ApiException
              ? error.message
              : 'Something went wrong. Please try again.',
          actionLabel: 'Try again',
          onAction: _reload,
        ),
      ];
    }
    final orders = snapshot.data ?? const <PurchaseOrder>[];
    if (orders.isEmpty) {
      return const [
        MessageView(
          title: 'No orders yet',
          message: 'Orders placed through the marketplace appear here.',
        ),
      ];
    }
    final muted = Theme.of(context).colorScheme.onSurfaceVariant;
    return [
      Text(
        orders.length == 1 ? '1 order' : '${orders.length} orders',
        style: TextStyle(fontSize: 13, height: 17 / 13, color: muted),
      ),
      for (var i = 0; i < orders.length; i++)
        OrderRow(order: orders[i], showDivider: i < orders.length - 1),
    ];
  }
}
