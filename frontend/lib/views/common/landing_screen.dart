import 'package:flutter/material.dart';

// Palet bergaya marketplace (terinspirasi Amazon)
const _navy = Color(0xFF131921);
const _navy2 = Color(0xFF232F3E);
const _navy3 = Color(0xFF37475A);
const _orange = Color(0xFFFF9900);
const _orangeSoft = Color(0xFFFFD814);
const _pageBg = Color(0xFFEAEDED);
const _ink = Color(0xFF0F1111);
const _link = Color(0xFF007185);

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  final ScrollController _scroll = ScrollController();
  final GlobalKey _howItWorksKey = GlobalKey();

  String _category = 'Semua kategori';
  String _location = 'Semua lokasi';

  static const _categories = ['Semua kategori', 'Desain Grafis', 'Fotografi', 'Pendidikan'];
  static const _locations = ['Semua lokasi', 'Jakarta', 'Bandung', 'Padang'];

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  void _goSearch() => Navigator.pushNamed(context, '/catalog-search');

  void _scrollToHowItWorks() {
    final ctx = _howItWorksKey.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(ctx, duration: const Duration(milliseconds: 400), curve: Curves.easeOut);
    }
  }

  Widget _contained(Widget child) => Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1400),
          child: Padding(padding: const EdgeInsets.symmetric(horizontal: 24), child: child),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _pageBg,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(104),
        child: Material(
          color: _navy,
          child: Column(children: [_buildTopBar(context), _buildSubNav()]),
        ),
      ),
      body: SingleChildScrollView(
        controller: _scroll,
        child: Column(
          children: [
            _buildHero(),
            const SizedBox(height: 24),
            _contained(_buildCategoryCards()),
            const SizedBox(height: 24),
            _contained(_buildFeaturedServices()),
            const SizedBox(height: 24),
            _contained(_buildHowItWorks()),
            const SizedBox(height: 24),
            _contained(_buildProviderCta()),
            const SizedBox(height: 32),
            _buildBackToTop(),
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  // ---------- Header ----------
  Widget _buildTopBar(BuildContext context) {
    final wide = MediaQuery.of(context).size.width > 900;
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          InkWell(
            onTap: () {},
            child: const Padding(
              padding: EdgeInsets.all(8),
              child: Text.rich(
                TextSpan(children: [
                  TextSpan(text: 'Skill', style: TextStyle(color: Colors.white)),
                  TextSpan(text: 'Connect', style: TextStyle(color: _orange)),
                ]),
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          if (wide) ...[
            const SizedBox(width: 8),
            PopupMenuButton<String>(
              tooltip: 'Pilih lokasi',
              onSelected: (v) => setState(() => _location = v),
              itemBuilder: (_) => _locations.map((l) => PopupMenuItem(value: l, child: Text(l))).toList(),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    const Icon(Icons.location_on_outlined, color: Colors.white, size: 22),
                    const SizedBox(width: 4),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Lokasi', style: TextStyle(color: Color(0xFFCCCCCC), fontSize: 11)),
                        Text(_location,
                            style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
          const SizedBox(width: 12),
          Expanded(child: _buildSearchBar(wide)),
          const SizedBox(width: 12),
          InkWell(
            onTap: () => Navigator.pushNamed(context, '/login'),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Halo, Masuk', style: TextStyle(color: Color(0xFFCCCCCC), fontSize: 11)),
                  Text('Akun Saya', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, '/register'),
            style: ElevatedButton.styleFrom(
              backgroundColor: _orange,
              foregroundColor: _ink,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: const Text('Daftar', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(bool wide) {
    return Container(
      height: 44,
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
      clipBehavior: Clip.antiAlias,
      child: Row(
        children: [
          if (wide)
            Container(
              color: const Color(0xFFE6E6E6),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _category,
                  isDense: true,
                  style: const TextStyle(fontSize: 13, color: Color(0xFF555555)),
                  items: _categories.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                  onChanged: (v) => setState(() => _category = v ?? _category),
                ),
              ),
            ),
          Expanded(
            child: TextField(
              onSubmitted: (_) => _goSearch(),
              decoration: const InputDecoration(
                hintText: 'Cari jasa: desain logo, jasa privat...',
                hintStyle: TextStyle(fontSize: 14),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 14),
              ),
            ),
          ),
          InkWell(
            onTap: _goSearch,
            child: Container(
              width: 52,
              height: 44,
              color: _orange,
              child: const Icon(Icons.search, color: _ink),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubNav() {
    Widget item(String label, VoidCallback onTap, {IconData? icon, bool bold = false}) {
      return InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Center(
            child: Row(children: [
              if (icon != null) ...[Icon(icon, color: Colors.white, size: 20), const SizedBox(width: 6)],
              Text(label,
                  style: TextStyle(
                      color: Colors.white, fontSize: 14, fontWeight: bold ? FontWeight.bold : FontWeight.normal)),
            ]),
          ),
        ),
      );
    }

    return Container(
      height: 40,
      color: _navy2,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(children: [
          item('Semua', _goSearch, icon: Icons.menu, bold: true),
          item('Beranda', () {}, bold: true),
          item('Jelajahi Jasa', _goSearch),
          item('Cara Kerja', _scrollToHowItWorks),
          item('Desain Grafis', _goSearch),
          item('Fotografi', _goSearch),
          item('Pendidikan', _goSearch),
          item('Perbaikan', _goSearch),
          item('Daftarkan Jasa', () => Navigator.pushNamed(context, '/provider-activate'), bold: true),
        ]),
      ),
    );
  }

  // ---------- Hero ----------
  Widget _buildHero() {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [_navy2, _navy3],
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 56),
      child: _contained(
        LayoutBuilder(builder: (context, c) {
          final showVisual = c.maxWidth > 800;
          return Row(
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Temukan Jasa yang Tepat,\nWujudkan Kebutuhanmu.',
                      style: TextStyle(fontSize: 38, fontWeight: FontWeight.bold, color: Colors.white, height: 1.2),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Terhubung dengan penyedia jasa untuk berbagai kebutuhan. Cari layanan, bandingkan, pesan, dan pantau pekerjaan di satu tempat.',
                      style: TextStyle(fontSize: 16, color: Color(0xFFD5DBDB), height: 1.5),
                    ),
                    const SizedBox(height: 28),
                    Wrap(spacing: 16, runSpacing: 12, children: [
                      ElevatedButton(
                        onPressed: _goSearch,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _orangeSoft,
                          foregroundColor: _ink,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                        ),
                        child: const Text('Cari Jasa Sekarang', style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      OutlinedButton(
                        onPressed: () => Navigator.pushNamed(context, '/provider-activate'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white,
                          side: const BorderSide(color: Colors.white54),
                          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                        ),
                        child: const Text('Daftarkan Jasa', style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ]),
                  ],
                ),
              ),
              if (showVisual) ...[
                const SizedBox(width: 40),
                Expanded(
                  flex: 2,
                  child: GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 1.6,
                    children: const [
                      _HeroTile(icon: Icons.design_services, label: 'Desain Grafis'),
                      _HeroTile(icon: Icons.camera_alt, label: 'Fotografi'),
                      _HeroTile(icon: Icons.school, label: 'Pendidikan'),
                      _HeroTile(icon: Icons.handyman, label: 'Perbaikan'),
                    ],
                  ),
                ),
              ],
            ],
          );
        }),
      ),
    );
  }

  // ---------- Kartu kategori ----------
  Widget _buildCategoryCards() {
    final cards = <Widget>[
      const _CategoryCard(title: 'Kreatif & Desain', items: [
        _Cat(Icons.design_services, 'Desain Grafis'),
        _Cat(Icons.video_collection, 'Video & Editing'),
        _Cat(Icons.camera_alt, 'Fotografi'),
        _Cat(Icons.edit_note, 'Penulisan'),
      ]),
      const _CategoryCard(title: 'Belajar & Pendidikan', items: [
        _Cat(Icons.school, 'Les Privat'),
        _Cat(Icons.translate, 'Bahasa'),
        _Cat(Icons.calculate, 'Matematika'),
        _Cat(Icons.menu_book, 'Persiapan Ujian'),
      ]),
      const _CategoryCard(title: 'Perbaikan & Rumah', items: [
        _Cat(Icons.handyman, 'Perbaikan'),
        _Cat(Icons.home_repair_service, 'Rumah Tangga'),
        _Cat(Icons.electrical_services, 'Listrik'),
        _Cat(Icons.plumbing, 'Pipa & Air'),
      ]),
      const _CategoryCard(title: 'Jelajahi Semua Kategori', items: [
        _Cat(Icons.grid_view, 'Lihat Semua'),
        _Cat(Icons.star_border, 'Terpopuler'),
        _Cat(Icons.local_offer_outlined, 'Harga Hemat'),
        _Cat(Icons.location_on_outlined, 'Di Dekatmu'),
      ]),
    ];

    return LayoutBuilder(builder: (context, c) {
      final cols = c.maxWidth > 1000 ? 4 : (c.maxWidth > 600 ? 2 : 1);
      return GridView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: cols,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          mainAxisExtent: 400,
        ),
        children: cards,
      );
    });
  }

  // ---------- Jasa populer ----------
  Widget _buildFeaturedServices() {
    const services = [
      _Service('Desain logo & identitas brand', 'Rani Studio', 4.9, 128, 'Rp 250.000', 'Padang',
          Icons.design_services, Color(0xFFDBEAFE)),
      _Service('Foto produk untuk toko online', 'Fajar Visual', 4.8, 96, 'Rp 150.000', 'Jakarta',
          Icons.camera_alt, Color(0xFFFDE68A)),
      _Service('Les privat matematika SMA', 'Bu Dinda', 4.9, 210, 'Rp 80.000', 'Bandung',
          Icons.school, Color(0xFFBBF7D0)),
      _Service('Perbaikan AC & kulkas', 'Teknik Mandiri', 4.7, 74, 'Rp 120.000', 'Padang',
          Icons.handyman, Color(0xFFFECACA)),
      _Service('Edit video Reels & TikTok', 'Klip Kreatif', 4.8, 152, 'Rp 100.000', 'Jakarta',
          Icons.video_collection, Color(0xFFE9D5FF)),
      _Service('Penulisan artikel SEO', 'Naya Writes', 4.6, 61, 'Rp 75.000', 'Bandung',
          Icons.edit_note, Color(0xFFCFFAFE)),
    ];

    return _Panel(
      title: 'Jasa populer minggu ini',
      trailing: InkWell(
        onTap: _goSearch,
        child: const Text('Lihat semua', style: TextStyle(color: _link, fontSize: 14)),
      ),
      child: SizedBox(
        height: 310,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: services.length,
          separatorBuilder: (_, __) => const SizedBox(width: 16),
          itemBuilder: (_, i) => _ServiceCard(service: services[i], onTap: _goSearch),
        ),
      ),
    );
  }

  // ---------- Cara kerja ----------
  Widget _buildHowItWorks() {
    const steps = [
      _Step(Icons.search, 'Cari', 'Temukan layanan sesuai kebutuhan dari berbagai kategori dan lokasi.'),
      _Step(Icons.compare_arrows, 'Bandingkan', 'Lihat harga, ulasan, dan profil penyedia jasa sebelum memutuskan.'),
      _Step(Icons.shopping_bag_outlined, 'Pesan', 'Pilih penyedia jasa yang cocok dan kirim pesananmu.'),
      _Step(Icons.track_changes, 'Pantau', 'Ikuti perkembangan pekerjaan sampai selesai di satu tempat.'),
    ];

    return Container(
      key: _howItWorksKey,
      child: _Panel(
        title: 'Cara kerja SkillConnect',
        child: LayoutBuilder(builder: (context, c) {
          final cols = c.maxWidth > 1000 ? 4 : (c.maxWidth > 600 ? 2 : 1);
          final w = (c.maxWidth - (cols - 1) * 24) / cols;
          return Wrap(
            spacing: 24,
            runSpacing: 24,
            children: [
              for (var i = 0; i < steps.length; i++)
                SizedBox(
                  width: w,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundColor: _navy2,
                        child: Icon(steps[i].icon, color: _orange),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${i + 1}. ${steps[i].title}',
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: _ink)),
                            const SizedBox(height: 4),
                            Text(steps[i].desc,
                                style: const TextStyle(fontSize: 14, color: Color(0xFF565959), height: 1.4)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          );
        }),
      ),
    );
  }

  // ---------- Ajakan untuk penyedia jasa ----------
  Widget _buildProviderCta() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.center,
        runSpacing: 16,
        spacing: 24,
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 640),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Punya keahlian? Tawarkan jasamu di SkillConnect.',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: _ink)),
                SizedBox(height: 8),
                Text('Daftarkan jasamu dan jangkau orang-orang yang sedang mencari layanan seperti yang kamu tawarkan.',
                    style: TextStyle(fontSize: 15, color: Color(0xFF565959), height: 1.4)),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, '/provider-activate'),
            style: ElevatedButton.styleFrom(
              backgroundColor: _orangeSoft,
              foregroundColor: _ink,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
            ),
            child: const Text('Daftarkan Jasa', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  // ---------- Footer ----------
  Widget _buildBackToTop() {
    return InkWell(
      onTap: () => _scroll.animateTo(0, duration: const Duration(milliseconds: 400), curve: Curves.easeOut),
      child: Container(
        width: double.infinity,
        height: 48,
        color: _navy3,
        alignment: Alignment.center,
        child: const Text('Kembali ke atas', style: TextStyle(color: Colors.white, fontSize: 13)),
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      width: double.infinity,
      color: _navy2,
      padding: const EdgeInsets.only(top: 40, bottom: 24),
      child: _contained(
        Column(
          children: [
            Wrap(
              spacing: 80,
              runSpacing: 24,
              children: [
                _FooterColumn(title: 'Kenali SkillConnect', links: [
                  _FooterLink('Cara Kerja', _scrollToHowItWorks),
                ]),
                _FooterColumn(title: 'Untuk pencari jasa', links: [
                  _FooterLink('Jelajahi Jasa', _goSearch),
                  _FooterLink('Masuk', () => Navigator.pushNamed(context, '/login')),
                  _FooterLink('Daftar', () => Navigator.pushNamed(context, '/register')),
                ]),
                _FooterColumn(title: 'Untuk penyedia jasa', links: [
                  _FooterLink('Daftarkan Jasa', () => Navigator.pushNamed(context, '/provider-activate')),
                ]),
              ],
            ),
            const SizedBox(height: 32),
            const Divider(color: Colors.white24),
            const SizedBox(height: 12),
            const Text('© 2026 SkillConnect', style: TextStyle(color: Color(0xFFCCCCCC), fontSize: 12)),
          ],
        ),
      ),
    );
  }
}

// ================== Widget pendukung ==================

class _HeroTile extends StatelessWidget {
  final IconData icon;
  final String label;
  const _HeroTile({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white24),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: _orange, size: 36),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

class _Cat {
  final IconData icon;
  final String label;
  const _Cat(this.icon, this.label);
}

class _CategoryCard extends StatelessWidget {
  final String title;
  final List<_Cat> items;
  const _CategoryCard({required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold, color: _ink)),
          const SizedBox(height: 14),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.05,
              children: [
                for (final it in items)
                  InkWell(
                    onTap: () => Navigator.pushNamed(context, '/catalog-search'),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF0F2F2),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Icon(it.icon, size: 40, color: _navy2),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(it.label,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 12, color: _ink)),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          InkWell(
            onTap: () => Navigator.pushNamed(context, '/catalog-search'),
            child: const Text('Lihat selengkapnya', style: TextStyle(color: _link, fontSize: 14)),
          ),
        ],
      ),
    );
  }
}

class _Panel extends StatelessWidget {
  final String title;
  final Widget? trailing;
  final Widget child;
  const _Panel({required this.title, this.trailing, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(title, style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold, color: _ink)),
              const SizedBox(width: 16),
              if (trailing != null) trailing!,
            ],
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }
}

class _Service {
  final String title, provider, price, city;
  final double rating;
  final int reviews;
  final IconData icon;
  final Color color;
  const _Service(this.title, this.provider, this.rating, this.reviews, this.price, this.city, this.icon, this.color);
}

class _ServiceCard extends StatelessWidget {
  final _Service service;
  final VoidCallback onTap;
  const _ServiceCard({required this.service, required this.onTap});

  Widget _stars(double rating) {
    final full = rating.floor();
    final half = (rating - full) >= 0.5;
    return Row(
      children: [
        for (var i = 0; i < 5; i++)
          Icon(
            i < full ? Icons.star : (i == full && half ? Icons.star_half : Icons.star_border),
            size: 16,
            color: _orange,
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: 220,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 140,
              width: double.infinity,
              decoration: BoxDecoration(color: service.color, borderRadius: BorderRadius.circular(4)),
              child: Icon(service.icon, size: 56, color: _navy2),
            ),
            const SizedBox(height: 10),
            Text(service.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 14, color: _ink, height: 1.3)),
            const SizedBox(height: 2),
            Text(service.provider, style: const TextStyle(fontSize: 12, color: Color(0xFF565959))),
            const SizedBox(height: 6),
            Row(children: [
              _stars(service.rating),
              const SizedBox(width: 6),
              Text('${service.reviews}', style: const TextStyle(fontSize: 12, color: _link)),
            ]),
            const SizedBox(height: 6),
            Text('Mulai ${service.price}',
                style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: _ink)),
            const SizedBox(height: 2),
            Text(service.city, style: const TextStyle(fontSize: 12, color: Color(0xFF565959))),
          ],
        ),
      ),
    );
  }
}

class _Step {
  final IconData icon;
  final String title, desc;
  const _Step(this.icon, this.title, this.desc);
}

class _FooterLink {
  final String label;
  final VoidCallback onTap;
  const _FooterLink(this.label, this.onTap);
}

class _FooterColumn extends StatelessWidget {
  final String title;
  final List<_FooterLink> links;
  const _FooterColumn({required this.title, required this.links});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 12),
        for (final l in links)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: InkWell(
              onTap: l.onTap,
              child: Text(l.label, style: const TextStyle(color: Color(0xFFDDDDDD), fontSize: 14)),
            ),
          ),
      ],
    );
  }
}
