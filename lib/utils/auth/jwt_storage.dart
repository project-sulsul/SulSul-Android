import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class JwtStorage {
  final _storage = const FlutterSecureStorage();
  static const key = 'jwt';

  Future<void> set(String jwt) async {
    await _storage.write(key: key, value: jwt);
  }

  Future<String> get() async {
    return await _storage.read(key: key) ?? '';
  }

  Future<void> expire() async {
    await _storage.delete(key: key);
  }
}

final jwtStorage = JwtStorage();
