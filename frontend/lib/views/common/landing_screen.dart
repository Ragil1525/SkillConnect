import 'package:flutter/material.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Padding(
          padding: EdgeInsets.only(left: 16.0),
          child: Text(
            'SkillConnect',
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Sudah berada di halaman Beranda
            },
            child: const Text('Beranda', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600)),
          ),
          TextButton(
            onPressed: () => Navigator.pushNamed(context, '/catalog-search'),
            child: const Text('Jelajahi Jasa', style: TextStyle(color: Colors.black54)),
          ),
          TextButton(
            onPressed: () {
              // Bisa diarahkan ke bagian cara kerja atau info aplikasi jika ada
            },
            child: const Text('Cara Kerja', style: TextStyle(color: Colors.black54)),
          ),
          const SizedBox(width: 20),
          OutlinedButton(
            onPressed: () => Navigator.pushNamed(context, '/login'),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Colors.blue),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
            child: const Text('Masuk', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(width: 10),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, '/register'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1E293B),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
            child: const Text('Daftar', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(width: 24),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 64, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Hero Section
              Container(
                padding: const EdgeInsets.all(40),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Temukan Jasa yang Tepat,\nWujudkan Kebutuhanmu.',
                            style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0F172A),
                              height: 1.2,
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Terhubung dengan penyedia jasa untuk berbagai kebutuhan.\nCari layanan, bandingkan, pesan, dan pantau pekerjaan di satu tempat.',
                            style: TextStyle(fontSize: 16, color: Colors.grey, height: 1.5),
                          ),
                          const SizedBox(height: 24),
                          Row(
                            children: [
                              ElevatedButton(
                                onPressed: () => Navigator.pushNamed(context, '/catalog-search'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF1E293B),
                                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                ),
                                child: const Text('Cari Jasa Sekarang', style: TextStyle(color: Colors.white)),
                              ),
                              const SizedBox(width: 16),
                              OutlinedButton(
                                onPressed: () => Navigator.pushNamed(context, '/provider-activate'),
                                style: OutlinedButton.styleFrom(
                                  side: const BorderSide(color: Colors.blue),
                                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                ),
                                child: const Text('Daftarkan Jasa', style: TextStyle(color: Colors.blue)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        height: 220,
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.blue.shade100),
                        ),
                        child: const Center(
                          child: Text(
                            'SKILLCONNECT',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                              letterSpacing: 2,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // 2. Search Filter Bar
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.08),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'Cari jasa yang kamu butuhkan',
                          hintText: 'Contoh: desain logo, jasa privat...',
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.search, color: Colors.blue),
                        ),
                      ),
                    ),
                    Container(height: 40, child: const VerticalDivider(color: Colors.grey)),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                            labelText: 'Kategori',
                            border: InputBorder.none,
                          ),
                          value: 'Semua kategori',
                          items: ['Semua kategori', 'Desain Grafis', 'Fotografi', 'Pendidikan']
                              .map((cat) => DropdownMenuItem(value: cat, child: Text(cat)))
                              .toList(),
                          onChanged: (val) {},
                        ),
                      ),
                    ),
                    Container(height: 40, child: const VerticalDivider(color: Colors.grey)),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                            labelText: 'Lokasi',
                            border: InputBorder.none,
                          ),
                          value: 'Semua lokasi',
                          items: ['Semua lokasi', 'Jakarta', 'Bandung', 'Padang']
                              .map((loc) => DropdownMenuItem(value: loc, child: Text(loc)))
                              .toList(),
                          onChanged: (val) {},
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton(
                      onPressed: () => Navigator.pushNamed(context, '/catalog-search'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1E293B),
                        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: const Text('Cari Jasa', style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),

              // 3. Jelajahi Berdasarkan Kategori
              const Text(
                'Jelajahi Berdasarkan Kategori',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
              ),
              const SizedBox(height: 16),
              GridView.count(
                crossAxisCount: 4,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 3.8,
                children: const [
                  _CategoryItem(icon: Icons.design_services, title: 'Desain Grafis'),
                  _CategoryItem(icon: Icons.camera_alt, title: 'Fotografi'),
                  _CategoryItem(icon: Icons.school, title: 'Pendidikan'),
                  _CategoryItem(icon: Icons.handyman, title: 'Perbaikan'),
                  _CategoryItem(icon: Icons.video_collection, title: 'Video & Editing'),
                  _CategoryItem(icon: Icons.edit_note, title: 'Penulisan'),
                  _CategoryItem(icon: Icons.home_repair_service, title: 'Rumah Tangga'),
                  _CategoryItem(icon: Icons.grid_view, title: 'Lihat Semua'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CategoryItem extends StatelessWidget {
  final IconData icon;
  final String title;

  const _CategoryItem({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, '/catalog-search'),
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.blue),
            const SizedBox(width: 12),
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: Color(0xFF334155)),
            ),
          ],
        ),
      ),
    );
  }
}