import 'package:flutter/material.dart';

class OrderDetailScreen extends StatelessWidget {
  const OrderDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Menerima data pesanan dari halaman sebelumnya
    final Map<String, dynamic> order = 
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>? ?? {
          'id': 'ORD-2026-001',
          'title': 'Jasa Pembuatan Website Portfolio',
          'provider': 'Ragil P.',
          'price': '1.500.000',
          'status': 'Berjalan',
          'date': '01 Nov 2026',
        };

    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Pesanan (${order['id']})'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.deepPurple.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.deepPurple.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Status Pesanan Saat Ini:',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    order['status'] ?? 'Berjalan',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Informasi Layanan & Harga
            const Text(
              'Informasi Layanan',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      order['title'] ?? '',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const Divider(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Tanggal Pesanan:'),
                        Text(order['date'] ?? ''),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Total Biaya:'),
                        Text(
                          'Rp ${order['price']}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Informasi Provider
            const Text(
              'Penyedia Jasa (Provider)',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                contentPadding: const EdgeInsets.all(16),
                leading: const CircleAvatar(
                  backgroundColor: Colors.deepPurple,
                  child: Icon(Icons.person, color: Colors.white),
                ),
                title: Text(
                  order['provider'] ?? 'Provider Profesional',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: const Text('Status: Mengerjakan Tugas'),
                trailing: IconButton(
                  icon: const Icon(Icons.chat, color: Colors.deepPurple),
                  onPressed: () {
                    // Aksi Chat dengan Provider
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Fitur chat akan segera dibuka.')),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Tombol Aksi Konfirmasi Penyelesaian (Halaman 12) jika hasil sudah diserahkan
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  // Navigasi ke Halaman Konfirmasi Penyelesaian (Halaman 12) atau Ulasan & Rating (Halaman 13)
                  Navigator.pushNamed(context, '/order-confirm', arguments: order);
                },
                child: const Text(
                  'Konfirmasi Penyelesaian Pekerjaan',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Tombol Pengaduan / Revisi
            SizedBox(
              width: double.infinity,
              height: 50,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.red,
                  side: const BorderSide(color: Colors.red),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  // Jalur Pengaduan / Revisi ke Admin / Provider[cite: 4]
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Permintaan revisi/pengaduan dikirim.')),
                  );
                },
                child: const Text(
                  'Ajukan Revisi / Pengaduan',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}