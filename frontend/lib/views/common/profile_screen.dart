import 'package:flutter/material.dart';

// Palet yang sama dengan LandingScreen, LoginScreen, dan NotificationScreen
const _navy = Color(0xFF131921);
const _navy2 = Color(0xFF232F3E);
const _orange = Color(0xFFFF9900);
const _orangeSoft = Color(0xFFFFD814);
const _pageBg = Color(0xFFEAEDED);
const _ink = Color(0xFF0F1111);
const _muted = Color(0xFF565959);
const _border = Color(0xFFD5D9D9);
const _danger = Color(0xFFB12704);

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Data profil pengguna yang bisa diperbarui secara dinamis
  final Map<String, String> userProfile = {
    'name': 'Ragil P.',
    'email': 'ragil@gmail.com',
    'role': 'Service Provider / Customer',
    'phone': '+62 812-3456-7890',
    'city': 'Padang, Sumatera Barat',
  };

  InputDecoration _fieldDecoration(String label) {
    OutlineInputBorder border(Color color, [double width = 1]) => OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(color: color, width: width),
        );
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: _muted),
      floatingLabelStyle: const TextStyle(color: _ink, fontWeight: FontWeight.bold),
      isDense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      border: border(const Color(0xFF888C8C)),
      enabledBorder: border(const Color(0xFF888C8C)),
      focusedBorder: border(_orange, 2),
    );
  }

  // Fungsi untuk menampilkan Bottom Sheet Edit Profil
  void _showEditProfileModal() {
    final nameController = TextEditingController(text: userProfile['name']);
    final phoneController = TextEditingController(text: userProfile['phone']);
    final cityController = TextEditingController(text: userProfile['city']);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
      builder: (context) {
        return SingleChildScrollView(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 20,
            right: 20,
            top: 24,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 560),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Edit Profil',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500, color: _ink),
                  ),
                  const SizedBox(height: 16),
                  TextField(controller: nameController, decoration: _fieldDecoration('Nama Lengkap')),
                  const SizedBox(height: 14),
                  TextField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: _fieldDecoration('Nomor Telepon'),
                  ),
                  const SizedBox(height: 14),
                  TextField(controller: cityController, decoration: _fieldDecoration('Kota / Lokasi')),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 44,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _orangeSoft,
                        foregroundColor: _ink,
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
                      ),
                      onPressed: () {
                        setState(() {
                          userProfile['name'] = nameController.text;
                          userProfile['phone'] = phoneController.text;
                          userProfile['city'] = cityController.text;
                        });
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Profil berhasil diperbarui!')),
                        );
                      },
                      child: const Text('Simpan Perubahan', style: TextStyle(fontWeight: FontWeight.w600)),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _pageBg,
      appBar: AppBar(
        title: const Text('Profil Pengguna', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: _navy,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Column(
              children: [
                // Kartu avatar & nama
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: _border),
                  ),
                  child: Column(
                    children: [
                      const CircleAvatar(
                        radius: 48,
                        backgroundColor: _navy2,
                        child: Icon(Icons.person, size: 48, color: _orange),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        userProfile['name']!,
                        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: _ink),
                      ),
                      const SizedBox(height: 4),
                      Text(userProfile['email']!, style: const TextStyle(color: _muted, fontSize: 14)),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF0F2F2),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: _border),
                        ),
                        child: Text(
                          userProfile['role']!,
                          style: const TextStyle(color: _ink, fontWeight: FontWeight.w600, fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Informasi detail akun
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: _border),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Informasi akun',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: _ink)),
                      const SizedBox(height: 16),
                      _buildInfoRow(Icons.phone_outlined, 'Nomor Telepon', userProfile['phone']!),
                      const Divider(height: 28, color: _border),
                      _buildInfoRow(Icons.location_on_outlined, 'Lokasi', userProfile['city']!),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Tombol aksi
                SizedBox(
                  width: double.infinity,
                  height: 44,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _orangeSoft,
                      foregroundColor: _ink,
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
                    ),
                    onPressed: _showEditProfileModal, // Memanggil modal edit profil
                    child: const Text('Edit Profil', style: TextStyle(fontWeight: FontWeight.w600)),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  height: 44,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: _danger,
                      backgroundColor: Colors.white,
                      side: const BorderSide(color: _border),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
                    ),
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
                    },
                    child: const Text('Keluar (Logout)', style: TextStyle(fontWeight: FontWeight.w600)),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: const Color(0xFFF0F2F2),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Icon(icon, color: _navy2, size: 22),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(color: _muted, fontSize: 12)),
              const SizedBox(height: 2),
              Text(value, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15, color: _ink)),
            ],
          ),
        ),
      ],
    );
  }
}
