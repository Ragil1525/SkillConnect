import 'package:flutter/material.dart';

class ProviderActivateScreen extends StatefulWidget {
  const ProviderActivateScreen({super.key});

  @override
  State<ProviderActivateScreen> createState() => _ProviderActivateScreenState();
}

class _ProviderActivateScreenState extends State<ProviderActivateScreen> {
  final _formKey = GlobalKey<FormState>();
  final _bioController = TextEditingController();
  final _skillsController = TextEditingController();
  final _experienceController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Aktivasi Profil Provider'),
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
              const Text(
                'Bergabunglah sebagai Penyedia Jasa!',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.deepPurple),
              ),
              const SizedBox(height: 8),
              const Text(
                'Lengkapi informasi profil profesionalmu di bawah ini untuk mulai menawarkan jasa kepada customer.',
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
              const SizedBox(height: 24),

              // Bio Singkat / Deskripsi Keahlian
              const Text(
                'Bio / Profil Profesional',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _bioController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'Contoh: Mahasiswa Teknik Informatika yang berpengalaman dalam pengembangan web dan aplikasi mobile.',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Bio tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Keahlian Utama (Keahlian/Skills)
              const Text(
                'Keahlian Utama (Skills)',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _skillsController,
                decoration: InputDecoration(
                  hintText: 'Contoh: Flutter, Node.js, MariaDB, Desain UI/UX',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Keahlian wajib diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Pengalaman / Portofolio Singkat
              const Text(
                'Pengalaman / Tautan Portofolio',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _experienceController,
                decoration: InputDecoration(
                  hintText: 'Contoh: 2 Tahun / https://github.com/ragil',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Pengalaman wajib diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),

              // Tombol Aktifkan Profil
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

                            // Simulasi aktivasi profil provider ke backend
                            await Future.delayed(const Duration(seconds: 2));

                            if (!mounted) return;
                            setState(() => _isLoading = false);

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Aktivasi Profil Provider Berhasil!'),
                                backgroundColor: Colors.green,
                              ),
                            );

                            // Mengarahkan ke Dashboard Provider (Halaman 15)
                            Navigator.pushReplacementNamed(context, '/provider-dashboard');
                          }
                        },
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          'Aktifkan Sekarang',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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