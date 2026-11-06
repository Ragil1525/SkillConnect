import 'package:flutter/material.dart';

class DebugNavigationScreen extends StatelessWidget {
  const DebugNavigationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Daftar halaman dikelompokkan dengan benar di dalam method build
final pages = [
      // 1. Halaman Umum (Common)
      {'title': 'Landing Page', 'route': '/landing'},
      {'title': 'Login Screen', 'route': '/login'},
      {'title': 'Register Screen', 'route': '/register'},
      {'title': 'Notification Screen', 'route': '/notification'},
      {'title': 'Profile Screen', 'route': '/profile'},

      // 2. Halaman Customer
      {'title': 'Customer Home', 'route': '/customer-home'},
      {'title': 'Catalog Search', 'route': '/catalog-search'},
      {'title': 'Service Detail', 'route': '/service-detail'},
      {'title': 'Booking Form', 'route': '/booking-form'},
      {'title': 'Payment Screen', 'route': '/payment'},
      {'title': 'Order List', 'route': '/order-list'},
      {'title': 'Order Detail', 'route': '/order-detail'},
      {'title': 'Order Confirm', 'route': '/order-confirm'},
      {'title': 'Review & Rating', 'route': '/review-rating'},

      // 3. Halaman Service Provider
      {'title': 'Provider Activation', 'route': '/provider-activate'},
      {'title': 'Provider Dashboard', 'route': '/provider-dashboard'},
      {'title': 'Manage Service', 'route': '/manage-service'},
      {'title': 'Form Service', 'route': '/form-service'},
      {'title': 'Incoming Order', 'route': '/incoming-order'},
      {'title': 'Job Detail', 'route': '/job-detail'},
      {'title': 'Payout Screen', 'route': '/payout'},

      // 4. Halaman Admin
      {'title': 'Admin Dashboard', 'route': '/admin-dashboard'},
      {'title': 'User Management', 'route': '/user-management'},
      {'title': 'Category Management', 'route': '/category-management'},
      {'title': 'Transaction Dispute', 'route': '/transaction-dispute'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('🔧 SkillConnect - Debug Navigation'),
        backgroundColor: const Color(0xFF1E293B),
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: pages.length,
        itemBuilder: (context, index) {
          final page = pages[index];
          return Card(
            elevation: 2,
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: ListTile(
              title: Text(
                page['title']!,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              subtitle: Text(
                'Route: ${page['route']}',
                style: TextStyle(color: Colors.grey.shade600),
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.blue),
              onTap: () {
                Navigator.pushNamed(context, page['route']!);
              },
            ),
          );
        },
      ),
    );
  }
}