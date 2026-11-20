import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/vw_app_bar.dart';

class ListingsPage extends StatelessWidget {
  const ListingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const VwAppBar(),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // 1. Judul halaman
          const Text(
            'My listings',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: AppColors.text,
            ),
          ),

          const SizedBox(height: 8),

          // 2. Ringkasan listing
          const Text(
            '4 listings · 3 selling · 1 paused',
            style: TextStyle(fontSize: 13, color: AppColors.muted),
          ),

          const SizedBox(height: 16),

          // 3. Tombol tambah listing
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add),
              label: const Text('New listing'),
            ),
          ),

          const SizedBox(height: 16),

          // 4. Search bar
          const Text('Search'),
          const SizedBox(height: 6),
          const TextField(
            decoration: InputDecoration(
              hintText: 'Search material',
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 16),
          const Divider(),

          // 5. Daftar material
          _buildListing(
            'PET plastic',
            '32 kg',
            'Rp3.200/kg',
            'Depok',
            'Active',
          ),
          _buildListing(
            'Cardboard',
            '55 kg',
            'Rp2.100/kg',
            'Jakarta',
            'Active',
          ),
          _buildListing(
            'Aluminium',
            '12 kg',
            'Rp14.500/kg',
            'Bekasi',
            'Low stock',
          ),
          _buildListing('Glass', '29 kg', 'Rp1.700/kg', 'Bogor', 'Paused'),
        ],
      ),
    );
  }

  Widget _buildListing(
    String title,
    String stock,
    String price,
    String location,
    String status,
  ) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 14),
          child: Row(
            children: [
              // Informasi material
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text('$stock · $price'),
                    const SizedBox(height: 4),
                    Text(
                      location,
                      style: const TextStyle(
                        color: AppColors.muted,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),

              // Status dan tombol edit
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(status, style: const TextStyle(fontSize: 12)),
                  const SizedBox(height: 12),
                  OutlinedButton(onPressed: () {}, child: const Text('Edit')),
                ],
              ),
            ],
          ),
        ),
        const Divider(color: AppColors.line),
      ],
    );
  }
}
