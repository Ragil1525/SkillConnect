import 'package:flutter/material.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard - SkillConnect'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner Statistik Utama
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.indigo, Colors.blueAccent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Total Pendapatan Komisi (10%)',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Rp 4.850.000',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text('Total Pengguna: 142', style: TextStyle(color: Colors.white70)),
                      Text('Total Transaksi: 85', style: TextStyle(color: Colors.white70)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Menu Manajemen Admin
            const Text(
              'Panel Kontrol Administrator',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.3,
              children: [
                _buildAdminMenuCard(
                  context,
                  title: 'Verifikasi Provider',
                  icon: Icons.verified_user,
                  color: Colors.orange,
                  onTap: () => Navigator.pushNamed(context, '/admin-verify'),
                ),
                _buildAdminMenuCard(
                  context,
                  title: 'Kelola Pengguna',
                  icon: Icons.people,
                  color: Colors.blue,
                  onTap: () => Navigator.pushNamed(context, '/admin-users'),
                ),
                _buildAdminMenuCard(
                  context,
                  title: 'Kelola Komisi',
                  icon: Icons.monetization_on,
                  color: Colors.green,
                  onTap: () => Navigator.pushNamed(context, '/admin-commission'),
                ),
                _buildAdminMenuCard(
                  context,
                  title: 'Pusat Sengketa',
                  icon: Icons.report_problem,
                  color: Colors.red,
                  onTap: () => Navigator.pushNamed(context, '/admin-dispute'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAdminMenuCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 36, color: color),
              const SizedBox(height: 10),
              Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}