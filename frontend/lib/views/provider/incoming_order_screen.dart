import 'package:flutter/material.dart';

class IncomingOrderScreen extends StatefulWidget {
  const IncomingOrderScreen({super.key});

  @override
  State<IncomingOrderScreen> createState() => _IncomingOrderScreenState();
}

class _IncomingOrderScreenState extends State<IncomingOrderScreen> {
  // Data Dummy Pesanan Masuk yang sudah terverifikasi pembayarannya
  final List<Map<String, String>> _incomingOrders = [
    {
      'id': 'ORD-2026-005',
      'title': 'Jasa Pembuatan Aplikasi Mobile Flutter',
      'customer': 'Andi Pratama',
      'price': '2.500.000',
      'schedule': '5 Hari',
      'requirement': 'Membuat aplikasi marketplace jasa dengan 24 halaman utama.',
      'date': '02 Nov 2026',
    },
    {
      'id': 'ORD-2026-006',
      'title': 'Desain Banner & Feed Instagram UMKM',
      'customer': 'Siti Aminah',
      'price': '300.000',
      'schedule': '2 Hari',
      'requirement': 'Membuat 6 desain postingan bertema kuliner tradisional.',
      'date': '02 Nov 2026',
    },
  ];

  void _acceptOrder(String orderId) {
    setState(() {
      _incomingOrders.removeWhere((order) => order['id'] == orderId);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Pesanan diterima! Status bergeser ke Pekerjaan Berjalan.'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _rejectOrder(String orderId) {
    setState(() {
      _incomingOrders.removeWhere((order) => order['id'] == orderId);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Pesanan ditolak. Proses pembatalan/refund diproses.'),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pesanan Masuk (Baru)'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: _incomingOrders.isEmpty
          ? const Center(
              child: Text(
                'Tidak ada pesanan masuk saat ini.',
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _incomingOrders.length,
              itemBuilder: (context, index) {
                final order = _incomingOrders[index];

                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.only(bottom: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
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
                        const SizedBox(height: 6),
                        Text(
                          'Customer: ${order['customer']}',
                          style: TextStyle(color: Colors.grey[700], fontSize: 14),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Kebutuhan: ${order['requirement']}',
                                style: const TextStyle(fontSize: 13),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Estimasi Waktu: ${order['schedule']}',
                                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
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
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: Colors.red,
                                  side: const BorderSide(color: Colors.red),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                onPressed: () => _rejectOrder(order['id']!),
                                child: const Text('Tolak'),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                onPressed: () => _acceptOrder(order['id']!),
                                child: const Text('Terima Pesanan'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}