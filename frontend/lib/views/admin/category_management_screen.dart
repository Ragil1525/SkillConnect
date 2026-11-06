import 'package:flutter/material.dart';

class CategoryManagementScreen extends StatefulWidget {
  const CategoryManagementScreen({super.key});

  @override
  State<CategoryManagementScreen> createState() => _CategoryManagementScreenState();
}

class _CategoryManagementScreenState extends State<CategoryManagementScreen> {
  static const Color amazonNavy = Color(0xFF131921);
  static const Color amazonNavyLight = Color(0xFF232F3E);
  static const Color amazonOrange = Color(0xFFFF9900);
  static const Color amazonBg = Color(0xFFEAEDED);
  static const Color amazonTextDark = Color(0xFF0F1111);

  int _selectedMenuIndex = 2; // Index 2 = Kategori

  final List<Map<String, String>> _categories = [
    {'id': 'CAT-001', 'name': 'Desain Grafis', 'info': '12 layanan terdaftar', 'status': 'Aktif'},
    {'id': 'CAT-002', 'name': 'Fotografi', 'info': '8 layanan terdaftar', 'status': 'Aktif'},
    {'id': 'CAT-003', 'name': 'Pendidikan', 'info': '15 layanan terdaftar', 'status': 'Aktif'},
    {'id': 'CAT-004', 'name': 'Perbaikan', 'info': '6 layanan terdaftar', 'status': 'Aktif'},
  ];

  final _controller = TextEditingController();

  void _addCategoryDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Tambah Kategori Baru'),
          content: TextField(
            controller: _controller,
            decoration: const InputDecoration(hintText: 'Nama kategori...'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: amazonNavy, foregroundColor: Colors.white),
              onPressed: () {
                if (_controller.text.isNotEmpty) {
                  setState(() {
                    _categories.add({
                      'id': 'CAT-00${_categories.length + 1}',
                      'name': _controller.text,
                      'info': '0 layanan terdaftar',
                      'status': 'Aktif',
                    });
                    _controller.clear();
                  });
                  Navigator.pop(context);
                }
              },
              child: const Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  void _deleteCategory(int index) {
    setState(() {
      _categories.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Kategori berhasil dihapus.')),
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
          style: TextStyle(color: amazonNavy, fontWeight: FontWeight.bold, fontSize: 22),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 24.0),
            child: Center(
              child: Text('Admin', style: TextStyle(color: amazonNavy, fontWeight: FontWeight.w600, fontSize: 14)),
            ),
          ),
        ],
      ),
      drawer: !isDesktop ? _buildSidebar() : null,
      body: Row(
        children: [
          if (isDesktop) _buildSidebar(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(28.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Manajemen Kategori', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: amazonTextDark)),
                  const SizedBox(height: 4),
                  const Text('Atur kategori layanan yang tersedia', style: TextStyle(color: Colors.grey, fontSize: 14)),
                  const SizedBox(height: 24),
                  
                  // Statistik Cards
                  LayoutBuilder(
                    builder: (context, constraints) {
                      double cardWidth = constraints.maxWidth > 900 ? (constraints.maxWidth - 48) / 4 : (constraints.maxWidth - 16) / 2;
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

                  // Tabel Kontainer
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Daftar data', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: amazonTextDark)),
                            ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: amazonNavy,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              ),
                              onPressed: _addCategoryDialog,
                              icon: const Icon(Icons.add, size: 18, color: amazonOrange),
                              label: const Text('Tambah data', style: TextStyle(fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
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
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _categories.length,
                          separatorBuilder: (context, index) => const Divider(height: 1),
                          itemBuilder: (context, index) {
                            final cat = _categories[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                              child: Row(
                                children: [
                                  Expanded(flex: 3, child: Text('${cat['id']} · ${cat['name']}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: amazonNavy))),
                                  Expanded(flex: 4, child: Text(cat['info']!, style: const TextStyle(color: Colors.grey, fontSize: 13))),
                                  Expanded(
                                    flex: 2,
                                    child: Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                          decoration: BoxDecoration(color: const Color(0xFFE6F4EA), borderRadius: BorderRadius.circular(20)),
                                          child: Text(cat['status']!, style: const TextStyle(color: Color(0xFF137333), fontSize: 12, fontWeight: FontWeight.bold)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 40,
                                    child: PopupMenuButton<String>(
                                      icon: const Icon(Icons.more_horiz, color: Colors.grey),
                                      onSelected: (val) {
                                        if (val == 'delete') _deleteCategory(index);
                                      },
                                      itemBuilder: (context) => [
                                        const PopupMenuItem(value: 'delete', child: Text('Hapus Kategori', style: TextStyle(color: Colors.red))),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
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

  Widget _buildSidebar() {
    return Container(
      width: 240,
      color: amazonNavy,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 20, top: 24, bottom: 12),
            child: Text('MENU UTAMA', style: TextStyle(color: Colors.white38, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 1)),
          ),
          _buildSidebarMenuItem(0, 'Dashboard', route: '/admin-dashboard'),
          _buildSidebarMenuItem(1, 'Pengguna', route: '/admin-users'),
          _buildSidebarMenuItem(2, 'Kategori'),
          _buildSidebarMenuItem(3, 'Transaksi', route: '/admin-commission'),
          _buildSidebarMenuItem(4, 'Pengaturan'),
        ],
      ),
    );
  }

  Widget _buildSidebarMenuItem(int index, String title, {String? route}) {
    bool isSelected = _selectedMenuIndex == index;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () {
          setState(() => _selectedMenuIndex = index);
          if (route != null) Navigator.pushReplacementNamed(context, route);
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? amazonNavyLight : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: isSelected ? const Border(left: BorderSide(color: amazonOrange, width: 4)) : null,
          ),
          child: Text(title, style: TextStyle(color: isSelected ? Colors.white : Colors.white70, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal, fontSize: 14)),
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, double width, {bool isOrangeText = false}) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.grey.shade300)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(color: Colors.grey, fontSize: 13, fontWeight: FontWeight.w500)),
          const SizedBox(height: 10),
          Text(value, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: isOrangeText ? amazonOrange : amazonTextDark)),
        ],
      ),
    );
  }
}