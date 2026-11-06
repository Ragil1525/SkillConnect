import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Palet yang sama dengan LandingScreen, LoginScreen, NotificationScreen, dan ProfileScreen
const _navy = Color(0xFF131921);
const _orange = Color(0xFFFF9900);
const _orangeSoft = Color(0xFFFFD814);
const _pageBg = Color(0xFFEAEDED);
const _ink = Color(0xFF0F1111);
const _muted = Color(0xFF565959);
const _link = Color(0xFF007185);
const _border = Color(0xFFD5D9D9);

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _obscure = true;

  // Ganti dengan endpoint register backend kamu
  final String apiUrl = 'http://localhost:3000/api/auth/register';

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    setState(() => _isLoading = true);

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': _nameController.text.trim(),
          'email': _emailController.text.trim(),
          'password': _passwordController.text.trim(),
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 201 || response.statusCode == 200) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registrasi Berhasil! Silakan Login.')),
        );

        // Mengarahkan ke halaman login secara aman dan mengganti tumpukan layar
        Navigator.pushReplacementNamed(context, '/login');
      } else {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data['message'] ?? 'Registrasi gagal')),
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Terjadi kesalahan koneksi: $e')),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  InputDecoration _fieldDecoration({Widget? suffix}) {
    OutlineInputBorder border(Color color, [double width = 1]) => OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(color: color, width: width),
        );
    return InputDecoration(
      isDense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      border: border(const Color(0xFF888C8C)),
      enabledBorder: border(const Color(0xFF888C8C)),
      focusedBorder: border(_orange, 2),
      suffixIcon: suffix,
    );
  }

  Widget _label(String text) => Padding(
        padding: const EdgeInsets.only(bottom: 6),
        child: Text(text, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: _ink)),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 380),
                    child: Column(
                      children: [
                        // Logo
                        InkWell(
                          onTap: () => Navigator.maybePop(context),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                            child: Text.rich(
                              TextSpan(children: [
                                TextSpan(text: 'Skill', style: TextStyle(color: _navy)),
                                TextSpan(text: 'Connect', style: TextStyle(color: _orange)),
                              ]),
                              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Kartu form
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: _border),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Buat Akun Baru',
                                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500, color: _ink)),
                              const SizedBox(height: 4),
                              const Text('Cari dan tawarkan jasa di satu tempat.',
                                  style: TextStyle(fontSize: 14, color: _muted)),
                              const SizedBox(height: 20),
                              _label('Nama Lengkap'),
                              TextField(
                                controller: _nameController,
                                textCapitalization: TextCapitalization.words,
                                textInputAction: TextInputAction.next,
                                decoration: _fieldDecoration(),
                              ),
                              const SizedBox(height: 16),
                              _label('Email'),
                              TextField(
                                controller: _emailController,
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                decoration: _fieldDecoration(),
                              ),
                              const SizedBox(height: 16),
                              _label('Password'),
                              TextField(
                                controller: _passwordController,
                                obscureText: _obscure,
                                onSubmitted: (_) => _isLoading ? null : _register(),
                                decoration: _fieldDecoration(
                                  suffix: IconButton(
                                    icon: Icon(_obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                                        size: 20, color: _muted),
                                    tooltip: _obscure ? 'Tampilkan password' : 'Sembunyikan password',
                                    onPressed: () => setState(() => _obscure = !_obscure),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 24),
                              SizedBox(
                                width: double.infinity,
                                height: 44,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: _orangeSoft,
                                    foregroundColor: _ink,
                                    disabledBackgroundColor: const Color(0xFFFFE680),
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
                                  ),
                                  onPressed: _isLoading ? null : _register,
                                  child: _isLoading
                                      ? const SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: CircularProgressIndicator(strokeWidth: 2.5, color: _ink),
                                        )
                                      : const Text('Daftar', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Pemisah + ajakan masuk
                        const SizedBox(height: 24),
                        Row(
                          children: const [
                            Expanded(child: Divider(color: _border)),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              child: Text('Sudah punya akun?', style: TextStyle(fontSize: 12, color: _muted)),
                            ),
                            Expanded(child: Divider(color: _border)),
                          ],
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          height: 40,
                          child: OutlinedButton(
                            onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: _ink,
                              side: const BorderSide(color: _border),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            ),
                            child: const Text('Masuk ke akun SkillConnect'),
                          ),
                        ),
                        const SizedBox(height: 12),
                        TextButton(
                          onPressed: () => Navigator.pushNamed(context, '/provider-activate'),
                          child: const Text('Punya keahlian? Daftarkan jasamu',
                              style: TextStyle(color: _link, fontSize: 13)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Footer tipis
            Container(
              width: double.infinity,
              color: _pageBg,
              padding: const EdgeInsets.symmetric(vertical: 14),
              child: const Text('© 2026 SkillConnect',
                  textAlign: TextAlign.center, style: TextStyle(fontSize: 12, color: _muted)),
            ),
          ],
        ),
      ),
    );
  }
}
