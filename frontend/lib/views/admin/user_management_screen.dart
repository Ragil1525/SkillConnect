import 'package:flutter/material.dart';

class UserManagementScreen extends StatefulWidget {
  const UserManagementScreen({super.key});

  @override
  State<UserManagementScreen> createState() => _UserManagementScreenState();
}

class _UserManagementScreenState extends State<UserManagementScreen> {
  final List<Map<String, String>> _users = [
    {'name': 'Andi Pratama', 'role': 'Customer', 'email': 'andi@gmail.com', 'status': 'Aktif'},
    {'name': 'Ragil P.', 'role': 'Service Provider', 'email': 'ragil@gmail.com', 'status': 'Aktif'},
    {'name': 'Siti Aminah', 'role': 'Customer', 'email': 'siti@gmail.com', 'status': 'Aktif'},
    {'name': 'Bara Pratama', 'role': 'Service Provider', 'email': 'bara@gmail.com', 'status': 'Pending'},
  ];

  void _toggleStatus(int index) {
    setState(() {
      _users[index]['status'] = _users[index]['status'] == 'Aktif' ? 'Diblokir' : 'Aktif';
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Status pengguna berhasil diubah.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kelola Pengguna'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _users.length,
        itemBuilder: (context, index) {
          final user = _users[index];
          bool isActive = user['status'] == 'Aktif';

          return Card(
            elevation: 1,
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              title: Text(user['name']!, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('${user['role']} • ${user['email']}'),
              trailing: TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: isActive ? Colors.red : Colors.green,
                ),
                onPressed: () => _toggleStatus(index),
                child: Text(isActive ? 'Blokir' : 'Aktifkan'),
              ),
            ),
          );
        },
      ),
    );
  }
}