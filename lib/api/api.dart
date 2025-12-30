import 'dart:convert';
import 'package:http/http.dart' as http;

class Api {
  // ✅ Base URL (Vercel deployment)
  static const String baseUrl = 'https://money-tracker-api-eight.vercel.app';

  // ✅ API sağlık kontrolü
  static Future<bool> testConnection() async {
    try {
      final url = Uri.parse('$baseUrl/health'); // Ya da herhangi bir endpoint
      print('🔄 Testing API connection to: $url');
      
      final response = await http.get(
        url,
        headers: {'Content-Type': 'application/json'},
      ).timeout(const Duration(seconds: 10));

      print('✅ API Response: ${response.statusCode}');
      print('Response body: ${response.body}');
      
      return response.statusCode >= 200 && response.statusCode < 300;
    } catch (e) {
      print('❌ API Connection failed: $e');
      return false;
    }
  }

  // ✅ POST isteği
  static Future<dynamic> post(String path, Map<String, dynamic> body) async {
    final url = Uri.parse('$baseUrl$path');
    print('➡️ POST $url');
    print('Body: $body');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );

    print('⬅️ Response: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode >= 200 && response.statusCode < 300) {
      // Başarılıysa JSON'u döndür
      return jsonDecode(response.body);
    } else {
      // ❗️Hata olduğunda backend'in "message" alanını yakala
      try {
        final bodyDecoded = jsonDecode(response.body);
        final message = bodyDecoded['message'] ?? 'Request failed';
        throw Exception('Request failed: ${response.statusCode} - $message');
      } catch (_) {
        // Eğer JSON parse edilemezse, sadece status code göster
        throw Exception('Request failed: ${response.statusCode}');
      }
    }
  }
}
