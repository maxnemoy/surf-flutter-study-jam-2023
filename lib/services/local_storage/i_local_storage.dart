import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

part './impl/local_storage.dart';

abstract class ILocalStorage {
  Future<String> read({required String key});
  Future write({required String key, required String? value});
}
