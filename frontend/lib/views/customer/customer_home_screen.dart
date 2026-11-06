import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CustomerHomeScreen extends StatefulWidget {
  const CustomerHomeScreen({super.key});

  @override
  State<CustomerHomeScreen> createState() => _CustomerHomeScreenState();
}

class _CustomerHomeScreenState extends State<CustomerHomeScreen> {
  // Ganti dengan endpoint backend kamu
  final String baseUrl = 'http://localhost:3000/api';
  
  List recommendedServices = [];
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchRecommendedServices();
  }

  // Fungsi mengambil data rekomendasi jasa dari backend
  Future<void> fetchRecommendedServices() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    try {
      final response = await http.get(Uri.parse('$baseUrl/services'));
      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        setState(() {
          recommendedServices = data is List ? data : (data['services'] ?? []);
          isLoading = false;
        });
      } else {
        setState(() {
          errorMessage = 'Gagal memuat rekomendasi: ${data['message'] ?? 'Error server'}';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Kesalahan Koneksi: $e';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SkillConnect - Beranda'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {
              // Navigasi ke Halaman Notifikasi (Sesuai list 24 halaman)
              // Navigator.pushNamed(context, '/notification');
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: fetchRecommendedServices,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Bagian Sapaan / Banner Singkat
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.deepPurple.shade50,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Halo, Selamat Datang! 👋',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Temukan penyedia jasa profesional terbaik untuk menyelesaikan tugasmu hari ini.',
                      style: TextStyle(color: Colors.black87),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Bagian Shortcut / Kategori Pilihan
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Kategori Pilihan',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {
                      // Navigasi ke Katalog & Pencarian
                    },
                    child: const Text('Lihat Semua'),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              
              // Grid Kategori Sederhana
              GridView.count(
                crossAxisCount: 4,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                children: [
                  _buildCategoryItem(Icons.code, 'Pemrograman'),
                  _buildCategoryItem(Icons.design_services, 'Desain'),
                  _buildCategoryItem(Icons.edit_note, 'Penulisan'),
                  _buildCategoryItem(Icons.more_horiz, 'Lainnya'),
                ],
              ),
              const SizedBox(height: 24),

              // Bagian Rekomendasi Jasa
              const Text(
                'Rekomendasi Jasa',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),

              // Konten List Rekomendasi dari Database
              isLoading
                  ? const Center(
                      child: Padding(
                        padding: EdgeInsets.all(32.0),
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : errorMessage.isNotEmpty
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                              errorMessage,
                              style: const TextStyle(color: Colors.red),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      : recommendedServices.isEmpty
                          ? const Center(
                              child: Padding(
                                padding: EdgeInsets.all(20.0),
                                child: Text('Belum ada jasa tersedia.'),
                              ),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: recommendedServices.length,
                              itemBuilder: (context, index) {
                                final item = recommendedServices[index];
                                return Card(
                                  elevation: 2,
                                  margin: const EdgeInsets.only(bottom: 12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: ListTile(
                                    contentPadding: const EdgeInsets.all(16),
                                    title: Text(
                                      item['title'] ?? 'Tanpa Judul',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 6),
                                        Text(
                                          item['description'] ?? '',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(color: Colors.grey[700]),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          'Rp ${item['price'] ?? '0'}',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.deepPurple,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                    onTap: () {
                                      // TODO: Arahkan ke Halaman Detail Jasa (service_detail_screen.dart)
                                    },
                                  ),
                                );
                              },
                            ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget helper untuk ikon kategori
  Widget _buildCategoryItem(IconData icon, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.deepPurple.shade50,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.deepPurple),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 12),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}