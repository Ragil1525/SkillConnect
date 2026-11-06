import 'package:flutter/material.dart';

class ReviewRatingScreen extends StatefulWidget {
  const ReviewRatingScreen({super.key});

  @override
  State<ReviewRatingScreen> createState() => _ReviewRatingScreenState();
}

class _ReviewRatingScreenState extends State<ReviewRatingScreen> {
  int _rating = 5;
  final _commentController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    // Menerima data pesanan dari halaman Konfirmasi Penyelesaian
    final Map<String, dynamic> order = 
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>? ?? {
          'id': 'ORD-2026-001',
          'title': 'Jasa Pembuatan Website Portfolio',
          'provider': 'Ragil P.',
        };

    return Scaffold(
      appBar: AppBar(
        title: const Text('Beri Ulasan & Rating'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            const Text(
              'Bagaimana pengalamanmu dengan penyedia jasa ini?',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              order['title'] ?? '',
              style: TextStyle(color: Colors.grey[700], fontSize: 14),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),

            // Pilihan Bintang Rating
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return IconButton(
                  icon: Icon(
                    index < _rating ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                    size: 40,
                  ),
                  onPressed: () {
                    setState(() {
                      _rating = index + 1;
                    });
                  },
                );
              }),
            ),
            const SizedBox(height: 8),
            Text(
              '$_rating dari 5 Bintang',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.deepPurple),
            ),
            const SizedBox(height: 32),

            // Kolom Komentar Ulasan
            TextField(
              controller: _commentController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Tuliskan ulasan, kesan, atau masukan untuk layanan ini...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Tombol Kirim Ulasan
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
                        setState(() => _isLoading = true);

                        // Simulasi pengiriman ulasan ke backend
                        await Future.delayed(const Duration(seconds: 2));

                        if (!mounted) return;
                        setState(() => _isLoading = false);

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Terima kasih! Ulasan berhasil dikirim.'),
                            backgroundColor: Colors.green,
                          ),
                        );

                        // Kembali ke Beranda Customer atau Daftar Pesanan
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          '/customer-home',
                          (route) => false,
                        );
                      },
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        'Kirim Ulasan',
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