import 'package:flutter/material.dart';

class FormServiceScreen extends StatefulWidget {
  const FormServiceScreen({super.key});

  @override
  State<FormServiceScreen> createState() => _FormServiceScreenState();
}

class _FormServiceScreenState extends State<FormServiceScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();
  
  String _selectedCategory = 'Pengembangan Web';
  final List<String> _categories = [
    'Pengembangan Web',
    'Desain Grafis',
    'Penulisan & Terjemahan',
    'Video & Animasi',
    'Servis Elektronik'
  ];

  bool _isEditMode = false;
  bool _isLoading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Cek apakah ada argumen yang dikirim (berarti mode Edit)
    final Map<String, dynamic>? serviceData = 
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    if (serviceData != null && !_isEditMode) {
      _titleController.text = serviceData['title'] ?? '';
      _priceController.text = serviceData['price'] ?? '';
      _descriptionController.text = serviceData['description'] ?? '';
      if (_categories.contains(serviceData['category'])) {
        _selectedCategory = serviceData['category'];
      }
      _isEditMode = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditMode ? 'Edit Jasa' : 'Tambah Jasa Baru'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Judul Jasa
              const Text(
                'Nama Jasa',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  hintText: 'Contoh: Jasa Pembuatan Website Portfolio',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama jasa wajib diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Kategori Jasa
              const Text(
                'Kategori Jasa',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                items: _categories.map((String category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedCategory = newValue!;
                  });
                },
              ),
              const SizedBox(height: 20),

              // Harga Jasa
              const Text(
                'Harga (Rp)',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Contoh: 1500000',
                  prefixText: 'Rp ',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Harga wajib diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Deskripsi Jasa
              const Text(
                'Deskripsi & Spesifikasi Layanan',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _descriptionController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'Jelaskan apa saja yang didapat customer, estimasi waktu, dll.',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Deskripsi wajib diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),

              // Tombol Simpan
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
                          if (_formKey.currentState!.validate()) {
                            setState(() => _isLoading = true);

                            // Simulasi simpan data ke backend
                            await Future.delayed(const Duration(seconds: 2));

                            if (!mounted) return;
                            setState(() => _isLoading = false);

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(_isEditMode ? 'Jasa berhasil diperbarui!' : 'Jasa baru berhasil ditambahkan!'),
                                backgroundColor: Colors.green,
                              ),
                            );

                            // Kembali ke halaman Kelola Jasa (Halaman 16)[cite: 3]
                            Navigator.pop(context);
                          }
                        },
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text(
                          _isEditMode ? 'Simpan Perubahan' : 'Terbitkan Jasa',
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}