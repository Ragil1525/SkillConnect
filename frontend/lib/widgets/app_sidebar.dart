import 'package:flutter/material.dart';

class AppSidebar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const AppSidebar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            // Header Sidebar
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue.shade50),
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.connect_without_contact, size: 40, color: Colors.blue),
                    SizedBox(height: 8),
                    Text(
                      'SkillConnect',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            // Menu Navigasi Sidebar
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Beranda'),
              selected: currentIndex == 0,
              selectedColor: Colors.blue,
              onTap: () => onTap(0),
            ),
            ListTile(
              leading: const Icon(Icons.list_alt),
              title: const Text('Pesanan'),
              selected: currentIndex == 1,
              selectedColor: Colors.blue,
              onTap: () => onTap(1),
            ),
            ListTile(
              leading: const Icon(Icons.notifications),
              title: const Text('Notifikasi'),
              selected: currentIndex == 2,
              selectedColor: Colors.blue,
              onTap: () => onTap(2),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profil'),
              selected: currentIndex == 3,
              selectedColor: Colors.blue,
              onTap: () => onTap(3),
            ),
          ],
        ),
      ),
    );
  }
}