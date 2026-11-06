import 'package:flutter/material.dart';

class BookingFormScreen extends StatefulWidget {
  const BookingFormScreen({super.key});

  @override
  State<BookingFormScreen> createState() => _BookingFormScreenState();
}

class _BookingFormScreenState extends State<BookingFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _requirementController = TextEditingController();
  final _scheduleController = TextEditingController();
  final _locationController = TextEditingController();
  
  String _selectedDeliveryMethod = 'File Digital';
  final List<String> _deliveryMethods = [
    'File Digital',
    'Diambil Customer',
    'Diantar Provider',
    'Kurir Pihak Ketiga'
  ];

  @override
  Widget build(BuildContext context) {
    // Menerima data jasa dari halaman sebelumnya (Detail Jasa)
    final Map<String, dynamic> service = 
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>? ?? {
          'title': 'Jasa Layanan',
          'price': '0',
        };

    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Pemesanan Jasa'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Ringkasan Jasa yang Dipesan
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.deepPurple.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Jasa yang Dipilih:',
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            service['title'] ?? '',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      'Rp ${service['price'] ?? '0'}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Kebutuhan / Detail Tugas
              const Text(
                'Detail Kebutuhan & Catatan',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _requirementController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'Jelaskan detail atau spesifikasi tugas yang kamu inginkan...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Detail kebutuhan tidak boleh kosong';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Jadwal / Tenggat Waktu
              const Text(
                'Jadwal Pengerjaan / Deadline',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _scheduleController,
                decoration: InputDecoration(
                  hintText: 'Contoh: 3 Hari / 25 November 2026',
                  prefixIcon: const Icon(Icons.calendar_today, color: Colors.deepPurple),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Jadwal wajib diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Lokasi Pengerjaan
              const Text(
                'Lokasi Pengerjaan',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _locationController,
                decoration: InputDecoration(
                  hintText: 'Masukkan lokasi pengerjaan (jika diperlukan)',
                  prefixIcon: const Icon(Icons.location_on, color: Colors.deepPurple),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Metode Penyerahan Hasil
              const Text(
                'Metode Penyerahan Hasil',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: _selectedDeliveryMethod,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                items: _deliveryMethods.map((String method) {
                  return DropdownMenuItem<String>(
                    value: method,
                    child: Text(method),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedDeliveryMethod = newValue!;
                  });
                },
              ),
              const SizedBox(height: 32),

              // Tombol Lanjut ke Pembayaran
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
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Kumpulkan data pesanan untuk dikirim ke halaman pembayaran (Halaman 9)
                      final bookingData = {
                        ...service,
                        'requirement': _requirementController.text,
                        'schedule': _scheduleController.text,
                        'location': _locationController.text,
                        'delivery_method': _selectedDeliveryMethod,
                      };

                      // Navigasi ke Halaman Pembayaran (Halaman 9)
                      Navigator.pushNamed(
                        context,
                        '/payment',
                        arguments: bookingData,
                      );
                    }
                  },
                  child: const Text(
                    'Lanjut ke Pembayaran',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}