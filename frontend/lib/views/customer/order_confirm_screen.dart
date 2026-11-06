import 'package:flutter/material.dart';

class OrderConfirmScreen extends StatefulWidget {
  const OrderConfirmScreen({super.key});

  @override
  State<OrderConfirmScreen> createState() => _OrderConfirmScreenState();
}

class _OrderConfirmScreenState extends State<OrderConfirmScreen> {
  bool _isConfirmed = false;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    // Menerima data pesanan dari halaman Detail Pesanan
    final Map<String, dynamic> order = 
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>? ?? {
          'id': 'ORD-2026-001',
          'title': 'Jasa Pembuatan Website Portfolio',
          'provider': 'Ragil P.',
          'price': '1.500.000',
        };

    return Scaffold(
      appBar: AppBar(
        title: const Text('Konfirmasi Penyelesaian'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Informasi Pesanan
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
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Provider: ${order['provider']}',
                      style: TextStyle(color: Colors.grey[700], fontSize: 14),
                    ),
                    const Divider(height: 24),
                    const Text(
                      'Hasil pengerjaan telah diserahkan oleh penyedia jasa. Silakan periksa kembali hasil kerja sesuai dengan ketentuan awal pesanan.',
                      style: TextStyle(fontSize: 14, color: Colors.black87, height: 1.4),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Kotak Preview / Tautan Hasil Pengerjaan
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
                children: const [
                  Text(
                    'Tautan / Berkas Hasil Kerja:',
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.deepPurple),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'https://github.com/ragil/portfolio-demo (Contoh Tautan)',
                    style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Checkbox Persetujuan
            CheckboxListTile(
              title: const Text(
                'Saya menyatakan bahwa hasil pekerjaan sudah sesuai dan dapat disetujui.',
                style: TextStyle(fontSize: 14),
              ),
              value: _isConfirmed,
              activeColor: Colors.deepPurple,
              contentPadding: EdgeInsets.zero,
              controlAffinity: ListTileControlAffinity.leading,
              onChanged: (bool? value) {
                setState(() {
                  _isConfirmed = value ?? false;
                });
              },
            ),
            const SizedBox(height: 32),

            // Tombol Konfirmasi Selesai
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
                onPressed: (!_isConfirmed || _isLoading)
                    ? null
                    : () async {
                        setState(() => _isLoading = true);

                        // Simulasi pengiriman data ke backend
                        await Future.delayed(const Duration(seconds: 2));

                        if (!mounted) return;
                        setState(() => _isLoading = false);

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Pekerjaan dikonfirmasi selesai! Silakan beri ulasan.'),
                            backgroundColor: Colors.green,
                          ),
                        );

                        // Navigasi ke Halaman Ulasan dan Rating (Halaman 13)[cite: 3]
                        Navigator.pushNamed(
                          context,
                          '/review-rating',
                          arguments: order,
                        );
                      },
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        'Konfirmasi Selesai',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
              ),
            ),
            const SizedBox(height: 12),

            // Tombol Minta Revisi
            SizedBox(
              width: double.infinity,
              height: 50,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.orange.shade800,
                  side: BorderSide(color: Colors.orange.shade800),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Permintaan revisi dikirim ke Provider.')),
                  );
                  Navigator.pop(context);
                },
                child: const Text(
                  'Minta Revisi ke Provider',
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