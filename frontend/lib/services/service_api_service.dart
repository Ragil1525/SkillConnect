import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/service_model.dart';

class ServiceApiService {
  final String baseUrl = 'http://10.0.2.2:3000/api/services';

  Future<List<ServiceModel>> fetchServices() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        return body.map((dynamic item) => ServiceModel.fromJson(item)).toList();
      } else {
        throw Exception('Gagal memuat data layanan');
      }
    } catch (e) {
      throw Exception('Terjadi kesalahan: $e');
    }
  }

  Future<bool> createService(Map<String, dynamic> serviceData) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(serviceData),
      );
      return response.statusCode == 201 || response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}