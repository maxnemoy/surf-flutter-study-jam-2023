part of '../i_local_storage.dart';

@Singleton(as: ILocalStorage, env: [Environment.dev])
class LocalStorage implements ILocalStorage {
  final FlutterSecureStorage storage;
  LocalStorage() : storage = const FlutterSecureStorage();

  @override
  Future<String> read({required String key}) async {
    return await storage.read(key: key) ?? "";
  }

  @override
  Future write({required String key, required String? value}) async {
    await storage.write(key: key, value: value);
  }
}
