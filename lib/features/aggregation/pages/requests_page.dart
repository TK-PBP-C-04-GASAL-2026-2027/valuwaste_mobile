// =============================================================================
// requests_page.dart - daftar Waste requests milik buyer (Modul 4)
//
// Desain: Figma lama "Responsive Marketplace Screens", D13 Waste Requests,
// disusun untuk layar HP (pola M03/M06). Isi sama dengan halaman web
// /aggregation/requests/: judul + keterangan, filter Search / Status /
// Material / Supply, jumlah request, lalu daftar request.
//
// Data: GET /api/v1/aggregation/requests/?q=&status= (+ GET categories/ untuk
// pilihan Material). Tarik ke bawah untuk memuat ulang.
// =============================================================================
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

import '../../../core/network/api_client.dart';
import '../../../core/widgets/page_header.dart';
import '../../../core/widgets/state_views.dart';
import '../../../core/widgets/vw_app_bar.dart';
import '../data/aggregation_api.dart';
import '../data/request_filters.dart';
import '../data/waste_request.dart';
import '../widgets/request_filter_form.dart';
import '../widgets/request_row.dart';

class RequestsPage extends StatefulWidget {
  const RequestsPage({super.key});

  @override
  State<RequestsPage> createState() => _RequestsPageState();
}

class _RequestsPageState extends State<RequestsPage> {
  late final AggregationApi _api = AggregationApi(
    context.read<CookieRequest>(),
  );
  RequestFilters _filters = const RequestFilters();
  List<WasteCategory> _categories = const [];
  late Future<List<WasteRequest>> _future;

  @override
  void initState() {
    super.initState();
    _future = _load();
    _loadCategories();
  }

  Future<List<WasteRequest>> _load() async {
    final requests = await _api.fetchRequests(filters: _filters);
    return _filters.applyLocal(requests);
  }

  Future<void> _loadCategories() async {
    try {
      final categories = await _api.fetchCategories();
      if (mounted) setState(() => _categories = categories);
    } catch (_) {
      // Pilihan Material cukup "All materials" kalau kategori gagal dimuat.
    }
  }

  Future<void> _reload() async {
    final future = _load();
    setState(() => _future = future);
    // Tunggu selesai supaya indikator tarik-untuk-memuat berhenti tepat waktu.
    try {
      await future;
    } catch (_) {
      // Error sudah ditampilkan oleh FutureBuilder.
    }
  }

  void _applyFilters(RequestFilters filters) {
    _filters = filters;
    _reload();
  }

  @override
  Widget build(BuildContext context) {
    final muted = Theme.of(context).colorScheme.onSurfaceVariant;
    return Scaffold(
      appBar: const VwAppBar(),
      body: RefreshIndicator(
        onRefresh: _reload,
        child: FutureBuilder<List<WasteRequest>>(
          future: _future,
          builder: (context, snapshot) {
            return ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: VwSpacing.page,
              children: [
                const PageHeader(
                  title: 'Waste requests',
                  subtitle:
                      'Enter the quantity you need. Supply from multiple '
                      'sellers is combined to meet your target.',
                ),
                const SizedBox(height: 24),
                RequestFilterForm(
                  initial: _filters,
                  categories: _categories,
                  onApply: _applyFilters,
                ),
                const SizedBox(height: 24),
                ..._results(snapshot, muted),
              ],
            );
          },
        ),
      ),
    );
  }

  List<Widget> _results(
    AsyncSnapshot<List<WasteRequest>> snapshot,
    Color muted,
  ) {
    if (snapshot.connectionState != ConnectionState.done) {
      return const [
        Padding(padding: EdgeInsets.only(top: 24), child: LoadingView()),
      ];
    }
    if (snapshot.hasError) {
      final error = snapshot.error;
      return [
        MessageView(
          title: "Couldn't load your requests",
          message: error is ApiException
              ? error.message
              : 'Something went wrong. Please try again.',
          actionLabel: 'Try again',
          onAction: _reload,
        ),
      ];
    }
    final requests = snapshot.data ?? const <WasteRequest>[];
    final count = requests.length;
    return [
      Text(
        count == 1 ? '1 request' : '$count requests',
        style: TextStyle(fontSize: 13, height: 17 / 13, color: muted),
      ),
      if (requests.isEmpty)
        const MessageView(
          title: 'No matching requests',
          message:
              'Try different filters, or create a request to find matching '
              'seller supply.',
        )
      else
        for (final request in requests) RequestRow(request: request),
    ];
  }
}
