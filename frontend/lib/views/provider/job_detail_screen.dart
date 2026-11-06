import 'package:flutter/material.dart';

class JobDetailScreen extends StatefulWidget {
  const JobDetailScreen({super.key});

  @override
  State<JobDetailScreen> createState() => _JobDetailScreenState();
}

class _JobDetailScreenState extends State<JobDetailScreen> {
  final _resultController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    // Menerima data pekerjaan/pesanan yang sedang berjalan
    final Map<String, dynamic> job = 
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>? ?? {
          'id': 'ORD-2026-005',
          'title': 'Jasa Pembuatan Aplikasi Mobile Flutter',
          'customer': 'Andi Pratama',
          'price': '2.500.000',
          'schedule': '5 Hari',
          'requirement': 'Membuat aplikasi marketplace jasa dengan 24 halaman utama.',
          'status': 'Sedang Dikerjakan',
        };

    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Pekerjaan (${job['id']})'),
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
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Status Pekerjaan:',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    job['status'] ?? 'Sedang Dikerjakan',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Informasi Detail Tugas
            const Text(
              'Informasi Tugas',
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
                      job['title'] ?? '',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const Divider(height: 16),
                    Text('Customer: ${job['customer']}'),
                    const SizedBox(height: 8),
                    Text('Estimasi: ${job['schedule']}'),
                    const SizedBox(height: 8),
                    const Text('Kebutuhan:', style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text(job['requirement'] ?? '-'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Form Pengiriman Hasil Kerja
            const Text(
              'Serahkan Hasil Pekerjaan',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _resultController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Masukkan tautan GitHub, Google Drive, atau catatan hasil kerja...',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 20),

            // Tombol Kirim Hasil ke Customer
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: _isLoading
                    ? null
                    : () async {
                        if (_resultController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Tautan/berkas hasil kerja tidak boleh kosong!')),
                          );
                          return;
                        }

                        setState(() => _isLoading = true);

                        // Simulasi pengiriman hasil kerja ke backend
                        await Future.delayed(const Duration(seconds: 2));

                        if (!mounted) return;
                        setState(() => _isLoading = false);

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Hasil pekerjaan berhasil diserahkan ke Customer!'),
                            backgroundColor: Colors.green,
                          ),
                        );

                        Navigator.pop(context);
                      },
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        'Kirim Hasil Pekerjaan',
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