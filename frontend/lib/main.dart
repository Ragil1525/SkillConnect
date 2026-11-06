import 'package:flutter/material.dart';

// Import Halaman Umum (Common)
import 'views/common/debug_navigation_screen.dart';
import 'views/common/login_screen.dart';
import 'views/common/register_screen.dart';
import 'views/common/notification_screen.dart';
import 'views/common/profile_screen.dart';
import 'views/common/landing_screen.dart';

// Import Halaman Customer
import 'views/customer/customer_home_screen.dart';
import 'views/customer/catalog_search_screen.dart';
import 'views/customer/service_detail_screen.dart';
import 'views/customer/booking_form_screen.dart';
import 'views/customer/payment_screen.dart';
import 'views/customer/order_list_screen.dart';
import 'views/customer/order_detail_screen.dart';
import 'views/customer/order_confirm_screen.dart';
import 'views/customer/review_rating_screen.dart';

// Import Halaman Service Provider
import 'views/provider/provider_activate_screen.dart';
import 'views/provider/provider_dashboard_screen.dart';
import 'views/provider/manage_service_screen.dart';
import 'views/provider/form_service_screen.dart';
import 'views/provider/incoming_order_screen.dart';
import 'views/provider/job_detail_screen.dart';
import 'views/provider/payout_screen.dart';

// Import Halaman Admin
import 'views/admin/admin_dashboard_screen.dart';
import 'views/admin/user_management_screen.dart';
import 'views/admin/category_management_screen.dart';
import 'views/admin/transaction_dispute_screen.dart';


void main() {
  runApp(const SkillConnectApp());
}

class SkillConnectApp extends StatelessWidget {
  const SkillConnectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SkillConnect',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // Halaman awal saat aplikasi dibuka
      initialRoute: '/debug-nav',
      // Daftar rute ke seluruh 24 halaman
      routes: {
        // A. Halaman Umum (4 Halaman)
        '/debug-nav': (context) => const DebugNavigationScreen(),
        '/landing': (context) => const LandingScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/notification': (context) => const NotificationScreen(),
        '/profile': (context) => const ProfileScreen(),

        // B. Halaman Customer (9 Halaman)
        '/customer-home': (context) => const CustomerHomeScreen(),
        '/catalog-search': (context) => const CatalogSearchScreen(),
        '/service-detail': (context) => const ServiceDetailScreen(),
        '/booking-form': (context) => const BookingFormScreen(),
        '/payment': (context) => const PaymentScreen(),
        '/order-list': (context) => const OrderListScreen(),
        '/order-detail': (context) => const OrderDetailScreen(),
        '/order-confirm': (context) => const OrderConfirmScreen(),
        '/review-rating': (context) => const ReviewRatingScreen(),

        // C. Halaman Service Provider (7 Halaman)
        '/provider-activate': (context) => const ProviderActivateScreen(),
        '/provider-dashboard': (context) => const ProviderDashboardScreen(),
        '/manage-service': (context) => const ManageServiceScreen(),
        '/form-service': (context) => const FormServiceScreen(),
        '/incoming-order': (context) => const IncomingOrderScreen(),
        '/job-detail': (context) => const JobDetailScreen(),
        '/payout': (context) => const PayoutScreen(),

        // D. Halaman Admin (4 Halaman)
        '/admin-dashboard': (context) => const AdminDashboardScreen(),
        '/user-management': (context) => const UserManagementScreen(),
        '/category-management': (context) => const CategoryManagementScreen(),
        '/transaction-dispute': (context) => const TransactionDisputeScreen(),
      },
    );
  }
}