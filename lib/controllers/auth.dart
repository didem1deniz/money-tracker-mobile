import '../api/api.dart';

class LoginController {
  // ✅ LOGIN
  Future<bool> handle(String identifier, String password) async {
    try {
      // İlk deneme: username ile login
      final response = await Api.post('/api/login', {
        'username': identifier,
        'password': password,
      });

      print("✅ Login başarılı (username): $response");
      return true; // ✅ Başarılı giriş
    } catch (e) {
      print("⚠️ Username login başarısız, email ile denenecek...");

      try {
        // İkinci deneme: email ile login (fallback)
        final response = await Api.post('/api/login', {
          'email': identifier,
          'password': password,
        });

        print("✅ Login başarılı (email): $response");
        return true; // ✅ Başarılı giriş (email ile)
      } catch (err) {
        print("❌ Login hatası: $err");
        return false; // ❌ Giriş başarısız
      }
    }
  }

  // ✅ REGISTER
  Future<bool> register(String username, String email, String password) async {
    try {
      final response = await Api.post('/api/register', {
        'username': username,
        'email': email,
        'password': password,
      });

      print("✅ Register başarılı: $response");

      // TODO: Token kaydetme işlemi (SharedPreferences ile)
      return true;
    } catch (e) {
      print("❌ Register hatası: $e");
      return false;
    }
  }
}
