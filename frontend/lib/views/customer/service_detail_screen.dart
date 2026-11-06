import 'package:flutter/material.dart';

class ServiceDetailScreen extends StatelessWidget {
  const ServiceDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Menerima data argumen jasa yang dikirim dari halaman Katalog atau Beranda
    final Map<String, dynamic> service = 
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>? ?? {
          'title': 'Jasa Pembuatan Aplikasi Mobile',
          'description': 'Layanan pembuatan aplikasi mobile berbasis Flutter dan backend Express.js untuk kebutuhan tugas akhir maupun profesional.',
          'price': '1.500.000',
          'provider_name': 'Ragil P. (Informatics Expert)',
        };

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Jasa'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner / Gambar Ilustrasi Jasa
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.deepPurple.shade100,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Center(
                child: Icon(
                  Icons.design_services,
                  size: 80,
                  color: Colors.deepPurple,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Judul Jasa
            Text(
              service['title'] ?? 'Tanpa Judul',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),

            // Harga Jasa
            Text(
              'Rp ${service['price'] ?? '0'}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 16),

            // Informasi Penyedia Jasa (Provider)
            const Text(
              'Penyedia Jasa (Provider)',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const CircleAvatar(
                backgroundColor: Colors.deepPurple,
                child: Icon(Icons.person, color: Colors.white),
              ),
              title: Text(
                service['provider_name'] ?? 'Penyedia Profesional',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: const Text('Terverifikasi • Rating 4.9 (120+ Ulasan)'),
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 16),

            // Deskripsi Jasa
            const Text(
              'Deskripsi Layanan',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              service['description'] ?? 'Tidak ada deskripsi tersedia.',
              style: TextStyle(fontSize: 14, color: Colors.grey[800], height: 1.5),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
      // Tombol Pesan di Bagian Bawah (Floating / Bottom Bar)
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: SizedBox(
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
            onPressed: () {
              // Navigasi ke Halaman Form Pemesanan (Halaman 8)
              Navigator.pushNamed(
                context,
                '/booking-form',
                arguments: service,
              );
            },
            child: const Text(
              'Pesan Jasa Ini',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}