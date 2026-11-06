import 'package:flutter/material.dart';

class TransactionDisputeScreen extends StatefulWidget {
  const TransactionDisputeScreen({super.key});

  @override
  State<TransactionDisputeScreen> createState() => _TransactionDisputeScreenState();
}

class _TransactionDisputeScreenState extends State<TransactionDisputeScreen> {
  // Data Dummy Sengketa Transaksi
final List<Map<String, String>> _disputes = [
    {
      'id': 'DSP-001',
      'orderId': 'ORD-2026-003',
      'title': 'Hasil Pekerjaan Tidak Sesuai Deskripsi',
      'customer': 'Andi Pratama',
      'provider': 'Ragil P.',
      'reason': 'Provider tidak merespons revisi dan mengirimkan berkas yang tidak lengkap.',
      'date': '02 Nov 2026',
    },
    {
      'id': 'DSP-002',
      'orderId': 'ORD-2026-008',
      'title': 'Pekerjaan Terlambat dari Tenggat Waktu',
      'customer': 'Siti Aminah',
      'provider': 'Bara Pratama',
      'reason': 'Sudah melewati batas waktu 3 hari tapi progres belum diserahkan sama sekali.',
      'date': '01 Nov 2026',
    },
  ];

  void _resolveDispute(String id, String resolution) {
    setState(() {
      _disputes.removeWhere((item) => item['id'] == id);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Sengketa $id diselesaikan: $resolution'),
        backgroundColor: Colors.indigo,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pusat Sengketa Transaksi'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: _disputes.isEmpty
          ? const Center(
              child: Text(
                'Tidak ada sengketa transaksi aktif saat ini.',
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _disputes.length,
              itemBuilder: (context, index) {
                final dispute = _disputes[index];

                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.only(bottom: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${dispute['id']} (${dispute['orderId']})',
                              style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
                            ),
                            Text(
                              dispute['date']!,
                              style: const TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                          ],
                        ),
                        const Divider(height: 16),
                        Text(
                          dispute['title']!,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.red,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text('Pelapor (Customer): ${dispute['customer']}'),
                        Text('Terlapor (Provider): ${dispute['provider']}'),
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            'Alasan: ${dispute['reason']}',
                            style: const TextStyle(fontSize: 13),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: Colors.orange,
                                  side: const BorderSide(color: Colors.orange),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                onPressed: () => _resolveDispute(dispute['id']!, 'Refund ke Customer'),
                                child: const Text('Refund Customer', textAlign: TextAlign.center),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                onPressed: () => _resolveDispute(dispute['id']!, 'Cairkan ke Provider'),
                                child: const Text('Cairkan Provider', textAlign: TextAlign.center),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}