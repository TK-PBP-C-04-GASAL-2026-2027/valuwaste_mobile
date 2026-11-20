import 'package:flutter/material.dart';
import '../../../core/theme/vw_colors.dart';
import '../../../core/widgets/page_header.dart';
import '../../../core/widgets/vw_app_bar.dart';
import '../models/market_item.dart';
import '../widgets/market_card.dart';

class MarketPage extends StatefulWidget {
  const MarketPage({super.key});

  @override
  State<MarketPage> createState() => _MarketPageState();
}

class _MarketPageState extends State<MarketPage> {
  String _searchQuery = '';
  String _selectedLocation = 'All locations';
  String _selectedSort = 'Lowest price';

  static const List<String> _locations = [
    'All locations',
    'Jakarta',
    'Depok',
    'Bekasi',
  ];

  static const List<String> _sortOptions = [
    'Lowest price',
    'Highest price',
    'Most sellers',
  ];

  static const List<MarketItem> _dummyItems = [
    MarketItem(
      name: 'Paper Mix',
      stockInfo: '2.4 ton available',
      sellerCount: 44,
      pricePerKg: 1150,
      priceFormatted: 'Rp1.150',
      location: 'Depok',
    ),
    MarketItem(
      name: 'Glass',
      stockInfo: '850 kg available',
      sellerCount: 22,
      pricePerKg: 1500,
      priceFormatted: 'Rp1.500',
      location: 'Jakarta',
    ),
    MarketItem(
      name: 'Cardboard',
      stockInfo: '1.2 ton available',
      sellerCount: 31,
      pricePerKg: 2000,
      priceFormatted: 'Rp2.000',
      location: 'Bekasi',
    ),
    MarketItem(
      name: 'PET Plastic',
      stockInfo: '620 kg available',
      sellerCount: 18,
      pricePerKg: 3000,
      priceFormatted: 'Rp3.000',
      location: 'Depok',
    ),
    MarketItem(
      name: 'HDPE Plastic',
      stockInfo: '470 kg available',
      sellerCount: 14,
      pricePerKg: 4100,
      priceFormatted: 'Rp4.100',
      location: 'Jakarta',
    ),
    MarketItem(
      name: 'Aluminium',
      stockInfo: '210 kg available',
      sellerCount: 9,
      pricePerKg: 14000,
      priceFormatted: 'Rp14.000',
      location: 'Bekasi',
    ),
  ];

  List<MarketItem> get _filteredItems {
    final items = _dummyItems.where((item) {
      final matchesSearch =
          item.name.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesLocation = _selectedLocation == 'All locations' ||
          item.location == _selectedLocation;
      return matchesSearch && matchesLocation;
    }).toList();

    if (_selectedSort == 'Lowest price') {
      items.sort((a, b) => a.pricePerKg.compareTo(b.pricePerKg));
    } else if (_selectedSort == 'Highest price') {
      items.sort((a, b) => b.pricePerKg.compareTo(a.pricePerKg));
    } else if (_selectedSort == 'Most sellers') {
      items.sort((a, b) => b.sellerCount.compareTo(a.sellerCount));
    }

    return items;
  }

  @override
  Widget build(BuildContext context) {
    final vw = Theme.of(context).extension<VwColors>()!;
    final items = _filteredItems;

    return Scaffold(
      appBar: const VwAppBar(),
      body: ListView(
        padding: VwSpacing.page,
        children: [
          const PageHeader(
            title: 'Community market',
            subtitle: 'Compare stock and starting prices across material markets.',
          ),
          const SizedBox(height: 20),

          // Search Field
          LabeledField(
            label: 'Search',
            child: TextField(
              onChanged: (value) => setState(() => _searchQuery = value),
              decoration: InputDecoration(
                hintText: 'Search materials',
                filled: true,
                fillColor: vw.paper,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 12,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(color: vw.line),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(color: vw.ink2, width: 1.5),
                ),
              ),
            ),
          ),
          const SizedBox(height: VwSpacing.gap),

          // Dropdown Location & Sort By
          Row(
            children: [
              Expanded(
                child: LabeledField(
                  label: 'Location',
                  child: DropdownButtonFormField<String>(
                    value: _selectedLocation,
                    isExpanded: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: vw.paper,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: BorderSide(color: vw.line),
                      ),
                    ),
                    items: _locations
                        .map((loc) => DropdownMenuItem(
                              value: loc,
                              child: Text(loc, overflow: TextOverflow.ellipsis),
                            ))
                        .toList(),
                    onChanged: (val) {
                      if (val != null) setState(() => _selectedLocation = val);
                    },
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: LabeledField(
                  label: 'Sort by',
                  child: DropdownButtonFormField<String>(
                    value: _selectedSort,
                    isExpanded: true,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: vw.paper,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(6),
                        borderSide: BorderSide(color: vw.line),
                      ),
                    ),
                    items: _sortOptions
                        .map((sort) => DropdownMenuItem(
                              value: sort,
                              child: Text(sort, overflow: TextOverflow.ellipsis),
                            ))
                        .toList(),
                    onChanged: (val) {
                      if (val != null) setState(() => _selectedSort = val);
                    },
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Daftar Material
          for (final item in items)
            MarketCard(
              item: item,
              onViewMarket: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Opening ${item.name} market')),
                );
              },
            ),
        ],
      ),
    );
  }
}