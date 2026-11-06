import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CatalogSearchScreen extends StatefulWidget {
  const CatalogSearchScreen({super.key});

  @override
  State<CatalogSearchScreen> createState() => _CatalogSearchScreenState();
}

class _CatalogSearchScreenState extends State<CatalogSearchScreen> {
  final String baseUrl = 'http://localhost:3000/api';
  
  List allServices = [];
  List filteredServices = [];
  bool isLoading = true;
  String searchQuery = '';
  String selectedCategory = 'Semua';

  @override
  void initState() {
    super.initState();
    fetchServices();
  }

  // Mengambil data seluruh jasa dari backend
  Future<void> fetchServices() async {
    setState(() => isLoading = true);

    try {
      final response = await http.get(Uri.parse('$baseUrl/services'));
      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        setState(() {
          allServices = data is List ? data : (data['services'] ?? []);
          filteredServices = allServices;
          isLoading = false;
        });
      } else {
        setState(() => isLoading = false);
      }
    } catch (e) {
      setState(() => isLoading = false);
    }
  }

  // Fungsi pencarian dan filter
  void _filterServices(String query) {
    setState(() {
      searchQuery = query;
      filteredServices = allServices.where((item) {
        final title = (item['title'] ?? '').toLowerCase();
        final description = (item['description'] ?? '').toLowerCase();
        final queryLower = query.toLowerCase();

        return title.contains(queryLower) || description.contains(queryLower);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Katalog & Pencarian Jasa'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // Bar Pencarian
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: _filterServices,
              decoration: InputDecoration(
                hintText: 'Cari jasa (contoh: Pembuatan Web, Desain Logo)...',
                prefixIcon: const Icon(Icons.search, color: Colors.deepPurple),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.deepPurple, width: 2),
                ),
              ),
            ),
          ),

          // Daftar Hasil Jasa
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : filteredServices.isEmpty
                    ? const Center(
                        child: Text(
                          'Jasa tidak ditemukan.',
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: filteredServices.length,
                        itemBuilder: (context, index) {
                          final item = filteredServices[index];
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
                                // Navigasi ke Halaman Detail Jasa (Halaman 7)
                                Navigator.pushNamed(
                                  context,
                                  '/service-detail',
                                  arguments: item, // Mengirim data jasa yang dipilih
                                );
                              },
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}