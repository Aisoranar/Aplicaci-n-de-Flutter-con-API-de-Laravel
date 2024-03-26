import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage {
  static const _key = 'access_token';
  final _storage = FlutterSecureStorage();

  Future<String?> readToken() async {
    try {
      return await _storage.read(key: _key);
    } catch (e) {
      // Manejar errores de lectura de token, como permisos insuficientes o almacenamiento no disponible
      print('Error reading token: $e');
      return null;
    }
  }

  Future<void> saveToken(String token) async {
    try {
      await _storage.write(key: _key, value: token);
    } catch (e) {
      // Manejar errores de escritura de token, como permisos insuficientes o almacenamiento no disponible
      print('Error saving token: $e');
    }
  }

  Future<void> deleteToken() async {
    try {
      await _storage.delete(key: _key);
    } catch (e) {
      // Manejar errores al eliminar el token, como permisos insuficientes o almacenamiento no disponible
      print('Error deleting token: $e');
    }
  }
}
