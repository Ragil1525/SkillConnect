import 'package:flutter/material.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  // Palet Warna Tema Amazon
  static const Color amazonNavy = Color(0xFF131921);       // Sidebar & Header
  static const Color amazonNavyLight = Color(0xFF232F3E);  // Menu Aktif / Sub-header
  static const Color amazonOrange = Color(0xFFFF9900);     // Tombol Aksen & Highlight
  static const Color amazonBg = Color(0xFFEAEDED);         // Latar Belakang Utama
  static const Color amazonTextDark = Color(0xFF0F1111);   // Teks Utama

  int _selectedMenuIndex = 0;

  @override
  Widget build(BuildContext context) {
    // Mengecek apakah layar menggunakan tampilan desktop/tablet lebar
    final bool isDesktop = MediaQuery.of(context).size.width >= 850;

    return Scaffold(
      backgroundColor: amazonBg,
      // Top Navigation Bar
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        titleSpacing: 24,
        title: const Text(
          'SkillConnect',
          style: TextStyle(
            color: amazonNavy,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 24.0),
            child: Center(
              child: Text(
                'Admin',
                style: TextStyle(
                  color: amazonNavy,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
      drawer: !isDesktop ? _buildSidebar() : null,
      body: Row(
        children: [
          // Sidebar Navigasi (Tampil permanen jika layar Desktop)
          if (isDesktop) _buildSidebar(),

          // Area Konten Utama Dashboard
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(28.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Judul & Sub-judul
                  const Text(
                    'Dashboard Admin',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: amazonTextDark,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Pantau aktivitas utama dan performa SkillConnect',
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                  const SizedBox(height: 24),

                  // 4 Kartu Statistik (Stat Cards Row)
                  LayoutBuilder(
                    builder: (context, constraints) {
                      double cardWidth = constraints.maxWidth > 900
                          ? (constraints.maxWidth - 48) / 4
                          : (constraints.maxWidth - 16) / 2;

                      return Wrap(
                        spacing: 16,
                        runSpacing: 16,
                        children: [
                          _buildStatCard('Total pengguna', '1.248', cardWidth),
                          _buildStatCard('Pesanan aktif', '86', cardWidth),
                          _buildStatCard('Transaksi', 'Rp24,8 jt', cardWidth, isOrangeText: true),
                          _buildStatCard('Perlu ditinjau', '12', cardWidth),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 28),

                  // Container Tabel Data
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header Tabel: Judul & Tombol Tambah
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Daftar data',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: amazonTextDark,
                              ),
                            ),
                            ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: amazonNavy,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () {},
                              icon: const Icon(Icons.add, size: 18, color: amazonOrange),
                              label: const Text(
                                'Tambah data',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),

                        // Header Kolom Tabel
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF2F4F8),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Row(
                            children: const [
                              Expanded(flex: 3, child: Text('Nama / ID', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: amazonNavy))),
                              Expanded(flex: 4, child: Text('Informasi', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: amazonNavy))),
                              Expanded(flex: 2, child: Text('Status', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: amazonNavy))),
                              SizedBox(width: 40, child: Text('Aksi', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: amazonNavy))),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),

                        // Baris Data Tabel
                        _buildTableRow('Ringkasan pengguna', 'Pendaftaran dan status akun', 'Aktif'),
                        const Divider(),
                        _buildTableRow('Ringkasan pesanan', 'Pesanan aktif dan selesai', 'Aktif'),
                        const Divider(),
                        _buildTableRow('Transaksi terbaru', 'Pembayaran, komisi, dan payout', 'Aktif'),
                        const Divider(),
                        _buildTableRow('Pusat perhatian', 'Pengaduan yang perlu ditinjau', 'Aktif'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget Sidebar Kiri
  Widget _buildSidebar() {
    return Container(
      width: 240,
      color: amazonNavy,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 20, top: 24, bottom: 12),
            child: Text(
              'MENU UTAMA',
              style: TextStyle(
                color: Colors.white38,
                fontSize: 11,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
          ),
          _buildSidebarMenuItem(0, 'Dashboard'),
          _buildSidebarMenuItem(1, 'Pengguna', route: '/admin-users'),
          _buildSidebarMenuItem(2, 'Kategori', route: '/admin-categories'),
          _buildSidebarMenuItem(3, 'Transaksi', route: '/admin-commission'),
          _buildSidebarMenuItem(4, 'Pengaturan'),
        ],
      ),
    );
  }

  // Item Navigasi Sidebar
  Widget _buildSidebarMenuItem(int index, String title, {String? route}) {
    bool isSelected = _selectedMenuIndex == index;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () {
            setState(() {
              _selectedMenuIndex = index;
            });
            if (route != null) {
              Navigator.pushNamed(context, route);
            }
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: isSelected ? amazonNavyLight : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
              border: isSelected ? const Border(left: BorderSide(color: amazonOrange, width: 4)) : null,
            ),
            child: Text(
              title,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.white70,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                fontSize: 14,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Widget Kartu Ringkasan (Stat Card)
  Widget _buildStatCard(String title, String value, double width, {bool isOrangeText = false}) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(color: Colors.grey, fontSize: 13, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: isOrangeText ? amazonOrange : amazonTextDark,
            ),
          ),
        ],
      ),
    );
  }

  // Widget Baris Tabel Data
  Widget _buildTableRow(String name, String info, String status) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: amazonNavy),
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              info,
              style: const TextStyle(color: Colors.grey, fontSize: 13),
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE6F4EA),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    status,
                    style: const TextStyle(
                      color: Color(0xFF137333),
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 40,
            child: IconButton(
              icon: const Icon(Icons.more_horiz, color: Colors.grey),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}