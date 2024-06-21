import 'package:get_storage/get_storage.dart';

class StorageRepository {
  static Future<void> saveOffline(String key, dynamic value) async {
    final storage = GetStorage();
    await storage.write(key, value);
  }

  static Future<dynamic> getOfflineKey(String key) async {
    final storage = GetStorage();
    return await storage.read(key);
  }

  static Future<dynamic> deleteOfflineKey(String key) async {
    final storage = GetStorage();
    return await storage.remove(key);
  }

  static Future<void> destroyOfflineStorage() async {
    final storage = GetStorage();
    await storage.erase();
  }

  
}
