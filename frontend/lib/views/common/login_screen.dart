import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Palet yang sama dengan LandingScreen
const _navy = Color(0xFF131921);
const _navy2 = Color(0xFF232F3E);
const _orange = Color(0xFFFF9900);
const _orangeSoft = Color(0xFFFFD814);
const _pageBg = Color(0xFFEAEDED);
const _ink = Color(0xFF0F1111);
const _muted = Color(0xFF565959);
const _link = Color(0xFF007185);

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _obscure = true;

  // Ganti dengan endpoint login backend kamu
  final String apiUrl = 'http://localhost:3000/api/auth/login';

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    setState(() => _isLoading = true);

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': _emailController.text.trim(),
          'password': _passwordController.text.trim(),
        }),
      );

      final data = jsonDecode(response.body);

      // Wajib dicek setelah await untuk mengatasi async gaps
      if (!mounted) return;

      if (response.statusCode == 200) {
        debugPrint('DATA DARI BACKEND: $data');
        debugPrint('ROLE USER: ${data['user']?['role']}');

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login Berhasil!')),
        );

        String userRole = data['user']?['role'] ?? 'customer';

        // Menangani 'provider' maupun 'service_provider' agar aman
        if (userRole == 'provider' || userRole == 'service_provider') {
          Navigator.pushReplacementNamed(context, '/provider-dashboard');
        } else if (userRole == 'admin') {
          Navigator.pushReplacementNamed(context, '/admin-dashboard');
        } else {
          Navigator.pushReplacementNamed(context, '/customer-home');
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data['message'] ?? 'Login gagal')),
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
                            border: Border.all(color: const Color(0xFFD5D9D9)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Masuk',
                                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500, color: _ink)),
                              const SizedBox(height: 4),
                              const Text('Selamat datang kembali!',
                                  style: TextStyle(fontSize: 14, color: _muted)),
                              const SizedBox(height: 20),
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
                                onSubmitted: (_) => _isLoading ? null : _login(),
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
                                  onPressed: _isLoading ? null : _login,
                                  child: _isLoading
                                      ? const SizedBox(
                                          width: 20,
                                          height: 20,
                                          child: CircularProgressIndicator(strokeWidth: 2.5, color: _ink),
                                        )
                                      : const Text('Masuk', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Pemisah + ajakan daftar
                        const SizedBox(height: 24),
                        Row(
                          children: const [
                            Expanded(child: Divider(color: Color(0xFFD5D9D9))),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              child: Text('Baru di SkillConnect?', style: TextStyle(fontSize: 12, color: _muted)),
                            ),
                            Expanded(child: Divider(color: Color(0xFFD5D9D9))),
                          ],
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          height: 40,
                          child: OutlinedButton(
                            onPressed: () => Navigator.pushReplacementNamed(context, '/register'),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: _ink,
                              side: const BorderSide(color: Color(0xFFD5D9D9)),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            ),
                            child: const Text('Buat akun SkillConnect'),
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

            // Footer tipis seperti halaman masuk marketplace
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
