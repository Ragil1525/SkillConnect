import 'package:flutter/material.dart';

class UserManagementScreen extends StatefulWidget {
  const UserManagementScreen({super.key});

  @override
  State<UserManagementScreen> createState() => _UserManagementScreenState();
}

class _UserManagementScreenState extends State<UserManagementScreen> {
  // Palet Warna Tema Amazon
  static const Color amazonNavy = Color(0xFF131921);       // Sidebar & Header
  static const Color amazonNavyLight = Color(0xFF232F3E);  // Menu Aktif / Sub-header
  static const Color amazonOrange = Color(0xFFFF9900);     // Tombol Aksen & Highlight
  static const Color amazonBg = Color(0xFFEAEDED);         // Latar Belakang Utama
  static const Color amazonTextDark = Color(0xFF0F1111);   // Teks Utama

  // Menu terpilih (Index 1 = Pengguna)
  int _selectedMenuIndex = 1;

  // Data Dummy Pengguna sesuai Mockup
  final List<Map<String, String>> _users = [
    {'id': 'USR-001', 'name': 'Andi', 'role': 'Customer', 'email': 'andi@email.com', 'status': 'Aktif'},
    {'id': 'USR-002', 'name': 'Bima', 'role': 'Provider', 'email': 'bima@email.com', 'status': 'Aktif'},
    {'id': 'USR-003', 'name': 'Citra', 'role': 'Customer', 'email': 'citra@email.com', 'status': 'Aktif'},
    {'id': 'USR-004', 'name': 'Deni', 'role': 'Provider', 'email': 'deni@email.com', 'status': 'Aktif'},
  ];

  void _toggleStatus(int index) {
    setState(() {
      _users[index]['status'] = _users[index]['status'] == 'Aktif' ? 'Diblokir' : 'Aktif';
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Status pengguna berhasil diperbarui.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = MediaQuery.of(context).size.width >= 850;

    return Scaffold(
      backgroundColor: amazonBg,
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
          // Sidebar Navigasi permanen untuk layar Desktop
          if (isDesktop) _buildSidebar(),

          // Area Konten Utama
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(28.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Judul & Sub-judul Halaman
                  const Text(
                    'Manajemen Pengguna',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: amazonTextDark,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Kelola akun Customer dan Provider',
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

                  // Container Tabel Data Pengguna
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
                        // Header Tabel: Judul & Tombol Tambah Data
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

                        // Sub-header Kolom Tabel
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

                        // Baris Data Pengguna
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _users.length,
                          separatorBuilder: (context, index) => const Divider(height: 1),
                          itemBuilder: (context, index) {
                            final user = _users[index];
                            return _buildUserTableRow(
                              index: index,
                              idAndName: '${user['id']} · ${user['name']}',
                              info: '${user['role']} · ${user['email']}',
                              status: user['status']!,
                            );
                          },
                        ),
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
          _buildSidebarMenuItem(0, 'Dashboard', route: '/admin-dashboard'),
          _buildSidebarMenuItem(1, 'Pengguna'),
          _buildSidebarMenuItem(2, 'Kategori', route: '/admin-categories'),
          _buildSidebarMenuItem(3, 'Transaksi', route: '/admin-commission'),
          _buildSidebarMenuItem(4, 'Pengaturan'),
        ],
      ),
    );
  }

  // Item Navigasi Sidebar (Index 1 Aktif untuk Pengguna)
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
              Navigator.pushReplacementNamed(context, route);
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

  // Widget Baris Tabel Data Pengguna
  Widget _buildUserTableRow({
    required int index,
    required String idAndName,
    required String info,
    required String status,
  }) {
    bool isActive = status == 'Aktif';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              idAndName,
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
                    color: isActive ? const Color(0xFFE6F4EA) : const Color(0xFFFCE8E6),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      color: isActive ? const Color(0xFF137333) : const Color(0xFFC5221F),
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
            child: PopupMenuButton<String>(
              icon: const Icon(Icons.more_horiz, color: Colors.grey),
              onSelected: (value) {
                if (value == 'status') {
                  _toggleStatus(index);
                }
              },
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 'status',
                  child: Text(isActive ? 'Blokir Pengguna' : 'Aktifkan Pengguna'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}