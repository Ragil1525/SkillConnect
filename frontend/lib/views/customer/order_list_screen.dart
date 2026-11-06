import 'package:flutter/material.dart';

class OrderListScreen extends StatefulWidget {
  const OrderListScreen({super.key});

  @override
  State<OrderListScreen> createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Data Dummy Pesanan Customer
  final List<Map<String, String>> _allOrders = [
    {
      'id': 'ORD-2026-001',
      'title': 'Jasa Pembuatan Website Portfolio',
      'provider': 'Ragil P.',
      'price': '1.500.000',
      'status': 'Berjalan',
      'date': '01 Nov 2026',
    },
    {
      'id': 'ORD-2026-002',
      'title': 'Desain Logo & Brand Identity',
      'provider': 'Bara Studio',
      'price': '350.000',
      'status': 'Menunggu Konfirmasi',
      'date': '30 Okt 2026',
    },
    {
      'id': 'ORD-2026-003',
      'title': 'Penulisan Artikel SEO 1000 Kata',
      'provider': 'Shinta Content',
      'price': '150.000',
      'status': 'Selesai',
      'date': '25 Okt 2026',
    },
    {
      'id': 'ORD-2026-004',
      'title': 'Servis Laptop & Clean Dust',
      'provider': 'Air Tawar Tech',
      'price': '100.000',
      'status': 'Dibatalkan',
      'date': '15 Okt 2026',
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // Filter pesanan sesuai Tab Status
  List<Map<String, String>> _getFilteredOrders(String category) {
    if (category == 'Aktif') {
      return _allOrders.where((item) => item['status'] == 'Berjalan' || item['status'] == 'Menunggu Konfirmasi').toList();
    } else if (category == 'Selesai') {
      return _allOrders.where((item) => item['status'] == 'Selesai').toList();
    } else {
      return _allOrders.where((item) => item['status'] == 'Dibatalkan' || item['status'] == 'Ditolak').toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Pesanan Saya'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: const [
            Tab(text: 'Aktif'),
            Tab(text: 'Selesai'),
            Tab(text: 'Dibatalkan'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildOrderListView(_getFilteredOrders('Aktif')),
          _buildOrderListView(_getFilteredOrders('Selesai')),
          _buildOrderListView(_getFilteredOrders('Dibatalkan')),
        ],
      ),
    );
  }

  Widget _buildOrderListView(List<Map<String, String>> orders) {
    if (orders.isEmpty) {
      return const Center(
        child: Text(
          'Belum ada pesanan pada kategori ini.',
          style: TextStyle(color: Colors.grey, fontSize: 16),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        Color statusColor;

        switch (order['status']) {
          case 'Selesai':
            statusColor = Colors.green;
            break;
          case 'Berjalan':
            statusColor = Colors.blue;
            break;
          case 'Menunggu Konfirmasi':
            statusColor = Colors.orange;
            break;
          default:
            statusColor = Colors.red;
        }

        return Card(
          elevation: 2,
          margin: const EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      order['id']!,
                      style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
                    ),
                    Text(
                      order['date']!,
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
                const Divider(height: 16),
                Text(
                  order['title']!,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 4),
                Text(
                  'Provider: ${order['provider']}',
                  style: TextStyle(color: Colors.grey[700], fontSize: 14),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: statusColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: statusColor),
                      ),
                      child: Text(
                        order['status']!,
                        style: TextStyle(
                          color: statusColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Text(
                      'Rp ${order['price']}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.deepPurple,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.deepPurple,
                      side: const BorderSide(color: Colors.deepPurple),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        '/order-detail',
                        arguments: order,
                      );
                    },
                    child: const Text('Lihat Detail Pesanan'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}