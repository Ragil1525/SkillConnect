import 'package:flutter/material.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String _selectedPaymentMethod = 'DANA';
  bool _isProcessing = false;

final List<Map<String, String>> _paymentMethods = [
    {'name': 'DANA', 'icon': 'assets/dana.png', 'type': 'E-Wallet'},
    {'name': 'ShopeePay', 'icon': 'assets/shopeepay.png', 'type': 'E-Wallet'},
    {'name': 'Transfer Bank (VA)', 'icon': 'assets/bank.png', 'type': 'Virtual Account'},
    {'name': 'QRIS', 'icon': 'assets/qris.png', 'type': 'Instant Payment'},
  ];
  @override
  Widget build(BuildContext context) {
    // Menerima data pesanan dari halaman Form Pemesanan
    final Map<String, dynamic> bookingData = 
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>? ?? {
          'title': 'Jasa Layanan',
          'price': '150000',
          'delivery_method': 'File Digital',
        };

    // Kalkulasi Biaya (Contoh sederhana)
    final double rawPrice = double.tryParse(bookingData['price'].toString().replaceAll('.', '')) ?? 150000;
    const double serviceFee = 5000; // Biaya layanan platform SkillConnect
    final double totalPrice = rawPrice + serviceFee;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pembayaran Pesanan'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Card Rincian Pesanan
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Ringkasan Pesanan',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Jasa Dipesan:'),
                        Flexible(
                          child: Text(
                            bookingData['title'] ?? '',
                            textAlign: TextAlign.end,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Metode Penyerahan:'),
                        Text(
                          bookingData['delivery_method'] ?? 'File Digital',
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Card Rincian Biaya
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Rincian Pembayaran',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Harga Jasa'),
                        Text('Rp ${rawPrice.toInt()}'),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                    const Text('Biaya Layanan Platform'),
                        Text('Rp ${serviceFee.toInt()}'),
                      ],
                    ),
                    const Divider(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total Pembayaran',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Rp ${totalPrice.toInt()}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Pilihan Metode Pembayaran
            const Text(
              'Pilih Metode Pembayaran',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _paymentMethods.length,
              itemBuilder: (context, index) {
                final method = _paymentMethods[index];
                final isSelected = _selectedPaymentMethod == method['name'];

                return Card(
                  elevation: isSelected ? 3 : 1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                      color: isSelected ? Colors.deepPurple : Colors.grey.shade300,
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  child: ListTile(
                    leading: const Icon(Icons.account_balance_wallet, color: Colors.deepPurple),
                    title: Text(
                      method['name']!,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(method['type']!),
                    trailing: Radio<String>(
                      value: method['name']!,
                      groupValue: _selectedPaymentMethod,
                      activeColor: Colors.deepPurple,
                      onChanged: (String? value) {
                        setState(() {
                          _selectedPaymentMethod = value!;
                        });
                      },
                    ),
                    onTap: () {
                      setState(() {
                        _selectedPaymentMethod = method['name']!;
                      });
                    },
                  ),
                );
              },
            ),
            const SizedBox(height: 32),

            // Tombol Konfirmasi Pembayaran
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: _isProcessing
                    ? null
                    : () async {
                        setState(() => _isProcessing = true);

                        // Simulasi proses konfirmasi/webhook ke backend Express.js
                        await Future.delayed(const Duration(seconds: 2));

                        if (!mounted) return;
                        setState(() => _isProcessing = false);

                        // Tampilkan Notifikasi Sukses
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Pembayaran Berhasil! Pesanan diteruskan ke Provider.'),
                            backgroundColor: Colors.green,
                          ),
                        );

                        // Navigasi ke Halaman Daftar Pesanan (Halaman 10)
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          '/order-list',
                          (route) => route.isFirst,
                        );
                      },
                child: _isProcessing
                    ? const CircularProgressIndicator(color: Colors.white)
                    : Text(
                        'Bayar Sekarang (Rp ${totalPrice.toInt()})',
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}