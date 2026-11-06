import 'package:flutter/material.dart';

class ManageServiceScreen extends StatefulWidget {
  const ManageServiceScreen({super.key});

  @override
  State<ManageServiceScreen> createState() => _ManageServiceScreenState();
}

class _ManageServiceScreenState extends State<ManageServiceScreen> {
  // Data Dummy Jasa Milik Provider
final List<Map<String, String>> _myServices = [
    {
      'id': 'SRV-001',
      'title': 'Jasa Pembuatan Website Portfolio & Company Profile',
      'price': '1.500.000',
      'category': 'Pengembangan Web',
      'status': 'Aktif',
    },
    {
      'id': 'SRV-002',
      'title': 'Desain Logo & Brand Identity Modern',
      'price': '350.000',
      'category': 'Desain Grafis',
      'status': 'Aktif',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kelola Jasa Saya'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: _myServices.isEmpty
          ? const Center(
              child: Text(
                'Belum ada jasa yang ditambahkan.',
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _myServices.length,
              itemBuilder: (context, index) {
                final service = _myServices[index];

                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.only(bottom: 12),
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
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.deepPurple.shade50,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                service['category']!,
                                style: const TextStyle(
                                  color: Colors.deepPurple,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            Text(
                              service['status']!,
                              style: const TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          service['title']!,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Rp ${service['price']}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple,
                            fontSize: 15,
                          ),
                        ),
                        const Divider(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton.icon(
                              onPressed: () {
                                // Navigasi ke Form Tambah/Edit Jasa (Halaman 17) dengan membawa data
                                Navigator.pushNamed(
                                  context,
                                  '/form-service',
                                  arguments: service,
                                );
                              },
                              icon: const Icon(Icons.edit, size: 18, color: Colors.blue),
                              label: const Text('Edit', style: TextStyle(color: Colors.blue)),
                            ),
                            const SizedBox(width: 8),
                            TextButton.icon(
                              onPressed: () {
                                // Aksi Hapus Jasa
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Jasa berhasil dihapus.')),
                                );
                              },
                              icon: const Icon(Icons.delete, size: 18, color: Colors.red),
                              label: const Text('Hapus', style: TextStyle(color: Colors.red)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      // Tombol Tambah Jasa Baru
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        onPressed: () {
          // Menuju Halaman Tambah/Edit Jasa (Halaman 17) tanpa data (mode tambah baru)
          Navigator.pushNamed(context, '/form-service');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}