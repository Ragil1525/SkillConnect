import 'package:flutter/material.dart';

// Palet yang sama dengan LandingScreen dan LoginScreen
const _navy = Color(0xFF131921);
const _navy2 = Color(0xFF232F3E);
const _orange = Color(0xFFFF9900);
const _orangeSoft = Color(0xFFFFD814);
const _pageBg = Color(0xFFEAEDED);
const _ink = Color(0xFF0F1111);
const _muted = Color(0xFF565959);
const _link = Color(0xFF007185);

enum _NotifType { pesanan, pesan, promo }

class _Notif {
  final _NotifType type;
  final String title;
  final String body;
  final String time;
  bool read;
  _Notif(this.type, this.title, this.body, this.time, {this.read = false});
}

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  _NotifType? _filter; // null = Semua

  // Data contoh. Ganti dengan data dari backend.
  final List<_Notif> _items = [
    _Notif(_NotifType.pesanan, 'Pesanan diterima penyedia jasa',
        'Pesanan "Desain logo & identitas brand" sudah diterima dan mulai dikerjakan.', '5 menit lalu'),
    _Notif(_NotifType.pesan, 'Pesan baru dari Rani Studio',
        'Halo, boleh kirim referensi warna yang kamu suka?', '1 jam lalu'),
    _Notif(_NotifType.pesanan, 'Pekerjaan selesai',
        'Pesanan "Foto produk untuk toko online" sudah selesai. Beri ulasanmu.', 'Kemarin',
        read: true),
    _Notif(_NotifType.promo, 'Jasa populer minggu ini',
        'Lihat jasa dengan rating tertinggi di kotamu.', '2 hari lalu',
        read: true),
  ];

  List<_Notif> get _visible =>
      _filter == null ? _items : _items.where((n) => n.type == _filter).toList();

  int get _unreadCount => _items.where((n) => !n.read).length;

  void _markAllRead() => setState(() {
        for (final n in _items) {
          n.read = true;
        }
      });

  IconData _iconFor(_NotifType t) {
    switch (t) {
      case _NotifType.pesanan:
        return Icons.shopping_bag_outlined;
      case _NotifType.pesan:
        return Icons.chat_bubble_outline;
      case _NotifType.promo:
        return Icons.local_offer_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _pageBg,
      appBar: AppBar(
        backgroundColor: _navy,
        foregroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            const Text('Notifikasi', style: TextStyle(fontWeight: FontWeight.bold)),
            if (_unreadCount > 0) ...[
              const SizedBox(width: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(color: _orange, borderRadius: BorderRadius.circular(10)),
                child: Text('$_unreadCount',
                    style: const TextStyle(color: _ink, fontSize: 12, fontWeight: FontWeight.bold)),
              ),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: _unreadCount == 0 ? null : _markAllRead,
            child: Text('Tandai semua dibaca',
                style: TextStyle(color: _unreadCount == 0 ? Colors.white38 : _orange)),
          ),
          const SizedBox(width: 8),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Container(
            color: _navy2,
            height: 48,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(children: [
                _tab('Semua', null),
                _tab('Pesanan', _NotifType.pesanan),
                _tab('Pesan', _NotifType.pesan),
                _tab('Promo', _NotifType.promo),
              ]),
            ),
          ),
        ),
      ),
      body: _visible.isEmpty ? _buildEmpty() : _buildList(),
    );
  }

  Widget _tab(String label, _NotifType? type) {
    final selected = _filter == type;
    return InkWell(
      onTap: () => setState(() => _filter = type),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: selected ? _orange : Colors.transparent, width: 3),
          ),
        ),
        child: Text(label,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: selected ? FontWeight.bold : FontWeight.normal,
            )),
      ),
    );
  }

  Widget _buildList() {
    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 800),
        child: ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: _visible.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (_, i) {
            final n = _visible[i];
            return InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: () => setState(() => n.read = true),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: n.read ? const Color(0xFFD5D9D9) : _orange),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 22,
                      backgroundColor: _navy2,
                      child: Icon(_iconFor(n.type), color: _orange, size: 22),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(n.title,
                              style: TextStyle(
                                fontSize: 15,
                                color: _ink,
                                fontWeight: n.read ? FontWeight.w500 : FontWeight.bold,
                              )),
                          const SizedBox(height: 4),
                          Text(n.body, style: const TextStyle(fontSize: 14, color: _muted, height: 1.4)),
                          const SizedBox(height: 8),
                          Text(n.time, style: const TextStyle(fontSize: 12, color: _link)),
                        ],
                      ),
                    ),
                    if (!n.read)
                      Container(
                        margin: const EdgeInsets.only(top: 6, left: 8),
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(color: _orange, shape: BoxShape.circle),
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildEmpty() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.notifications_none, size: 64, color: _muted),
            const SizedBox(height: 12),
            const Text('Belum ada notifikasi',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: _ink)),
            const SizedBox(height: 6),
            const Text('Kabar tentang pesanan dan pesanmu akan muncul di sini.',
                textAlign: TextAlign.center, style: TextStyle(fontSize: 14, color: _muted)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/catalog-search'),
              style: ElevatedButton.styleFrom(
                backgroundColor: _orangeSoft,
                foregroundColor: _ink,
                elevation: 0,
                padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
              ),
              child: const Text('Jelajahi Jasa', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}
