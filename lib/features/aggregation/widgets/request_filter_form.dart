// =============================================================================
// request_filter_form.dart - filter Search / Status / Material / Supply
//
// Figma lama D13 (dan pola filter HP M06): label Medium 14 di atas field,
// field kertas bergaris tinggi 40. Status + Material sebaris, lalu tombol
// "Apply filters" (utama) dan "Reset" (netral) berdampingan, jarak 12.
// =============================================================================
import 'package:flutter/material.dart';

import '../data/request_filters.dart';
import '../data/waste_request.dart';

class RequestFilterForm extends StatefulWidget {
  const RequestFilterForm({
    super.key,
    required this.initial,
    required this.categories,
    required this.onApply,
  });

  final RequestFilters initial;
  final List<WasteCategory> categories;
  final ValueChanged<RequestFilters> onApply;

  @override
  State<RequestFilterForm> createState() => _RequestFilterFormState();
}

class _RequestFilterFormState extends State<RequestFilterForm> {
  late final TextEditingController _query = TextEditingController(
    text: widget.initial.query,
  );
  late String? _status = widget.initial.status;
  late int? _categoryId = widget.initial.categoryId;
  late SupplyFilter? _supply = widget.initial.supply;

  // Dropdown hanya membaca initialValue sekali; angka ini diganti saat Reset
  // supaya dropdown dibuat ulang dan kembali ke pilihan "All".
  int _generation = 0;

  @override
  void dispose() {
    _query.dispose();
    super.dispose();
  }

  void _apply() {
    FocusScope.of(context).unfocus();
    widget.onApply(
      RequestFilters(
        query: _query.text,
        status: _status,
        categoryId: _categoryId,
        supply: _supply,
      ),
    );
  }

  void _reset() {
    FocusScope.of(context).unfocus();
    setState(() {
      _query.clear();
      _status = null;
      _categoryId = null;
      _supply = null;
      _generation++;
    });
    widget.onApply(const RequestFilters());
  }

  @override
  Widget build(BuildContext context) {
    // Cek: kategori terpilih sudah tidak ada di daftar -> kembali ke "All".
    final categoryIds = widget.categories.map((c) => c.id).toSet();
    final categoryValue = categoryIds.contains(_categoryId)
        ? _categoryId
        : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _Field(
          label: 'Search',
          child: TextField(
            controller: _query,
            textInputAction: TextInputAction.search,
            onSubmitted: (_) => _apply(),
            decoration: const InputDecoration(
              hintText: 'Request title or material',
            ),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _Field(
                label: 'Status',
                child: DropdownButtonFormField<String?>(
                  key: ValueKey('status-$_generation'),
                  initialValue: _status,
                  isExpanded: true,
                  icon: const _Chevron(),
                  items: [
                    const DropdownMenuItem(
                      value: null,
                      child: Text('All statuses'),
                    ),
                    for (final entry in WasteRequest.statusLabels.entries)
                      DropdownMenuItem(
                        value: entry.key,
                        child: Text(entry.value),
                      ),
                  ],
                  onChanged: (value) => setState(() => _status = value),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _Field(
                label: 'Material',
                child: DropdownButtonFormField<int?>(
                  key: ValueKey('material-$_generation-${categoryIds.length}'),
                  initialValue: categoryValue,
                  isExpanded: true,
                  icon: const _Chevron(),
                  items: [
                    const DropdownMenuItem(
                      value: null,
                      child: Text('All materials'),
                    ),
                    for (final category in widget.categories)
                      DropdownMenuItem(
                        value: category.id,
                        child: Text(
                          category.name,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                  ],
                  onChanged: (value) => setState(() => _categoryId = value),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _Field(
          label: 'Supply',
          child: DropdownButtonFormField<SupplyFilter?>(
            key: ValueKey('supply-$_generation'),
            initialValue: _supply,
            isExpanded: true,
            icon: const _Chevron(),
            items: [
              const DropdownMenuItem(
                value: null,
                child: Text('Any fulfilment'),
              ),
              for (final option in SupplyFilter.values)
                DropdownMenuItem(value: option, child: Text(option.label)),
            ],
            onChanged: (value) => setState(() => _supply = value),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: FilledButton(
                onPressed: _apply,
                child: const Text('Apply filters'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: OutlinedButton(
                onPressed: _reset,
                child: const Text('Reset'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// Label Medium 14 di atas field, jarak 8 (pola filter HP M06).
class _Field extends StatelessWidget {
  const _Field({required this.label, required this.child});

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(label, style: Theme.of(context).textTheme.labelMedium),
        const SizedBox(height: 8),
        child,
      ],
    );
  }
}

/// Ikon "Chevron down" dari Figma: garis 8 x 4, tebal 1,6, warna #132B20,
/// di tengah kotak 16.
class _Chevron extends StatelessWidget {
  const _Chevron();

  @override
  Widget build(BuildContext context) {
    return const CustomPaint(size: Size(16, 16), painter: _ChevronPainter());
  }
}

class _ChevronPainter extends CustomPainter {
  const _ChevronPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF132B20)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.6
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    final path = Path()
      ..moveTo(4, 6)
      ..lineTo(8, 10)
      ..lineTo(12, 6);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_ChevronPainter oldDelegate) => false;
}
